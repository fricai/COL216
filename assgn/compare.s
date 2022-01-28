	.global compare
	@ only compare is externally accessible

first_ineq:
	@ r0 = first_ineq(r0, r1)
	@
	@ it takes in the the pointers to the strings in r0, r1
	@  it returns the first unequal index in the two strings
	@  if we do a case-sensitive comparison
	@
	@ The code in C is, if the input is (char *a, char *b)
	@
	@ int i = 0;
	@ loop:
	@ if (a[i] == '\0') goto terminate;
	@ if (b[i] == '\0') goto terminate;
	@ if (a[i] != b[i]) goto terminate;
	@ ++i; goto loop;
	@ terminate: return i;

	@ store the registers r4-r7 along with lr in the stack
	@ we'll use them in the function, we'll restore them at the end
	stmfd sp!, {r4-r7,lr}

	mov r4, #0 @ i = 0
	mov r5, r0 @ pointer to the first string
	mov r6, r1 @ pointer to the second string
first_ineq_loop:
	@ if (a[i] == '\0')
	ldrb r7, [r5, r4] @ a[i] is a single byte so we use ldrb instead of ldr
	cmp r7, #0
	beq terminate_first_ineq
	
	@ if (b[i] == '\0')
	ldrb r0, [r6, r4]
	cmp r0, #0
	beq terminate_first_ineq

	@ if (a[i] != b[i])
	cmp r0, r7
	bne terminate_first_ineq

	@ ++i
	add r4, #1
	b first_ineq_loop
terminate_first_ineq:
	mov r0, r4
	ldmfd sp!, {r4-r7,pc}

to_lower:
	@ r0 = to_lower(r0)
	@
	@ it takes in a character in r0 and returns it in r0 after
	@ converting uppercase alphabet to lowercase alphabet
	@
	@ The code in C, if input is (char c) is
	@ 
	@ if c < 'A': goto terminate
	@ if c > 'Z': goto terminate
	@ c += 'a' - 'A'
	@ return c

	cmp r0, #65 @ compare with 'A'
	blt terminate_to_lower
	cmp r0, #90 @ compare with 'Z'
	bgt terminate_to_lower
	add r0, r0, #32 @ increment by 'a' - 'A'
terminate_to_lower:
	mov pc, lr

first_ineq_insensitive:
	@ it does the same as first_ineq but the comparison is case-insensitive
	@
	@ The code in C is, if the input is (char *a, char *b)
	@
	@ int i = 0;
	@ loop:
	@ if (a[i] == '\0') goto terminate;
	@ if (b[i] == '\0') goto terminate;
	@ if (to_lower(a[i]) != to_lower(b[i])) goto terminate;
	@ ++i; goto loop;
	@ terminate: return i;

	stmfd sp!, {r4-r7,lr}
	mov r4, #0 @ i = 0
	mov r5, r0 @ pointer to the first string
	mov r6, r1 @ pointer to the second string
first_ineq_loop_insensitive:
	@ r7 contains a[i]
	ldrb r7, [r5, r4]
	cmp r7, #0
	beq terminate_first_ineq

	@ r0 contains b[i]
	ldrb r0, [r6, r4]
	cmp r0, #0
	beq terminate_first_ineq_insensitive

	bl to_lower
	@ r0 now contains to_lower(b[i])

	@ swap r0, r7
	eor r0, r0, r7
	eor r7, r0, r7
	eor r0, r0, r7

	bl to_lower
	@ r0 contains to_lower(a[i]) and r7 contains to_lower(b[i])

	cmp r0, r7
	bne terminate_first_ineq_insensitive

	add r4, #1
	b first_ineq_loop_insensitive
terminate_first_ineq_insensitive:
	mov r0, r4
	ldmfd sp!, {r4-r7,pc}

compare:
	@ r0 = compare(r0, r1, r2)
	@ 
	@ it takes in pointers to string in r0, r1
	@  and an integer parameter in r2
	@ if r2 stores 0 we do a case-sensitive comparison
	@  we do a case-insensitive comparison otherwise
	@ 
	@ it returns {-1, 0, +1} in r0 if the first string is 
	@  {less than, equal to, greater than} second string

	@ The code in C if the arguments are (char* a, char* b, int type)
	@
	@ if (type == 0) {
	@ 	int i = first_ineq(a, b);
	@ 	if (a[i] == b[i]) return 0;
	@ 	else if (a[i] < b[i]) return -1;
	@	else return 1;
	@ } else {
	@	int i = first_ineq_sensitive(a, b);
	@	if (to_lower(a[i]) == to_lower(b[i])) return 0;
	@ 	else if (to_lower(a[i]) < to_lower(b[i])) return -1;
	@	else return 1;
	@ }
	@

	stmfd sp!, {r4,r5,lr}

	mov r4, r0
	mov r5, r1
	@ r4, r5 stores the two input pointers

	cmp r2, #0
	beq case_sensitive_compare @ branch if (type == 0)

	@ Case insensitive compare: if (type != 0)

	bl first_ineq_insensitive
	@ i is stored in r0 now, note that
	@  r0, r1 contained the two strings before the call

	ldrb r4, [r4, r0] @ r4 = a[i]
	ldrb r5, [r5, r0] @ r5 = b[i]

	mov r0, r4
	bl to_lower
	mov r4, r0 @ r4 = to_lower(a[i])

	mov r0, r5
	bl to_lower
	mov r5, r0 @ r5 = to_lower(b[i])

	cmp r4, r5
	movlt r0, #-1
	moveq r0, #0
	movgt r0, #1

	b terminate_compare
case_sensitive_compare:
	@ if (type == 0)

	bl first_ineq
	@ i is stored in r0

	ldrb r1, [r4, r0] @ r1 = a[i]
	ldrb r2, [r5, r0] @ r2 = b[i]

	cmp r1, r2
	movlt r0, #-1
	moveq r0, #0
	movgt r0, #1
terminate_compare:
	ldmfd sp!, {r4,r5,pc}
