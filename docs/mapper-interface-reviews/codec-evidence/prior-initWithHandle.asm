
retained-evidence/bt-graphics-evidence-43772935293/prior-system-arm64-libui.so:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000039de8 <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijmj>:
   39de8:      	paciasp
   39dec:      	sub	sp, sp, #0x60
   39df0:      	stp	x29, x30, [sp, #0x20]
   39df4:      	str	x23, [sp, #0x30]
   39df8:      	stp	x22, x21, [sp, #0x40]
   39dfc:      	stp	x20, x19, [sp, #0x50]
   39e00:      	add	x29, sp, #0x20
   39e04:      	mrs	x22, TPIDR_EL0
   39e08:      	mov	x23, x0
   39e0c:      	mov	x8, x7
   39e10:      	ldr	x9, [x22, #0x28]
   39e14:      	ldr	w7, [x29, #0x40]
   39e18:      	tst	w2, #0xff
   39e1c:      	mov	x20, x1
   39e20:      	mov	x19, x0
   39e24:      	cset	w10, ne
   39e28:      	stur	x9, [x29, #-0x8]
   39e2c:      	mov	w9, w6
   39e30:      	stp	w3, w4, [x23, #0x48]!
   39e34:      	str	x9, [x23, #0x18]
   39e38:      	and	w9, w2, #0xfe
   39e3c:      	cmp	w9, #0x2
   39e40:      	stp	w7, w5, [x23, #0x8]
   39e44:      	str	x8, [x23, #0x30]
   39e48:      	str	w8, [x23, #0x10]
   39e4c:      	strb	w10, [x23, #0x70]
   39e50:      	b.ne	0x39eb4 <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijmj+0xcc>
   39e54:      	ldr	x0, [x19, #0xc0]
   39e58:      	mov	w21, w2
   39e5c:      	add	x9, sp, #0x10
   39e60:      	mov	x1, x20
   39e64:      	mov	w2, w3
   39e68:      	mov	w3, w4
   39e6c:      	mov	w4, w6
   39e70:      	mov	x6, x8
   39e74:      	str	xzr, [sp, #0x10]
   39e78:      	str	x9, [sp]
   39e7c:      	bl	0x68c28 <_ZN7android19GraphicBufferMapper12importBufferEPK13native_handlejjjimjPS3_@plt>
   39e80:      	cbnz	w0, 0x39ec0 <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijmj+0xd8>
   39e84:      	and	w8, w21, #0xff
   39e88:      	cmp	w8, #0x2
   39e8c:      	b.eq	0x39f04 <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijmj+0x11c>
   39e90:      	ldr	x8, [x19, #0xc0]
   39e94:      	ldr	x20, [sp, #0x10]
   39e98:      	add	x2, x19, #0xd0
   39e9c:      	add	x3, x19, #0xd4
   39ea0:      	ldr	x0, [x8]
   39ea4:      	mov	x1, x20
   39ea8:      	ldr	x8, [x0]
   39eac:      	ldr	x8, [x8, #0x38]
   39eb0:      	blr	x8
   39eb4:      	mov	w0, wzr
   39eb8:      	str	x20, [x19, #0x70]
   39ebc:      	b	0x39ed4 <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijmj+0xec>
   39ec0:      	str	xzr, [x19, #0x60]
   39ec4:      	strb	wzr, [x19, #0xb8]
   39ec8:      	stp	xzr, xzr, [x23]
   39ecc:      	str	wzr, [x23, #0x10]
   39ed0:      	stp	xzr, xzr, [x19, #0x70]
   39ed4:      	ldr	x8, [x22, #0x28]
   39ed8:      	ldur	x9, [x29, #-0x8]
   39edc:      	cmp	x8, x9
   39ee0:      	b.ne	0x39f00 <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijmj+0x118>
   39ee4:      	ldp	x20, x19, [sp, #0x50]
   39ee8:      	ldr	x23, [sp, #0x30]
   39eec:      	ldp	x22, x21, [sp, #0x40]
   39ef0:      	ldp	x29, x30, [sp, #0x20]
   39ef4:      	add	sp, sp, #0x60
   39ef8:      	autiasp
   39efc:      	ret
   39f00:      	bl	0x69468 <__stack_chk_fail@plt>
   39f04:      	mov	x0, x20
   39f08:      	bl	0x68c40 <native_handle_close@plt>
   39f0c:      	mov	x0, x20
   39f10:      	bl	0x68778 <native_handle_delete@plt>
   39f14:      	b	0x39e90 <_ZN7android13GraphicBuffer14initWithHandleEPK13native_handleNS0_16HandleWrapMethodEjjijmj+0xa8>
