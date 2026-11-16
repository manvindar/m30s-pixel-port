
retained-evidence/bt-graphics-evidence-43772935293/latest-system-arm32-libui.so:	file format elf32-littlearm

Disassembly of section .text:

0002b57c <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijyj>:
   2b57c:      	push.w	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
   2b580:      	sub	sp, #0x24
   2b582:      	mov	r4, r0
   2b584:      	ldr	r0, [pc, #0xc4]         @ 0x2b64c <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijyj+0xd0>
   2b586:      	mov	r6, r4
   2b588:      	mov	r5, r1
   2b58a:      	add	r0, pc
   2b58c:      	ldr.w	lr, [sp, #0x60]
   2b590:      	ldrd	r12, r8, [sp, #72]
   2b594:      	cmp	r2, #0x0
   2b596:      	ldr	r0, [r0]
   2b598:      	ldr	r1, [sp, #0x58]
   2b59a:      	ldr.w	r9, [sp, #0x5c]
   2b59e:      	ldr	r0, [r0]
   2b5a0:      	str	r0, [sp, #0x20]
   2b5a2:      	mov	r0, r2
   2b5a4:      	str	r3, [r6, #40]!
   2b5a8:      	it	ne
   2b5aa:      	movne	r0, #0x1
   2b5ac:      	ldr	r7, [sp, #0x50]
   2b5ae:      	strb.w	r0, [r6, #0x40]
   2b5b2:      	and	r0, r2, #0xfe
   2b5b6:      	cmp	r0, #0x2
   2b5b8:      	strd	r1, r9, [r6, #32]
   2b5bc:      	strd	r12, lr, [r6, #4]
   2b5c0:      	strd	r8, r1, [r6, #12]
   2b5c4:      	str	r7, [r6, #0x14]
   2b5c6:      	bne	0x2b630 <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijyj+0xb4> @ imm = #0x66
   2b5c8:      	ldr	r0, [r4, #0x6c]
   2b5ca:      	mov	r10, r2
   2b5cc:      	add	r2, sp, #0x1c
   2b5ce:      	strd	r7, r8, [sp]
   2b5d2:      	add	r7, sp, #0x8
   2b5d4:      	mov.w	r11, #0x0
   2b5d8:      	stm.w	r7, {r1, r9, lr}
   2b5dc:      	mov	r1, r5
   2b5de:      	str	r2, [sp, #0x14]
   2b5e0:      	mov	r2, r3
   2b5e2:      	mov	r3, r12
   2b5e4:      	str.w	r11, [sp, #0x1c]
   2b5e8:      	blx	0x400d0                 @ imm = #0x14ae4
   2b5ec:      	cbz	r0, 0x2b60c <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijyj+0x90> @ imm = #0x1c
   2b5ee:      	vmov.i32	q8, #0x0
   2b5f2:      	str.w	r11, [r6, #0x14]
   2b5f6:      	strb.w	r11, [r4, #0x68]
   2b5fa:      	strd	r11, r11, [r4, #68]
   2b5fe:      	vst1.64	{d16, d17}, [r6]!
   2b602:      	str.w	r11, [r4, #0x4c]
   2b606:      	str.w	r11, [r6]
   2b60a:      	b	0x2b634 <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijyj+0xb8> @ imm = #0x26
   2b60c:      	cmp.w	r10, #0x2
   2b610:      	bne	0x2b61e <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijyj+0xa2> @ imm = #0xa
   2b612:      	mov	r0, r5
   2b614:      	blx	0x400e0                 @ imm = #0x14ac8
   2b618:      	mov	r0, r5
   2b61a:      	blx	0x3fdf0                 @ imm = #0x147d4
   2b61e:      	ldr	r5, [sp, #0x1c]
   2b620:      	add.w	r2, r4, #0x74
   2b624:      	ldr	r0, [r4, #0x6c]
   2b626:      	add.w	r3, r4, #0x78
   2b62a:      	mov	r1, r5
   2b62c:      	blx	0x400b0                 @ imm = #0x14a80
   2b630:      	movs	r0, #0x0
   2b632:      	str	r5, [r4, #0x44]
   2b634:      	ldr	r1, [sp, #0x20]
   2b636:      	ldr	r2, [pc, #0x18]         @ 0x2b650 <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijyj+0xd4>
   2b638:      	add	r2, pc
   2b63a:      	ldr	r2, [r2]
   2b63c:      	ldr	r2, [r2]
   2b63e:      	cmp	r2, r1
   2b640:      	itt	eq
   2b642:      	addeq	sp, #0x24
   2b644:      	popeq.w	{r4, r5, r6, r7, r8, r9, r10, r11, pc}
   2b648:      	blx	0x3f4f0                 @ imm = #0x13ea4
   2b64c:      	ldr	r2, [r4, #0x20]
   2b64e:      	movs	r1, r0
   2b650:      	ldr	r4, [r6, #0x14]
   2b652:      	movs	r1, r0
