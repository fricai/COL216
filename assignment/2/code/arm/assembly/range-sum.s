.text
mov r0, #256
@ r0 = 4 * base

@ in base, base + 1, ..., base + 5 - 1, where base = 64
@ store 0, 0 + 1, 0 + 1 + 2, 0 + 1 + 2 + 3, ...
@
@ we do this as follows,
@ a[0] = 0;
@ for (i = 1; i < 5; ++i)
@      a[i] = a[i - 1] + i;
@
@ we implement it like this,
@ a[0] = 0;
@ for (i = 1; i < 5; ++i) {
@      x = a[i - 1];
@      x += i;
@      a[i] = x;
@ }
@
@ we manually unroll the loop to test the immediate offsets of
@   ldr and str

mov r1, #0
str r1, [r0]

ldr r1, [r0, #0]
add r1, #1
str r1, [r0, #4]

ldr r1, [r0, #4]
add r1, #2
str r1, [r0, #8]

ldr r1, [r0, #8]
add r1, #3
str r1, [r0, #12]

ldr r1, [r0, #12]
add r1, #4
str r1, [r0, #16]
.end
