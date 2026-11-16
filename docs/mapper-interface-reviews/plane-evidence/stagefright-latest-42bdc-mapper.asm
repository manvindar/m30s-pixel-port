
/Users/manvindar.singh/HarnessAgents/hive/agents/pam-mw9kdvck/artifacts/android17-actions-20261115/bt-graphics-evidence-43772935293/latest-system-arm64-libui.so:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000042bdc <_ZN7android19GraphicBufferMapper4lockEPK13native_handlejRKNS_4RectEPPv>:
   42bdc:      	paciasp
   42be0:      	sub	sp, sp, #0x70
   42be4:      	stp	x29, x30, [sp, #0x40]
   42be8:      	stp	x22, x21, [sp, #0x50]
   42bec:      	stp	x20, x19, [sp, #0x60]
   42bf0:      	add	x29, sp, #0x40
   42bf4:      	mrs	x21, TPIDR_EL0
   42bf8:      	movi	v0.2d, #0000000000000000
   42bfc:      	mov	x19, x4
   42c00:      	ldr	x8, [x21, #0x28]
   42c04:      	mov	w2, w2
   42c08:      	add	x4, sp, #0xc
   42c0c:      	stur	x8, [x29, #-0x8]
   42c10:      	mov	w8, #-0x1
   42c14:      	str	w8, [sp, #0xc]
   42c18:      	add	x8, sp, #0x10
   42c1c:      	str	xzr, [sp, #0x30]
   42c20:      	stp	q0, q0, [sp, #0x10]
   42c24:      	bl	0x64b48 <_ZN7android19GraphicBufferMapper4lockEPK13native_handlelRKNS_4RectEONS_4base14unique_fd_implINS7_13DefaultCloserEEE@plt>
   42c28:      	add	x0, sp, #0xc
   42c2c:      	bl	0x42b64 <_ZN7android13GraphicBuffer6unlockEv+0x74>
   42c30:      	ldr	w22, [sp, #0x30]
   42c34:      	cbz	w22, 0x42c58 <_ZN7android19GraphicBufferMapper4lockEPK13native_handlejRKNS_4RectEPPv+0x7c>
   42c38:      	add	x0, sp, #0x10
   42c3c:      	bl	0x429f4 <_ZN7android19GraphicBufferMapper9lockAsyncEPK13native_handlejRKNS_4RectEPPvi+0x10c>
   42c40:      	cmn	w22, #0x1
   42c44:      	mov	w20, w0
   42c48:      	b.eq	0x42c80 <_ZN7android19GraphicBufferMapper4lockEPK13native_handlejRKNS_4RectEPPv+0xa4>
   42c4c:      	cmp	w22, #0x1
   42c50:      	b.eq	0x42cac <_ZN7android19GraphicBufferMapper4lockEPK13native_handlejRKNS_4RectEPPv+0xd0>
   42c54:      	brk	#0x5503
   42c58:      	ldr	x9, [sp, #0x10]
   42c5c:      	mov	x8, xzr
   42c60:      	mov	w20, wzr
   42c64:      	str	x9, [x19]
   42c68:      	nop
   42c6c:      	adr	x9, #0x261f4
   42c70:      	add	x0, sp, #0xc
   42c74:      	ldr	x8, [x9, x8, lsl #3]
   42c78:      	add	x1, sp, #0x10
   42c7c:      	blr	x8
   42c80:      	ldr	x8, [x21, #0x28]
   42c84:      	ldur	x9, [x29, #-0x8]
   42c88:      	cmp	x8, x9
   42c8c:      	b.ne	0x42cb4 <_ZN7android19GraphicBufferMapper4lockEPK13native_handlejRKNS_4RectEPPv+0xd8>
   42c90:      	mov	w0, w20
   42c94:      	ldp	x20, x19, [sp, #0x60]
   42c98:      	ldp	x22, x21, [sp, #0x50]
   42c9c:      	ldp	x29, x30, [sp, #0x40]
   42ca0:      	add	sp, sp, #0x70
   42ca4:      	autiasp
   42ca8:      	ret
   42cac:      	mov	w8, #0x1
   42cb0:      	b	0x42c68 <_ZN7android19GraphicBufferMapper4lockEPK13native_handlejRKNS_4RectEPPv+0x8c>
   42cb4:      	bl	0x65340 <__stack_chk_fail@plt>
