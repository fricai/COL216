@ compute negative fibonacci as a[i] = a[i - 2] - a[i - 1]
@  where a = mem[64], a[0] = 0, a[1] = 1

mov r0, #255
add r0, #1
@ location of a

mov r1, #0
str r1, [r0]
mov r1, #1
str r1, [r0, #4]
@ set a[0] = 0, a[1] = 1

mov r1, #8
@ ie, 
@ a[0] = 0
@ a[1] = 1
@ for (i = 1; i <= 8; ++i)
@   a[i + 1] = a[i - 1] - a[i]

add r0, #4
mov r2, #1 @ index variable
loop:
@ r3 = a[r0 - 1]
@ r4 = a[r0]
@ r4 -= r3
@ a[r0 + 1] = r4

ldr r3, [r0, #-4]
ldr r4, [r0]
sub r3, r4
str r3, [r0, #4]

@ update things
add r0, #4
add r2, #1
cmp r2, r1
bne loop
