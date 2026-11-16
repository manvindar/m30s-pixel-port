
retained-evidence/provider-callers-43776923589/legacy_graphics/patched/system/lib64/libui.so:	file format elf64-littleaarch64

Disassembly of section .text:

000000000003b6a4 <_ZN7android19GraphicBufferMapper15setSmpte2094_40EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE>:
   3b764:      	paciasp
   3b768:      	stp	x29, x30, [sp, #-0x30]!
   3b76c:      	stp	x22, x21, [sp, #0x10]
   3b770:      	stp	x20, x19, [sp, #0x20]
   3b774:      	mov	x29, sp
   3b778:      	stp	xzr, xzr, [x0]
   3b77c:      	str	xzr, [x0, #0x10]
   3b780:      	ldp	x20, x8, [x1]
   3b784:      	subs	x19, x8, x20
   3b788:      	b.eq	0x3b7b4 <_ZN7android19GraphicBufferMapper15setSmpte2094_40EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x110>
   3b78c:      	mov	x1, x19
   3b790:      	mov	x21, x0
   3b794:      	bl	0x51550 <_ZNK7android17Gralloc4Allocator8allocateENSt3__112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEEjjijmPjPPK13native_handleb+0x17b4>
   3b798:      	ldr	x22, [x21, #0x8]
   3b79c:      	mov	x1, x20
   3b7a0:      	mov	x2, x19
   3b7a4:      	mov	x0, x22
   3b7a8:      	bl	0x69450 <memmove@plt>
   3b7ac:      	add	x8, x22, x19
   3b7b0:      	str	x8, [x21, #0x8]
   3b7b4:      	ldp	x20, x19, [sp, #0x20]
   3b7b8:      	ldp	x22, x21, [sp, #0x10]
   3b7bc:      	ldp	x29, x30, [sp], #0x30
   3b7c0:      	autiasp
   3b7c4:      	ret

000000000003b7c8 <_ZN7android19GraphicBufferMapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE>:
   3b7c8:      	paciasp
   3b7cc:      	sub	sp, sp, #0x60
   3b7d0:      	stp	x29, x30, [sp, #0x30]
   3b7d4:      	str	x21, [sp, #0x40]
   3b7d8:      	stp	x20, x19, [sp, #0x50]
   3b7dc:      	add	x29, sp, #0x30
   3b7e0:      	mrs	x20, TPIDR_EL0
   3b7e4:      	ldr	x8, [x20, #0x28]
   3b7e8:      	stur	x8, [x29, #-0x8]
   3b7ec:      	ldrb	w8, [x2, #0x18]
   3b7f0:      	ldr	x19, [x0]
   3b7f4:      	strb	wzr, [sp, #0x8]
   3b7f8:      	strb	wzr, [sp, #0x20]
   3b7fc:      	cbz	w8, 0x3b81c <_ZN7android19GraphicBufferMapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x54>
