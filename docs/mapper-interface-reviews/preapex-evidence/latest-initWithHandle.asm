
retained-evidence/bt-graphics-evidence-43772935293/latest-system-arm64-libui.so:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000044498 <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijmj>:
   44498:      	paciasp
   4449c:      	sub	sp, sp, #0x60
   444a0:      	stp	x29, x30, [sp, #0x20]
   444a4:      	str	x23, [sp, #0x30]
   444a8:      	stp	x22, x21, [sp, #0x40]
   444ac:      	stp	x20, x19, [sp, #0x50]
   444b0:      	add	x29, sp, #0x20
   444b4:      	mrs	x22, TPIDR_EL0
   444b8:      	mov	x23, x0
   444bc:      	mov	x8, x7
   444c0:      	ldr	x9, [x22, #0x28]
   444c4:      	ldr	w7, [x29, #0x40]
   444c8:      	tst	w2, #0xff
   444cc:      	mov	x20, x1
   444d0:      	mov	x19, x0
   444d4:      	cset	w10, ne
   444d8:      	stur	x9, [x29, #-0x8]
   444dc:      	mov	w9, w6
   444e0:      	stp	w3, w4, [x23, #0x48]!
   444e4:      	str	x9, [x23, #0x18]
   444e8:      	and	w9, w2, #0xfe
   444ec:      	cmp	w9, #0x2
   444f0:      	stp	w7, w5, [x23, #0x8]
   444f4:      	str	x8, [x23, #0x30]
   444f8:      	str	w8, [x23, #0x10]
   444fc:      	strb	w10, [x23, #0x70]
   44500:      	b.ne	0x44574 <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijmj+0xdc>
   44504:      	ldr	x0, [x19, #0xc0]
   44508:      	mov	w21, w2
   4450c:      	add	x9, sp, #0x10
   44510:      	mov	x1, x20
   44514:      	mov	w2, w3
   44518:      	mov	w3, w4
   4451c:      	mov	w4, w6
   44520:      	mov	x6, x8
   44524:      	str	xzr, [sp, #0x10]
   44528:      	str	x9, [sp]
   4452c:      	bl	0x64b00 <_ZN7android19GraphicBufferMapper12importBufferEPK13native_handlejjjimjPS3_@plt>
   44530:      	cbnz	w0, 0x445a8 <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijmj+0x110>
   44534:      	and	w8, w21, #0xff
   44538:      	cmp	w8, #0x2
   4453c:      	b.ne	0x44550 <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijmj+0xb8>
   44540:      	mov	x0, x20
   44544:      	bl	0x64b18 <native_handle_close@plt>
   44548:      	mov	x0, x20
   4454c:      	bl	0x64530 <native_handle_delete@plt>
   44550:      	ldr	x8, [x19, #0xc0]
   44554:      	ldr	x20, [sp, #0x10]
   44558:      	add	x2, x19, #0xd0
   4455c:      	add	x3, x19, #0xd4
   44560:      	ldr	x0, [x8]
   44564:      	mov	x1, x20
   44568:      	ldr	x8, [x0]
   4456c:      	ldr	x8, [x8, #0x38]
   44570:      	blr	x8
   44574:      	mov	w0, wzr
   44578:      	str	x20, [x19, #0x70]
   4457c:      	ldr	x8, [x22, #0x28]
   44580:      	ldur	x9, [x29, #-0x8]
   44584:      	cmp	x8, x9
   44588:      	b.ne	0x445c0 <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijmj+0x128>
   4458c:      	ldp	x20, x19, [sp, #0x50]
   44590:      	ldr	x23, [sp, #0x30]
   44594:      	ldp	x22, x21, [sp, #0x40]
   44598:      	ldp	x29, x30, [sp, #0x20]
   4459c:      	add	sp, sp, #0x60
   445a0:      	autiasp
   445a4:      	ret
   445a8:      	str	xzr, [x19, #0x60]
   445ac:      	strb	wzr, [x19, #0xb8]
   445b0:      	stp	xzr, xzr, [x23]
   445b4:      	str	wzr, [x23, #0x10]
   445b8:      	stp	xzr, xzr, [x19, #0x70]
   445bc:      	b	0x4457c <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijmj+0xe4>
   445c0:      	bl	0x65340 <__stack_chk_fail@plt>
