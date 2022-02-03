	.extern input_string, input_number
	.extern output_string, output_new_line
	.extern sort

	.text
main:
	ldr r0, =get_case
	bl output_string
	bl input_number
	mov r7, r0

	ldr r0, =get_dup
	bl output_string
	bl input_number

	orr r7, r7, r0, LSL #1 @ we use mode = (dup << 1) | case

	@ get the number of strings
	ldr r0, =get_count
	bl output_string
	bl input_number
	mov r4, r0 @ store the number of strings in list 1

	ldr r0, =get_strings
	bl output_string

	ldr r0, =string_buffer
	ldr r9, =pointer_buffer
	mov r5, r0 @ location of list 1
	mov r8, #0

input_loop:
	cmp r8, r4 @ r4 = number of strings
	beq test

	str r0, [r9], #4
	bl input_string
	@ r0 = next place to input string

	add r8, r8, #1
	b input_loop

test:
	@ For calling sort,
	@  r0 = =pointer_buffer
	@  r1 = n = r4
	@  r2 = mode = r7
	
	ldr r0, =pointer_buffer
	mov r1, r4
	mov r2, r7

	bl sort

	mov r9, r0
	mov r4, r1 @ r1 stores length of list
	bl output_new_line
	ldr r0, =print_list
	bl output_string
	bl output_new_line

	mov r8, #0
print_loop:
	cmp r8, r4
	beq terminate

	ldr r0, [r9], #4 @ r9 stores the list of strings
	bl output_string
	bl output_new_line

	add r8, r8, #1
	b print_loop

terminate:
	mov r0, #0x18
	swi 0x123456

	.data
string_buffer:
	.space 4096
	@ buffer to store strings input by user

pointer_buffer:
	.space 4096
	@ buffer to store pointer to strings

get_count:
	.asciz "Number of strings in the list: "

get_strings:
	.asciz "Input the strings, each string on a new line:\n"

get_case:
	.asciz "Case-insensitive compare (1 for case-insensitive comparison, 0 for case-sensitive): "

get_dup:
	.asciz "Remove duplicates from list (1 to remove duplicates, 0 to not remove): "

print_list:
	.asciz "The sorted list is: "

	.end
