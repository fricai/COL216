	.extern input_string
	.extern output_string
	.extern output_new_line
	.extern output_int
	.extern compare

	.text
main:
	@ r5 stores pointer to first string
	@ r6 stores pointer to second string

	ldr r5, =buffer
	mov r0, r5
	bl input_string
	mov r6, r0
	bl input_string

	@ r5, r6 now contains pointer to strings input by user

	@ do a case-sensitive comparison

	ldr r0, =case_sensitive_string
	bl output_string

	mov r0, r5
	mov r1, r6
	mov r2, #0 @ type = 0
	bl compare

	@ branch to print the appropriate string
	@  based on the result from compare

	cmp r0, #0
	blt is_less
	bgt is_greater
	b is_equal

ins:
	@ do a case-insensitive comparison

	ldr r0, =case_insensitive_string
	bl output_string

	mov r0, r5
	mov r1, r6
	mov r2, #1 @ type = 1
	bl compare

	cmp r0, #0
	blt is_less_i
	bgt is_greater_i
	b is_equal_i

is_less:
	ldr r0, =less_string
	bl output_string
	b ins
is_greater:
	ldr r0, =greater_string
	bl output_string
	b ins
is_equal:
	ldr r0, =equal_string
	bl output_string
	b ins

is_less_i:
	ldr r0, =less_string
	bl output_string
	b terminate
is_greater_i:
	ldr r0, =greater_string
	bl output_string
	b terminate
is_equal_i:
	ldr r0, =equal_string
	bl output_string
	b terminate

terminate:
	mov r0, #0x18
	swi 0x123456

	.data
buffer:
	.space 400
	@ buffer to store strings input by user
greater_string:
	.asciz "first string is greater than the second string\n"
equal_string:
	.asciz "first string is equal to the second string\n"
less_string:
	.asciz "first string is less than the second string\n"
case_insensitive_string:
	.asciz "Case insensitive: "
case_sensitive_string:
	.asciz "Case sensitive: "

	.end
