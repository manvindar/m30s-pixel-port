
retained-evidence/bt-graphics-evidence-43772935293/latest-system-arm64-libui.so:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000057010 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE>:
   58474:      	paciasp
   58478:      	sub	sp, sp, #0x40
   5847c:      	stp	x29, x30, [sp, #0x20]
   58480:      	stp	x20, x19, [sp, #0x30]
   58484:      	add	x29, sp, #0x20
   58488:      	mrs	x20, TPIDR_EL0
   5848c:      	ldr	x8, [x20, #0x28]
   58490:      	stur	x8, [x29, #-0x8]
   58494:      	ldrb	w8, [x0, #0x18]
   58498:      	cbz	w8, 0x584c4 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x14b4>
   5849c:      	mov	x19, x0
   584a0:      	mov	x0, sp
   584a4:      	stp	x1, x2, [sp]
   584a8:      	str	wzr, [sp, #0x10]
   584ac:      	bl	0x584f0 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x14e0>
   584b0:      	mov	x0, sp
   584b4:      	mov	x1, x19
   584b8:      	bl	0x3f3ac <_ZNK7android14Gralloc5Mapper15setSmpte2094_40EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x1b8>
   584bc:      	ldr	w0, [sp, #0x10]
   584c0:      	b	0x584c8 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x14b8>
   584c4:      	mov	w0, wzr
   584c8:      	ldr	x8, [x20, #0x28]
   584cc:      	ldur	x9, [x29, #-0x8]
   584d0:      	cmp	x8, x9
   584d4:      	b.ne	0x584ec <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x14dc>
   584d8:      	ldp	x20, x19, [sp, #0x30]
   584dc:      	ldp	x29, x30, [sp, #0x20]
   584e0:      	add	sp, sp, #0x40
   584e4:      	autiasp
   584e8:      	ret
   584ec:      	bl	0x65340 <__stack_chk_fail@plt>
