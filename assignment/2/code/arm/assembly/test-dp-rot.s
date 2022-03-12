.text

mov r0, #0xAC000003
mov r1, r0, ROR #6
mov r2, #24
add r3, r1, r0, ASR r2
sub r4, r0, r3, LSL #7
lsr r2, #1
add r5, r4, r0, LSR r2

.end
