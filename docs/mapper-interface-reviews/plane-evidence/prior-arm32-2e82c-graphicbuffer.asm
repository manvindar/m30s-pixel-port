
retained-evidence/bt-graphics-evidence-43772935293/prior-system-arm32-libui.so:	file format elf32-littlearm

Disassembly of section .text:

0002e82c <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijyj>:
   2e82c:      	push.w	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
   2e830:      	sub	sp, #0x24
   2e832:      	mov	r4, r0
   2e834:      	ldr	r0, [pc, #0xc4]         @ 0x2e8fc <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijyj+0xd0>
   2e836:      	mov	r6, r4
   2e838:      	mov	r5, r1
   2e83a:      	add	r0, pc
   2e83c:      	ldr.w	lr, [sp, #0x60]
   2e840:      	ldrd	r12, r8, [sp, #72]
   2e844:      	cmp	r2, #0x0
   2e846:      	ldr	r0, [r0]
   2e848:      	ldr	r1, [sp, #0x58]
   2e84a:      	ldr.w	r9, [sp, #0x5c]
   2e84e:      	ldr	r0, [r0]
   2e850:      	str	r0, [sp, #0x20]
   2e852:      	mov	r0, r2
   2e854:      	str	r3, [r6, #40]!
   2e858:      	it	ne
   2e85a:      	movne	r0, #0x1
   2e85c:      	ldr	r7, [sp, #0x50]
   2e85e:      	strb.w	r0, [r6, #0x40]
   2e862:      	and	r0, r2, #0xfe
   2e866:      	cmp	r0, #0x2
   2e868:      	strd	r1, r9, [r6, #32]
   2e86c:      	strd	r12, lr, [r6, #4]
   2e870:      	strd	r8, r1, [r6, #12]
   2e874:      	str	r7, [r6, #0x14]
   2e876:      	bne	0x2e8e0 <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijyj+0xb4> @ imm = #0x66
   2e878:      	ldr	r0, [r4, #0x6c]
   2e87a:      	mov	r10, r2
   2e87c:      	add	r2, sp, #0x1c
   2e87e:      	strd	r7, r8, [sp]
   2e882:      	add	r7, sp, #0x8
   2e884:      	mov.w	r11, #0x0
   2e888:      	stm.w	r7, {r1, r9, lr}
   2e88c:      	mov	r1, r5
   2e88e:      	str	r2, [sp, #0x14]
   2e890:      	mov	r2, r3
   2e892:      	mov	r3, r12
   2e894:      	str.w	r11, [sp, #0x1c]
   2e898:      	blx	0x435c0                 @ imm = #0x14d24
   2e89c:      	cbz	r0, 0x2e8bc <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijyj+0x90> @ imm = #0x1c
   2e89e:      	vmov.i32	q8, #0x0
   2e8a2:      	str.w	r11, [r6, #0x14]
   2e8a6:      	strb.w	r11, [r4, #0x68]
   2e8aa:      	strd	r11, r11, [r4, #68]
   2e8ae:      	vst1.64	{d16, d17}, [r6]!
   2e8b2:      	str.w	r11, [r4, #0x4c]
   2e8b6:      	str.w	r11, [r6]
   2e8ba:      	b	0x2e8e4 <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijyj+0xb8> @ imm = #0x26
   2e8bc:      	cmp.w	r10, #0x2
   2e8c0:      	bne	0x2e8ce <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijyj+0xa2> @ imm = #0xa
   2e8c2:      	mov	r0, r5
   2e8c4:      	blx	0x435d0                 @ imm = #0x14d08
   2e8c8:      	mov	r0, r5
   2e8ca:      	blx	0x43350                 @ imm = #0x14a84
   2e8ce:      	ldr	r5, [sp, #0x1c]
   2e8d0:      	add.w	r2, r4, #0x74
   2e8d4:      	ldr	r0, [r4, #0x6c]
   2e8d6:      	add.w	r3, r4, #0x78
   2e8da:      	mov	r1, r5
   2e8dc:      	blx	0x435a0                 @ imm = #0x14cc0
   2e8e0:      	movs	r0, #0x0
   2e8e2:      	str	r5, [r4, #0x44]
   2e8e4:      	ldr	r1, [sp, #0x20]
   2e8e6:      	ldr	r2, [pc, #0x18]         @ 0x2e900 <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijyj+0xd4>
   2e8e8:      	add	r2, pc
   2e8ea:      	ldr	r2, [r2]
   2e8ec:      	ldr	r2, [r2]
   2e8ee:      	cmp	r2, r1
   2e8f0:      	itt	eq
   2e8f2:      	addeq	sp, #0x24
   2e8f4:      	popeq.w	{r4, r5, r6, r7, r8, r9, r10, r11, pc}
   2e8f8:      	blx	0x428f0                 @ imm = #0x13ff4
   2e8fc:      	ldr	r6, [r3, #0x70]
   2e8fe:      	movs	r1, r0
   2e900:      	ldr	r0, [r6, #0x64]
   2e902:      	movs	r1, r0
