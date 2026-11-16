
retained-evidence/bt-graphics-evidence-43772935293/latest-system-arm64-libui.so:	file format elf64-littleaarch64

Disassembly of section .text:

000000000003f1f4 <_ZNK7android14Gralloc5Mapper15setSmpte2094_40EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE>:
   3f3ac:      	paciasp
   3f3b0:      	stp	x29, x30, [sp, #-0x20]!
   3f3b4:      	str	x19, [sp, #0x10]
   3f3b8:      	mov	x29, sp
   3f3bc:      	ldr	w8, [x0, #0x10]
   3f3c0:      	mov	x19, x0
   3f3c4:      	tbnz	w8, #0x1f, 0x3f468 <_ZNK7android14Gralloc5Mapper15setSmpte2094_40EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x274>
   3f3c8:      	add	w8, w8, #0x8
   3f3cc:      	sxtw	x9, w8
   3f3d0:      	eor	x10, x8, x9
   3f3d4:      	orr	x11, x10, x9, asr #63
   3f3d8:      	ldp	x10, x9, [x1]
   3f3dc:      	str	w8, [x19, #0x10]
   3f3e0:      	cbnz	x11, 0x3f484 <_ZNK7android14Gralloc5Mapper15setSmpte2094_40EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x290>
   3f3e4:      	ldr	x11, [x19, #0x8]
   3f3e8:      	sub	x2, x9, x10
   3f3ec:      	cmp	x11, #0x7
   3f3f0:      	b.ls	0x3f47c <_ZNK7android14Gralloc5Mapper15setSmpte2094_40EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x288>
   3f3f4:      	ldr	x9, [x19]
   3f3f8:      	sub	x10, x11, #0x8
   3f3fc:      	add	x11, x9, #0x8
   3f400:      	stp	x11, x10, [x19]
   3f404:      	cbz	x9, 0x3f410 <_ZNK7android14Gralloc5Mapper15setSmpte2094_40EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x21c>
   3f408:      	str	x2, [x9]
   3f40c:      	ldr	w8, [x19, #0x10]
   3f410:      	tbnz	w8, #0x1f, 0x3f468 <_ZNK7android14Gralloc5Mapper15setSmpte2094_40EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x274>
   3f414:      	adds	x8, x2, w8, uxtw
   3f418:      	cset	w9, hs
   3f41c:      	sbfx	x10, x9, #0, #1
   3f420:      	str	w8, [x19, #0x10]
   3f424:      	eor	x10, x10, x9
   3f428:      	cbnz	x10, 0x3f484 <_ZNK7android14Gralloc5Mapper15setSmpte2094_40EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x290>
   3f42c:      	sxtw	x10, w8
   3f430:      	asr	x11, x10, #63
   3f434:      	and	x11, x11, #0x1
   3f438:      	cmp	x9, x11
   3f43c:      	ccmp	x8, x10, #0x0, eq
   3f440:      	b.ne	0x3f484 <_ZNK7android14Gralloc5Mapper15setSmpte2094_40EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x290>
   3f444:      	ldr	x8, [x19, #0x8]
   3f448:      	subs	x8, x8, x2
   3f44c:      	b.lo	0x3f48c <_ZNK7android14Gralloc5Mapper15setSmpte2094_40EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x298>
   3f450:      	ldr	x0, [x19]
   3f454:      	add	x9, x0, x2
   3f458:      	stp	x9, x8, [x19]
   3f45c:      	cbz	x0, 0x3f468 <_ZNK7android14Gralloc5Mapper15setSmpte2094_40EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x274>
   3f460:      	ldr	x1, [x1]
   3f464:      	bl	0x65370 <memcpy@plt>
   3f468:      	mov	x0, x19
   3f46c:      	ldr	x19, [sp, #0x10]
   3f470:      	ldp	x29, x30, [sp], #0x20
   3f474:      	autiasp
   3f478:      	ret
   3f47c:      	str	xzr, [x19, #0x8]
   3f480:      	b	0x3f410 <_ZNK7android14Gralloc5Mapper15setSmpte2094_40EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x21c>
   3f484:      	mov	w8, #-0x3
   3f488:      	str	w8, [x19, #0x10]
   3f48c:      	str	xzr, [x19, #0x8]
   3f490:      	b	0x3f468 <_ZNK7android14Gralloc5Mapper15setSmpte2094_40EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x274>
