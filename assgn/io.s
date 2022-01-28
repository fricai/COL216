@ Author: Ramanuj Goel, 2020CS50437

	.global input_string
	.global output_string
	.global output_new_line

	.text
input_string:
					@ r0 has address where we will store input
					@ the function will read till \n
					@ and then end the string with a \0
					@ returns the position of the next empty position in the memory
	mov r2, r0
	ldr r1, =ReadParams
input_rec:
	str r2, [r1, #4]		@ r2 = next empty position in memory
	mov r0, #0x06
	swi 0x123456
	ldrb r3, [r2]
	cmp r3, #0x0D			@ check for '\n' character
	beq terminate
	cmp r3, #0x08			@ check for backspace, and remove character if found
	subeq r2, r2, #1
	addne r2, r2, #1
	b input_rec
terminate:
	mov r1, #0			@ end with a \0 null character
	strb r1, [r2]
	add r2, r2, #1
	mov r0, r2
	mov pc, lr

output_string:
					@ r0 has the address of the output
					@ prints till it encounters a \0
					@ returns the next address for easy daisy chaining
	mov r3, r0
output_rec:				@ basically to count the length of the string
	ldrb r2, [r3]
	cmp r2, #0
	beq output_string_of_length
	add r3, r3, #1
	b output_rec
output_string_of_length:
					@ r0 has the start address
					@ r3 has the end address
	sub r2, r3, r0
	ldr r1, =WriteParams
	str r0, [r1, #4]
	str r2, [r1, #8] 		@ r2 is the length
	mov r0, #0x05
	swi 0x123456
	add r3, r3, #1
	mov r0, r3
	mov pc, lr
output_new_line:
	mov r0, #0x05
	ldr r1, =WriteNewLine
	swi 0x123456
	mov pc, lr

	.data
ReadParams:
	.word 0
	.word 0
	.word 1
WriteParams:
	.word 1
	.word 0
	.word 0
newLine:
	.ascii "\n\n\n\n"
WriteNewLine:
	.word 1
	.word newLine
	.word 1
buffer:
	.space 10
