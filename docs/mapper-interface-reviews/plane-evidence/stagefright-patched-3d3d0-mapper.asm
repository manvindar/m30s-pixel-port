
/Users/manvindar.singh/HarnessAgents/hive/agents/pam-mw9kdvck/artifacts/android17-actions-20261115/provider-callers-43776923589/legacy_graphics/patched/system/lib64/libui.so:	file format elf64-littleaarch64

Disassembly of section .text:

000000000003d3d0 <_ZN7android19GraphicBufferMapper9lockYCbCrEPK13native_handlejRKNS_4RectEP13android_ycbcr>:
   3d3d0:      	paciasp
   3d3d4:      	sub	sp, sp, #0xb0
   3d3d8:      	stp	x29, x30, [sp, #0x70]
   3d3dc:      	str	x23, [sp, #0x80]
   3d3e0:      	stp	x22, x21, [sp, #0x90]
   3d3e4:      	stp	x20, x19, [sp, #0xa0]
   3d3e8:      	add	x29, sp, #0x70
   3d3ec:      	mrs	x22, TPIDR_EL0
   3d3f0:      	movi	v0.2d, #0000000000000000
   3d3f4:      	mov	x19, x4
   3d3f8:      	ldr	x8, [x22, #0x28]
   3d3fc:      	mov	w2, w2
   3d400:      	add	x4, sp, #0xc
   3d404:      	stur	x8, [x29, #-0x8]
   3d408:      	mov	w8, #-0x1
   3d40c:      	str	w8, [sp, #0xc]
   3d410:      	add	x8, sp, #0x10
   3d414:      	str	xzr, [sp, #0x60]
   3d418:      	stp	q0, q0, [sp, #0x20]
   3d41c:      	stp	q0, q0, [sp, #0x40]
   3d420:      	str	q0, [sp, #0x10]
   3d424:      	bl	0x68ca0 <_ZN7android19GraphicBufferMapper9lockYCbCrEPK13native_handlelRKNS_4RectEONS_4base14unique_fd_implINS7_13DefaultCloserEEE@plt>
   3d428:      	bl	0x67da0 <__errno@plt>
   3d42c:      	ldr	w21, [sp, #0xc]
   3d430:      	ldr	w23, [x0]
   3d434:      	mov	x20, x0
   3d438:      	cmn	w21, #0x1
   3d43c:      	b.eq	0x3d470 <_ZN7android19GraphicBufferMapper9lockYCbCrEPK13native_handlejRKNS_4RectEP13android_ycbcr+0xa0>
   3d440:      	adrp	x8, 0x6d000 <_ZTVN7android14Gralloc5MapperE+0xe0>
   3d444:      	ldr	x8, [x8, #0x788]
   3d448:      	cbnz	x8, 0x3d458 <_ZN7android19GraphicBufferMapper9lockYCbCrEPK13native_handlejRKNS_4RectEP13android_ycbcr+0x88>
   3d44c:      	mov	w0, w21
   3d450:      	bl	0x67ed8 <close@plt>
   3d454:      	b	0x3d470 <_ZN7android19GraphicBufferMapper9lockYCbCrEPK13native_handlejRKNS_4RectEP13android_ycbcr+0xa0>
   3d458:      	add	x1, sp, #0xc
   3d45c:      	mov	w0, #0x3
   3d460:      	bl	0x67e90 <android_fdsan_create_owner_tag@plt>
   3d464:      	mov	x1, x0
   3d468:      	mov	w0, w21
   3d46c:      	bl	0x67ec0 <android_fdsan_close_with_tag@plt>
   3d470:      	str	w23, [x20]
   3d474:      	ldr	w20, [sp, #0x60]
   3d478:      	cbnz	w20, 0x3d498 <_ZN7android19GraphicBufferMapper9lockYCbCrEPK13native_handlejRKNS_4RectEP13android_ycbcr+0xc8>
   3d47c:      	add	x1, sp, #0x10
   3d480:      	mov	x0, x19
   3d484:      	mov	w2, #0x50
   3d488:      	bl	0x69498 <memcpy@plt>
   3d48c:      	mov	x8, xzr
   3d490:      	mov	w19, wzr
   3d494:      	b	0x3d4b8 <_ZN7android19GraphicBufferMapper9lockYCbCrEPK13native_handlejRKNS_4RectEP13android_ycbcr+0xe8>
   3d498:      	add	x0, sp, #0x10
   3d49c:      	bl	0x3d508 <_ZN7android19GraphicBufferMapper9lockYCbCrEPK13native_handlejRKNS_4RectEP13android_ycbcr+0x138>
   3d4a0:      	cmn	w20, #0x1
   3d4a4:      	mov	w19, w0
   3d4a8:      	b.eq	0x3d4d0 <_ZN7android19GraphicBufferMapper9lockYCbCrEPK13native_handlejRKNS_4RectEP13android_ycbcr+0x100>
   3d4ac:      	cmp	w20, #0x1
   3d4b0:      	b.ne	0x3d504 <_ZN7android19GraphicBufferMapper9lockYCbCrEPK13native_handlejRKNS_4RectEP13android_ycbcr+0x134>
   3d4b4:      	mov	w8, #0x1
   3d4b8:      	nop
   3d4bc:      	adr	x9, #0x2fedc
   3d4c0:      	add	x0, sp, #0xc
   3d4c4:      	ldr	x8, [x9, x8, lsl #3]
   3d4c8:      	add	x1, sp, #0x10
   3d4cc:      	blr	x8
   3d4d0:      	ldr	x8, [x22, #0x28]
   3d4d4:      	ldur	x9, [x29, #-0x8]
   3d4d8:      	cmp	x8, x9
   3d4dc:      	b.ne	0x3d500 <_ZN7android19GraphicBufferMapper9lockYCbCrEPK13native_handlejRKNS_4RectEP13android_ycbcr+0x130>
   3d4e0:      	mov	w0, w19
   3d4e4:      	ldp	x20, x19, [sp, #0xa0]
   3d4e8:      	ldr	x23, [sp, #0x80]
   3d4ec:      	ldp	x22, x21, [sp, #0x90]
   3d4f0:      	ldp	x29, x30, [sp, #0x70]
   3d4f4:      	add	sp, sp, #0xb0
   3d4f8:      	autiasp
   3d4fc:      	ret
   3d500:      	bl	0x69468 <__stack_chk_fail@plt>
   3d504:      	brk	#0x5503
