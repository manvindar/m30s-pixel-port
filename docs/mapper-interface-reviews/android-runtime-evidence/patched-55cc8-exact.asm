
retained-evidence/provider-callers-43776923589/legacy_graphics/patched/system/lib64/libui.so:	file format elf64-littleaarch64

Disassembly of section .text:

00000000000538c8 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE>:
   55cc8:      	ldr	w8, [x0, #0x10]
   55ccc:      	tbnz	w8, #0x1f, 0x55d78 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x24b0>
   55cd0:      	add	w8, w8, #0x8
   55cd4:      	sxtw	x9, w8
   55cd8:      	eor	x10, x8, x9
   55cdc:      	orr	x11, x10, x9, asr #63
   55ce0:      	ldp	x10, x9, [x1]
   55ce4:      	str	w8, [x0, #0x10]
   55ce8:      	cbnz	x11, 0x55d7c <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x24b4>
   55cec:      	ldr	x11, [x0, #0x8]
   55cf0:      	sub	x2, x9, x10
   55cf4:      	cmp	x11, #0x7
   55cf8:      	b.hi	0x55d48 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x2480>
   55cfc:      	str	xzr, [x0, #0x8]
   55d00:      	tbnz	w8, #0x1f, 0x55d78 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x24b0>
   55d04:      	adds	x8, x2, w8, uxtw
   55d08:      	cset	w9, hs
   55d0c:      	sbfx	x10, x9, #0, #1
   55d10:      	str	w8, [x0, #0x10]
   55d14:      	eor	x10, x10, x9
   55d18:      	cbnz	x10, 0x55d7c <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x24b4>
   55d1c:      	sxtw	x10, w8
   55d20:      	asr	x11, x10, #63
   55d24:      	and	x11, x11, #0x1
   55d28:      	cmp	x9, x11
   55d2c:      	ccmp	x8, x10, #0x0, eq
   55d30:      	b.ne	0x55d7c <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x24b4>
   55d34:      	ldr	x8, [x0, #0x8]
   55d38:      	subs	x9, x8, x2
   55d3c:      	b.hs	0x55d68 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x24a0>
   55d40:      	str	xzr, [x0, #0x8]
   55d44:      	ret
   55d48:      	ldr	x9, [x0]
   55d4c:      	sub	x10, x11, #0x8
   55d50:      	add	x11, x9, #0x8
   55d54:      	stp	x11, x10, [x0]
   55d58:      	cbz	x9, 0x55d00 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x2438>
   55d5c:      	str	x2, [x9]
   55d60:      	ldr	w8, [x0, #0x10]
   55d64:      	b	0x55d00 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x2438>
   55d68:      	ldr	x8, [x0]
   55d6c:      	add	x10, x8, x2
   55d70:      	stp	x10, x9, [x0]
   55d74:      	cbnz	x8, 0x55d8c <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x24c4>
   55d78:      	ret
   55d7c:      	mov	w8, #-0x3
   55d80:      	str	xzr, [x0, #0x8]
   55d84:      	str	w8, [x0, #0x10]
   55d88:      	ret
   55d8c:      	paciasp
   55d90:      	sub	sp, sp, #0x20
   55d94:      	stp	x29, x30, [sp, #0x10]
   55d98:      	add	x29, sp, #0x10
   55d9c:      	ldr	x1, [x1]
   55da0:      	str	x0, [sp, #0x8]
   55da4:      	mov	x0, x8
   55da8:      	bl	0x69498 <memcpy@plt>
   55dac:      	ldr	x0, [sp, #0x8]
   55db0:      	ldp	x29, x30, [sp, #0x10]
   55db4:      	add	sp, sp, #0x20
   55db8:      	autiasp
   55dbc:      	b	0x55d78 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x24b0>
