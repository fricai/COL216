	.extern input_string
	.extern output_string
	.extern output_new_line
	.extern atoi
	.extern merge

	.text
main:
	@ get the number of strings
	ldr r0, =get_case
	bl output_string
	ldr r0, =scratch
	bl input_string
	ldr r0, =scratch
	bl atoi
	mov r4, r0

	ldr r0, =get_dup
	bl output_string
	ldr r0, =scratch
	bl input_string
	ldr r0, =scratch
	bl atoi

	orr r4, r4, r0, LSL #1 @ we use mode = (dup << 1) | case
	stmfd sp!, {r4} @ place it onto stack rn

	ldr r0, =get_count1
	bl output_string
	ldr r0, =scratch
	bl input_string
	ldr r0, =scratch
	bl atoi
	mov r4, r0 @ store the number of strings in list 1

	ldr r0, =get_strings
	bl output_string

	ldr r0, =string_buffer
	ldr r9, =pointer_buffer
	mov r5, r0 @ location of list 1
	mov r8, #0
loop1:
	cmp r8, r4 @ r4 = number of strings
	beq input_list2
	str r0, [r9], #4
	bl input_string
	@ r0 = next place to input string
	add r8, r8, #1
	b loop1

input_list2:
	mov r7, r0 @ location of list 2

	ldr r0, =get_count2
	bl output_string
	ldr r0, =scratch
	bl input_string
	ldr r0, =scratch
	bl atoi
	mov r6, r0 @ store the number of strings in list 2

	ldr r0, =get_strings
	bl output_string

	mov r0, r7
	mov r8, #0
loop2:
	cmp r8, r6 @ r6 = number of strings
	beq test
	str r0, [r9], #4
	bl input_string
	@ r0 = next place to input string
	add r8, r8, #1
	b loop2

test:
	@ For calling merge,
	@ r0 = =pointer_buffer
	@ r1 = n = r4
	@ r2 = =pointer_buffer + 4 * n
	@ r3 = m = r6
	@ push mode onto stack
	@ push =pointer_buffer + 4 * (m + n) onto stack
	@    the last value should already be present in r9 I think

	@ mode was pushed onto the stack at the start
	stmfd sp!, {r9}
	ldr r0, =pointer_buffer
	mov r1, r4

	mov r2, #4
	mul r2, r2, r4
	add r2, r2, r0 @ r2 = =pointer_buffer + 4 * n
	mov r3, r6

	bl merge

	mov r4, r0 @ r0 stores length of list
	mov r8, #0
print_loop:
	cmp r8, r4
	beq terminate
	ldr r0, [r9], #4 @ r9 stores the lit of strings
	bl output_string
	bl output_new_line
	add r8, r8, #1
	b print_loop

terminate:
	mov r0, #0x18
	swi 0x123456

	.data
scratch:
	.space 16
	@ some scratch space

string_buffer:
	.space 4096
	@ buffer to store strings input by user

pointer_buffer:
	.space 1024
	@ buffer to store pointer to strings

get_count1:
	.asciz "Number of strings in the first list: "

get_count2:
	.asciz "Number of strings in the second list: "

get_strings:
	.asciz "Input the strings in a sorted order, each string on a new line:\n"

get_case:
	.asciz "Do a case-sensitive comparison (1 for case-sensitive comparison, 0 for case-insensitive): "

get_dup:
	.ascii "Remove duplicates from list, in case dulicates are to be removed no equal elements should be present in the same list (1 to remove duplicates, 0 to not remove): "

	.end
