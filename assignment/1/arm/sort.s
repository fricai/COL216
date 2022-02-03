	.extern merge
	.global sort, merge_sort

	.text

merge_sort:
	@ r0 = merge_sort(r0, r1, r2, r3)
	@ 
	@ - r0 is a array of string pointers to be sorted
	@ - r1 is length of input array
	@ - r2 is a parameter to affect the behaviour of program
	@   - if the lowest bit is set, we do case-sensitive compare
	@   - if the second bit is set, we remove duplicates
	@ - r3 is the location of the output sorted array
	@ r0 contains the length of the sorted array at the end

	@ In C, the function declaration is
	@ 
	@ int merge_sort(char** a, int len, int mode, char** res);
	@ 
	@ - a is array of string pointers to sort
	@ - len is the length of a
	@ - mode is a paramater to affect the behaviour of program
	@   - if the lowest bit is set, do something
	@   - if the second bit is set, do something else
	@ - res is the location of the output sorted array
	@ 
	@ the function returns the length of the sorted array, ie, res
	@
	@ The definition is
	@
	@ char** buffer;
	@ int merge_sort(char** a, int len, int mode, char** res) {
	@	if (len == 1) {
	@		res[0] = a[0];
	@		return len;
	@	}
	@ 	int half = len / 2;
	@ 	int L = merge_sort(a, half, mode, res);
	@ 	int R = merge_sort(a + half, len - half, mode, res + half);
	@	int new_len = merge(res, L, res + half, R, mode, buffer);
	@	for (int i = 0; i < new_len; ++i)
	@		res[i] = buffer[i];
	@ 	return new_len;
	@ }

	cmp r1, #1
	beq single

	stmfd sp!, {r4-r9, lr}
	mov r4, r0
	mov r5, r1
	mov r6, r2
	mov r7, r3

	@ merge_sort(a, half, mode, res)

	@ r0 = a = r0
	@ r1 = len >> 1 = r1 >> 1
	@ r2 = mode = r2
	@ r3 = res = r3

	lsr r1, r1, #1
	bl merge_sort
	@ store r0 somewhere, i choose r8
	mov r8, r0 @ L

	@ r0 = a + ((len >> 1) << 2) = r4 + ((r5 >> 1) << 2)
	@ r1 = len - (len >> 1) = r5 - (r5 >> 1)
	@ r2 = mode = r6
	@ r3 = res + ((len >> 1) << 2) = r7 + ((r5 >> 1) << 2)

	lsr r0, r5, #1
	add r0, r4, r0, LSL #2

	sub r1, r5, r5, LSR #1

	mov r2, r6

	lsr r3, r5, #1
	add r3, r7, r3, LSL #2

	bl merge_sort

	mov r9, r0 @ R

	@ r0 = res = r7
	@ r1 = L = r8
	@ r2 = res + ((len >> 1) << 2) = r7 + ((r5 >> 1) << 2)
	@ r3 = R = r9
	@ push mode = r6 onto the stack
	@ push =buffer onto the stack
	stmfd sp!, {r6}

	ldr r0, =buffer
	stmfd sp!, {r0} @ look into better way of doing this

	mov r0, r7
	mov r1, r8

	lsr r2, r5, #1
	add r2, r7, r2, LSL #2

	mov r3, r9

	bl merge

	@ r0 = new_len
	@ remove top two elements from stack
	ldmfd sp!, {r1, r2} @ we don't care about these

	@ r1 = =buffer
	@ r2 = =buffer + 4 * new_len
	@ r3 = res
	ldr r1, =buffer
	add r2, r1, r0, LSL #2
	mov r3, r7

copy_loop:
	cmp r1, r2 @ if *buffer[i] == buffer + 4 * new_len
	beq terminate

	ldr r12, [r1], #4 @ r12 = buffer[i++]
	str r12, [r3], #4 @ res[i++] = r12

	b copy_loop

terminate:
	@ r0 should have new_len here
	ldmfd sp!, {r4-r9, pc}

single: @ len == 1
	@ copy from [r0] to [r3]
	ldr r12, [r0] @ r12 = a[0]
	str r12, [r3] @ res[0] = r12
	mov r0, #1 @ r0 = 1
	mov pc, lr @ return

sort:
	@ r0, r1 = merge_sort(r0, r1, r2)
	@ 
	@ - r0 is a array of string pointers to be sorted
	@ - r1 is length of input array
	@ - r2 is a parameter to affect the behaviour of program
	@   - if the lowest bit is set, we do case-sensitive compare
	@   - if the second bit is set, we remove duplicates
	@
	@ - r0 contains the location of the sorted array at the end
	@ - r1 contains the length of the sorted array at the end

	stmfd sp!, {lr}
	ldr r3, =result

	bl merge_sort

	mov r1, r0 @ store length in r1
	ldr r0, =result
	ldmfd sp!, {pc}

	.data

buffer:
	.space 4096
result:
	.space 4096

	.end
