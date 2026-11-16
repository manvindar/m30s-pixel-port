
../sync-final-43779962776/legacy_graphics/patched/system/lib64/libui.so:	file format elf64-littleaarch64

Disassembly of section .text:

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
   3b800:      	add	x0, sp, #0x8
   3b804:      	mov	x21, x1
   3b808:      	mov	x1, x2
   3b80c:      	bl	0x3b764 <_ZN7android19GraphicBufferMapper15setSmpte2094_40EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0xc0>
   3b810:      	mov	x1, x21
   3b814:      	mov	w8, #0x1
   3b818:      	strb	w8, [sp, #0x20]
   3b81c:      	ldr	x8, [x19]
   3b820:      	add	x2, sp, #0x8
   3b824:      	mov	x0, x19
   3b828:      	ldr	x8, [x8, #0x158]
   3b82c:      	blr	x8
   3b830:      	ldrb	w8, [sp, #0x20]
   3b834:      	cbz	w8, 0x3b85c <_ZN7android19GraphicBufferMapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x94>
   3b838:      	ldr	x8, [sp, #0x8]
   3b83c:      	cbz	x8, 0x3b85c <_ZN7android19GraphicBufferMapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x94>
   3b840:      	ldr	x9, [sp, #0x18]
   3b844:      	mov	w19, w0
   3b848:      	mov	x0, x8
   3b84c:      	str	x8, [sp, #0x10]
   3b850:      	sub	x1, x9, x8
   3b854:      	bl	0x67ab8 <_ZdlPvm@plt>
   3b858:      	mov	w0, w19
   3b85c:      	ldr	x8, [x20, #0x28]
   3b860:      	ldur	x9, [x29, #-0x8]
   3b864:      	cmp	x8, x9
   3b868:      	b.ne	0x3b884 <_ZN7android19GraphicBufferMapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0xbc>
   3b86c:      	ldp	x20, x19, [sp, #0x50]
   3b870:      	ldr	x21, [sp, #0x40]
   3b874:      	ldp	x29, x30, [sp, #0x30]
   3b878:      	add	sp, sp, #0x60
   3b87c:      	autiasp
   3b880:      	ret
   3b884:      	bl	0x69468 <__stack_chk_fail@plt>
