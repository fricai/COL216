	.global compare
	
irst_ineq:
        push    {r7}
        sub     sp, sp, #20
        add     r7, sp, #0
        str     r0, [r7, #4]
        str     r1, [r7]
        movs    r3, #0
        str     r3, [r7, #12]
.L2:
        ldr     r3, [r7, #12]
        ldr     r2, [r7, #4]
        add     r3, r3, r2
        ldrb    r3, [r3]        @ zero_extendqisi2
        cmp     r3, #0
        beq     .L8
        ldr     r3, [r7, #12]
        ldr     r2, [r7]
        add     r3, r3, r2
        ldrb    r3, [r3]        @ zero_extendqisi2
        cmp     r3, #0
        beq     .L9
        ldr     r3, [r7, #12]
        ldr     r2, [r7, #4]
        add     r3, r3, r2
        ldrb    r2, [r3]        @ zero_extendqisi2
        ldr     r3, [r7, #12]
        ldr     r1, [r7]
        add     r3, r3, r1
        ldrb    r3, [r3]        @ zero_extendqisi2
        cmp     r2, r3
        bne     .L10
        ldr     r3, [r7, #12]
        adds    r3, r3, #1
        str     r3, [r7, #12]
        b       .L2
.L8:
        nop
        b       .L4
.L9:
        nop
        b       .L4
.L10:
        nop
.L4:
        ldr     r3, [r7, #12]
        mov     r0, r3
        adds    r7, r7, #20
        mov     sp, r7
        ldr     r7, [sp], #4
        bx      lr

to_lower:
	cmp r0, #65
	blt terminate_to_lower
	cmp r0, #90
	bgt terminate_to_lower
	add r0, r0, #32
terminate_to_lower:
	mov pc, lr

first_ineq_insensitive:
        push    {r4, r7, lr}
        sub     sp, sp, #20
        add     r7, sp, #0
        str     r0, [r7, #4]
        str     r1, [r7]
        movs    r3, #0
        str     r3, [r7, #12]
        b       .L10
.L12:
        ldr     r3, [r7, #12]
        adds    r3, r3, #1
        str     r3, [r7, #12]
.L10:
        ldr     r3, [r7, #12]
        ldr     r2, [r7, #4]
        add     r3, r3, r2
        ldrb    r3, [r3]        @ zero_extendqisi2
        cmp     r3, #0
        beq     .L11
        ldr     r3, [r7, #12]
        ldr     r2, [r7]
        add     r3, r3, r2
        ldrb    r3, [r3]        @ zero_extendqisi2
        cmp     r3, #0
        beq     .L11
        ldr     r3, [r7, #12]
        ldr     r2, [r7, #4]
        add     r3, r3, r2
        ldrb    r3, [r3]        @ zero_extendqisi2
        mov     r0, r3
        bl      to_lower
        mov     r3, r0
        mov     r4, r3
        ldr     r3, [r7, #12]
        ldr     r2, [r7]
        add     r3, r3, r2
        ldrb    r3, [r3]        @ zero_extendqisi2
        mov     r0, r3
        bl      to_lower
        mov     r3, r0
        cmp     r4, r3
        beq     .L12
.L11:
        ldr     r3, [r7, #12]
        mov     r0, r3
        adds    r7, r7, #20
        mov     sp, r7
        pop     {r4, r7, pc}
compare:
        push    {r4, r7, lr}
        sub     sp, sp, #28
        add     r7, sp, #0
        str     r0, [r7, #12]
        str     r1, [r7, #8]
        str     r2, [r7, #4]
        ldr     r3, [r7, #4]
        cmp     r3, #0
        bne     .L15
        ldr     r1, [r7, #8]
        ldr     r0, [r7, #12]
        bl      first_ineq
        str     r0, [r7, #16]
        ldr     r3, [r7, #16]
        ldr     r2, [r7, #12]
        add     r3, r3, r2
        ldrb    r2, [r3]        @ zero_extendqisi2
        ldr     r3, [r7, #16]
        ldr     r1, [r7, #8]
        add     r3, r3, r1
        ldrb    r3, [r3]        @ zero_extendqisi2
        cmp     r2, r3
        bne     .L16
        movs    r3, #0
        b       .L17
.L16:
        ldr     r3, [r7, #16]
        ldr     r2, [r7, #12]
        add     r3, r3, r2
        ldrb    r2, [r3]        @ zero_extendqisi2
        ldr     r3, [r7, #16]
        ldr     r1, [r7, #8]
        add     r3, r3, r1
        ldrb    r3, [r3]        @ zero_extendqisi2
        cmp     r2, r3
        bcs     .L18
        mov     r3, #-1
        b       .L17
.L18:
        movs    r3, #1
        b       .L17
.L15:
        ldr     r1, [r7, #8]
        ldr     r0, [r7, #12]
        bl      first_ineq_insensitive
        str     r0, [r7, #20]
        ldr     r3, [r7, #20]
        ldr     r2, [r7, #12]
        add     r3, r3, r2
        ldrb    r3, [r3]        @ zero_extendqisi2
        mov     r0, r3
        bl      to_lower
        mov     r3, r0
        mov     r4, r3
        ldr     r3, [r7, #20]
        ldr     r2, [r7, #8]
        add     r3, r3, r2
        ldrb    r3, [r3]        @ zero_extendqisi2
        mov     r0, r3
        bl      to_lower
        mov     r3, r0
        cmp     r4, r3
        bne     .L19
        movs    r3, #0
        b       .L17
.L19:
        ldr     r3, [r7, #20]
        ldr     r2, [r7, #12]
        add     r3, r3, r2
        ldrb    r3, [r3]        @ zero_extendqisi2
        mov     r0, r3
        bl      to_lower
        mov     r3, r0
        mov     r4, r3
        ldr     r3, [r7, #20]
        ldr     r2, [r7, #8]
        add     r3, r3, r2
        ldrb    r3, [r3]        @ zero_extendqisi2
        mov     r0, r3
        bl      to_lower
        mov     r3, r0
        cmp     r4, r3
        bcs     .L20
        mov     r3, #-1
        b       .L17
.L20:
        movs    r3, #1
.L17:
        mov     r0, r3
        adds    r7, r7, #28
        mov     sp, r7
        pop     {r4, r7, pc}
