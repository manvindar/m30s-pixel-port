
/Users/manvindar.singh/HarnessAgents/hive/agents/pam-mw9kdvck/artifacts/android17-actions-20261115/provider-callers-43776923589/legacy_graphics/patched/system/lib64/libui.so:	file format elf64-littleaarch64

Disassembly of section .text:

000000000003e368 <_ZN7android19GraphicBufferMapper4lockEPK13native_handlejRKNS_4RectEPPv>:
   3e368:      	paciasp
   3e36c:      	sub	sp, sp, #0x70
   3e370:      	stp	x29, x30, [sp, #0x40]
   3e374:      	str	x21, [sp, #0x50]
   3e378:      	stp	x20, x19, [sp, #0x60]
   3e37c:      	add	x29, sp, #0x40
   3e380:      	mrs	x21, TPIDR_EL0
   3e384:      	movi	v0.2d, #0000000000000000
   3e388:      	mov	x19, x4
   3e38c:      	ldr	x8, [x21, #0x28]
   3e390:      	mov	w2, w2
   3e394:      	add	x4, sp, #0xc
   3e398:      	stur	x8, [x29, #-0x8]
   3e39c:      	mov	w8, #-0x1
   3e3a0:      	str	w8, [sp, #0xc]
   3e3a4:      	add	x8, sp, #0x10
   3e3a8:      	str	xzr, [sp, #0x30]
   3e3ac:      	stp	q0, q0, [sp, #0x10]
   3e3b0:      	bl	0x68c88 <_ZN7android19GraphicBufferMapper4lockEPK13native_handlelRKNS_4RectEONS_4base14unique_fd_implINS7_13DefaultCloserEEE@plt>
   3e3b4:      	add	x0, sp, #0xc
   3e3b8:      	bl	0x3e444 <_ZN7android19GraphicBufferMapper4lockEPK13native_handlejRKNS_4RectEPPv+0xdc>
   3e3bc:      	ldr	w20, [sp, #0x30]
   3e3c0:      	cbnz	w20, 0x3e418 <_ZN7android19GraphicBufferMapper4lockEPK13native_handlejRKNS_4RectEPPv+0xb0>
   3e3c4:      	ldr	x9, [sp, #0x10]
   3e3c8:      	mov	x8, xzr
   3e3cc:      	str	x9, [x19]
   3e3d0:      	nop
   3e3d4:      	adr	x9, #0x2efb4
   3e3d8:      	add	x0, sp, #0xc
   3e3dc:      	ldr	x8, [x9, x8, lsl #3]
   3e3e0:      	add	x1, sp, #0x10
   3e3e4:      	blr	x8
   3e3e8:      	ldr	x8, [x21, #0x28]
   3e3ec:      	ldur	x9, [x29, #-0x8]
   3e3f0:      	cmp	x8, x9
   3e3f4:      	b.ne	0x3e414 <_ZN7android19GraphicBufferMapper4lockEPK13native_handlejRKNS_4RectEPPv+0xac>
   3e3f8:      	mov	w0, w20
   3e3fc:      	ldp	x20, x19, [sp, #0x60]
   3e400:      	ldr	x21, [sp, #0x50]
   3e404:      	ldp	x29, x30, [sp, #0x40]
   3e408:      	add	sp, sp, #0x70
   3e40c:      	autiasp
   3e410:      	ret
   3e414:      	bl	0x69468 <__stack_chk_fail@plt>
   3e418:      	add	x0, sp, #0x10
   3e41c:      	bl	0x56678 <_ZN7android13GraphicBuffer9lockAsyncEjPPviPiS3_+0x74>
   3e420:      	mov	w8, w20
   3e424:      	cmn	w20, #0x1
   3e428:      	mov	w20, w0
   3e42c:      	b.eq	0x3e3e8 <_ZN7android19GraphicBufferMapper4lockEPK13native_handlejRKNS_4RectEPPv+0x80>
   3e430:      	cmp	w8, #0x1
   3e434:      	b.ne	0x3e440 <_ZN7android19GraphicBufferMapper4lockEPK13native_handlejRKNS_4RectEPPv+0xd8>
   3e438:      	mov	w8, #0x1
   3e43c:      	b	0x3e3d0 <_ZN7android19GraphicBufferMapper4lockEPK13native_handlejRKNS_4RectEPPv+0x68>
   3e440:      	brk	#0x5503
