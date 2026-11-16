
/Users/manvindar.singh/HarnessAgents/hive/agents/pam-mw9kdvck/artifacts/android17-actions-20261115/bt-graphics-evidence-43772935293/latest-system-arm64-libui.so:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000042624 <_ZN7android19GraphicBufferMapper9lockYCbCrEPK13native_handlejRKNS_4RectEP13android_ycbcr>:
   42624:      	paciasp
   42628:      	sub	sp, sp, #0xb0
   4262c:      	stp	x29, x30, [sp, #0x70]
   42630:      	str	x23, [sp, #0x80]
   42634:      	stp	x22, x21, [sp, #0x90]
   42638:      	stp	x20, x19, [sp, #0xa0]
   4263c:      	add	x29, sp, #0x70
   42640:      	mrs	x22, TPIDR_EL0
   42644:      	movi	v0.2d, #0000000000000000
   42648:      	mov	x19, x4
   4264c:      	ldr	x8, [x22, #0x28]
   42650:      	mov	w2, w2
   42654:      	add	x4, sp, #0xc
   42658:      	stur	x8, [x29, #-0x8]
   4265c:      	mov	w8, #-0x1
   42660:      	str	w8, [sp, #0xc]
   42664:      	add	x8, sp, #0x10
   42668:      	str	xzr, [sp, #0x60]
   4266c:      	stp	q0, q0, [sp, #0x20]
   42670:      	stp	q0, q0, [sp, #0x40]
   42674:      	str	q0, [sp, #0x10]
   42678:      	bl	0x64b60 <_ZN7android19GraphicBufferMapper9lockYCbCrEPK13native_handlelRKNS_4RectEONS_4base14unique_fd_implINS7_13DefaultCloserEEE@plt>
   4267c:      	bl	0x63de0 <__errno@plt>
   42680:      	ldr	w21, [sp, #0xc]
   42684:      	ldr	w23, [x0]
   42688:      	mov	x20, x0
   4268c:      	cmn	w21, #0x1
   42690:      	b.eq	0x426b8 <_ZN7android19GraphicBufferMapper9lockYCbCrEPK13native_handlejRKNS_4RectEP13android_ycbcr+0x94>
   42694:      	adrp	x8, 0x69000
   42698:      	ldr	x8, [x8, #0x218]
   4269c:      	cbz	x8, 0x42724 <_ZN7android19GraphicBufferMapper9lockYCbCrEPK13native_handlejRKNS_4RectEP13android_ycbcr+0x100>
   426a0:      	add	x1, sp, #0xc
   426a4:      	mov	w0, #0x3
   426a8:      	bl	0x63ed0 <android_fdsan_create_owner_tag@plt>
   426ac:      	mov	x1, x0
   426b0:      	mov	w0, w21
   426b4:      	bl	0x63f00 <android_fdsan_close_with_tag@plt>
   426b8:      	str	w23, [x20]
   426bc:      	ldr	w20, [sp, #0x60]
   426c0:      	cbnz	w20, 0x42730 <_ZN7android19GraphicBufferMapper9lockYCbCrEPK13native_handlejRKNS_4RectEP13android_ycbcr+0x10c>
   426c4:      	add	x1, sp, #0x10
   426c8:      	mov	x0, x19
   426cc:      	mov	w2, #0x50
   426d0:      	bl	0x65370 <memcpy@plt>
   426d4:      	mov	x8, xzr
   426d8:      	mov	w19, wzr
   426dc:      	nop
   426e0:      	adr	x9, #0x26790
   426e4:      	add	x0, sp, #0xc
   426e8:      	ldr	x8, [x9, x8, lsl #3]
   426ec:      	add	x1, sp, #0x10
   426f0:      	blr	x8
   426f4:      	ldr	x8, [x22, #0x28]
   426f8:      	ldur	x9, [x29, #-0x8]
   426fc:      	cmp	x8, x9
   42700:      	b.ne	0x42750 <_ZN7android19GraphicBufferMapper9lockYCbCrEPK13native_handlejRKNS_4RectEP13android_ycbcr+0x12c>
   42704:      	mov	w0, w19
   42708:      	ldp	x20, x19, [sp, #0xa0]
   4270c:      	ldr	x23, [sp, #0x80]
   42710:      	ldp	x22, x21, [sp, #0x90]
   42714:      	ldp	x29, x30, [sp, #0x70]
   42718:      	add	sp, sp, #0xb0
   4271c:      	autiasp
   42720:      	ret
   42724:      	mov	w0, w21
   42728:      	bl	0x63f18 <close@plt>
   4272c:      	b	0x426b8 <_ZN7android19GraphicBufferMapper9lockYCbCrEPK13native_handlejRKNS_4RectEP13android_ycbcr+0x94>
   42730:      	add	x0, sp, #0x10
   42734:      	bl	0x5dc8c <_ZN7android19GraphicBufferMapper16getTransportSizeEPK13native_handlePjS4_+0x14>
   42738:      	cmn	w20, #0x1
   4273c:      	mov	w19, w0
   42740:      	b.eq	0x426f4 <_ZN7android19GraphicBufferMapper9lockYCbCrEPK13native_handlejRKNS_4RectEP13android_ycbcr+0xd0>
   42744:      	cmp	w20, #0x1
   42748:      	b.eq	0x42754 <_ZN7android19GraphicBufferMapper9lockYCbCrEPK13native_handlejRKNS_4RectEP13android_ycbcr+0x130>
   4274c:      	brk	#0x5503
   42750:      	bl	0x65340 <__stack_chk_fail@plt>
   42754:      	mov	w8, #0x1
   42758:      	b	0x426dc <_ZN7android19GraphicBufferMapper9lockYCbCrEPK13native_handlejRKNS_4RectEP13android_ycbcr+0xb8>
