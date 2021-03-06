	.global merge
	.extern compare

	.text
merge:

	@ r0 = compare(r0, r1, r2, r3, below top of stack, top of stack)
	@ 
	@ - r0, r2 are pointers to the sorted list of strings
	@ - r1, r3 are the lengths of the two lists
	@ - if ([sp, #4] & 1) = 0, then we do a case-insensitive compare
	@ - if ([sp, #4] & 2) = 0,
	@	- then we don't remove duplicates
	@ 	- else we delete duplicate strings
	@	
	@	  in this case, no duplicates should be present in the 
	@	  input lists either
	@ - [sp] is the pointer to the final output list
	@ 
	@ - r0 will return the length of the output list

	@
	@ Takes in 5 inputs
	@ char** a, int n, char** b, int m, int mode, char** c
	@  - a, b being the pointer to the two list of string pointers
	@  - n, m, the length of the two lists
	@  - comparison and merging mode
	@  - c, output list
	@ it returns a single int, the length of the final list

	@ The C code is given by
	@ int merge(char** a, int n, char** b, int m, int mode, char** c) {
	@	int i = 0, j = 0, k = 0;
	@	while (i < n && j < m) {
	@		int val = compare(a[i], b[j], mode & 1);
	@		if (val < 0) c[k++] = a[i++];
	@		else if (val > 0) c[k++] = b[j++];
	@		else {
	@		    if ((mode & 2) != 0) ++j;
	@		    c[k++] = a[i++];
	@		}
	@	}
	@	while (i < n) c[k++] = a[i++];
	@	while (j < m) c[k++] = b[j++];
	@	return k;
	@ }

	@ a + n = r7, b + m = r8, r9 = mode
	@ a + i = r4,
	@ b + j = r5,
	@ c + k = r6

	@ we use r4, r5, r6, r7, r8, r9 that needs to be saved
	stmfd sp!, {r4-r9, lr}
	@ [sp] -> r4
	@ [sp, #4] -> r5
	@ [sp, #8] -> r6
	@ [sp, #12] -> r7
	@ [sp, #16] -> r8
	@ [sp, #20] -> r9
	@ [sp, #24] -> lr
	@ [sp, #28] -> c
	@ [sp, #32] -> mode
	mov r4, r0 @ r4 = a
	mov r5, r2 @ r5 = b
	ldr r6, [sp, #28] @ r6 = c

	add r7, r0, r1, LSL #2
	add r8, r2, r3, LSL #2

	ldr r9, [sp, #32] @ r9 = mode

loop_both:
	@ if i == n or j == n goto terminate
	cmp r4, r7
	beq loop_a
	cmp r5, r8
	beq loop_a

	ldr r0, [r4] @ r0 = a + i
	ldr r1, [r5] @ r1 = b + j
	and r2, r9, #1 @ r2 = mode & 1
	bl compare
	@ r0 = -1 if a[i] < b[j], 0 if a[i] = b[j], +1 if a[i] > b[j]

	ldr lr, =loop_both @ load =loop into the link register
	@ load location before branching

	cmp r0, #0
	blt move_a
	bgt move_b
	@ r0 == 0 now
	@ check if mode & 2 == 0 or no
	@ if mode & 2 == 0, that means we don't delete
	and r0, r9, #2
	cmp r0, #0
	addne r5, #4 @ increment b + j
	b move_a

move_a:
	@ c[k++] = a[i++]
	ldr r12, [r4], #4 @ r12 = a[i++]
	str r12, [r6], #4 @ c[k++] = r12
	mov pc, lr

move_b:
	@ c[k++] = b[j++]
	ldr r12, [r5], #4 @ r12 = b[j++]
	str r12, [r6], #4 @ c[k++] = r12
	mov pc, lr
	
loop_a:
	@ if i == n go to loop_b
	cmp r4, r7
	beq loop_b
	ldr lr, =loop_a @ come back to loop_a at the end of move_a
	b move_a

loop_b:
	@ if j == m go to terminate
	cmp r5, r8
	beq terminate
	ldr lr, =loop_b @ come back to loop_b at the end of move_b
	b move_b

terminate:
	ldr r12, [sp, #28] @ r12 = c
	sub r0, r6, r12 @ r0 = (c + k) - c
	lsr r0, r0, #2 @ divide by 4

	@ ldmfd sp!, {r4-r9, lr}
	@ mov pc, lr
	ldmfd sp!, {r4-r9, pc}

	.end
