@ Code for storing 3! in r0
.text
mov r0, #1
mov r1, #7
mov r2, #1
mov r3, #0
fact_loop:

@ this bit between comments does
@ mul r0, r2
mov r4, r0
mov r0, #0
mov r5, #0
mul_loop:
cmp r5, r2
beq terminate_mul
add r0, r4
add r5, #1
b mul_loop
mov r0, r4
terminate_mul:
@ by adding r0, r2 times

add r2, #1
cmp r1, r2
bne fact_loop
.end
