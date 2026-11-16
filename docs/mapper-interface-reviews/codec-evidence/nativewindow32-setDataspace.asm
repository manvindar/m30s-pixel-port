
retained-evidence/provider-callers-43776923589/legacy_graphics/abi-consumers/ad5d5182265cf2764157fb90c99334700b54be368617c22c9cb4f3a82bfaee86.elf:	file format elf32-littlearm

Disassembly of section .text:

00004960 <AHardwareBuffer_setDataSpace>:
    4960:      	push.w	{r4, r5, r6, r7, r8, lr}
    4964:      	mov	r8, r1
    4966:      	blx	0x5990                  @ imm = #0x1028
    496a:      	mov	r5, r0
    496c:      	ldr	r0, [pc, #0x7c]         @ 0x49ec <AHardwareBuffer_setDataSpace+0x8c>
    496e:      	add	r0, pc
    4970:      	ldr	r6, [r0]
    4972:      	mov	r0, r6
    4974:      	blx	0x5b50                  @ imm = #0x11d8
    4978:      	ldr	r0, [pc, #0x74]         @ 0x49f0 <AHardwareBuffer_setDataSpace+0x90>
    497a:      	add	r0, pc
    497c:      	ldr	r4, [r0]
    497e:      	ldr	r7, [r4]
    4980:      	cbnz	r7, 0x4990 <AHardwareBuffer_setDataSpace+0x30> @ imm = #0xc
    4982:      	movs	r0, #0x8
    4984:      	blx	0x5900                  @ imm = #0xf78
    4988:      	mov	r7, r0
    498a:      	blx	0x5b60                  @ imm = #0x11d4
    498e:      	str	r0, [r4]
    4990:      	mov	r0, r6
    4992:      	blx	0x5b70                  @ imm = #0x11dc
    4996:      	ldr	r1, [r5, #0x44]
    4998:      	mov	r0, r7
    499a:      	mov	r2, r8
    499c:      	blx	0x5b80                  @ imm = #0x11e0
    49a0:      	add.w	r1, r0, #0x26
    49a4:      	cmp	r1, #0x26
    49a6:      	bhi	0x49d8 <AHardwareBuffer_setDataSpace+0x78> @ imm = #0x2e
    49a8:      	tbb	[pc, r1]
    49ac:      	adds	r0, r3, #0x0
    49ae:      	adds	r4, r3, #0x0
    49b0:      	adds	r4, r3, #0x0
    49b2:      	adds	r4, r3, #0x0
    49b4:      	adds	r4, r3, #0x0
    49b6:      	adds	r4, r3, #0x0
    49b8:      	adds	r4, r3, #0x0
    49ba:      	adds	r4, r3, #0x0
    49bc:      	adds	r4, r2, #0x0
    49be:      	adds	r4, r3, #0x0
    49c0:      	adds	r4, r3, #0x0
    49c2:      	adds	r4, r3, #0x0
    49c4:      	adds	r4, r3, #0x0
    49c6:      	adds	r4, r2, #0x0
    49c8:      	adds	r4, r3, #0x0
    49ca:      	adds	r4, r3, #0x0
    49cc:      	adds	r4, r3, #0x0
    49ce:      	adds	r4, r3, #0x0
    49d0:      	adds	r4, r3, #0x0
    49d2:      	movs	r4, r2
    49d4:      	pop.w	{r4, r5, r6, r7, r8, pc}
    49d8:      	adds	r0, #0x4a
    49da:      	bne	0x49e4 <AHardwareBuffer_setDataSpace+0x84> @ imm = #0x6
    49dc:      	mvn	r0, #0x25
    49e0:      	pop.w	{r4, r5, r6, r7, r8, pc}
    49e4:      	mov.w	r0, #0x80000000
    49e8:      	pop.w	{r4, r5, r6, r7, r8, pc}
    49ec:      	movs	r4, #0x26
    49ee:      	movs	r0, r0
    49f0:      	movs	r4, #0x1e
    49f2:      	movs	r0, r0
