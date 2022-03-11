@ compute negative fibonacci as a[i] = a[i - 2] - a[i - 1]
@  where a = mem[64], a[0] = 0, a[1] = 1

mov r0, #256
@ location of a

mov r1, #0
str r1, [r0]
mov r1, #1
str r1, [r0, #4]
@ set a[0] = 0, a[1] = 1

mov r1, #7
@ ie, 
@ a[0] = 0
@ a[1] = 1
@ for (i = 1; i <= 8; ++i)
@   a[i + 1] = a[i - 1] - a[i]

mov r2, #0 @ index variable
loop:
@ r3 = a[i]
@ ++i
@ r4 = a[i]
@ r3 -= r4
@ ++i
@ a[i] = r4

ldr r3, [r0, r2, LSL #2]
add r2, #1
ldr r4, [r0, r2, LSL #2]
sub r3, r4
add r2, #1
str r3, [r0, r2, LSL #2]

@ update things
@ add r0, #4
@ don't update r0
sub r2, #1
cmp r2, r1
bne loop
