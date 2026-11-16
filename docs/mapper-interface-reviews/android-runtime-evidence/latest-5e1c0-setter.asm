
../sync-final-43779962776/legacy_graphics/latest/system/lib64/libui.so:	file format elf64-littleaarch64

Disassembly of section .text:

000000000005e1c0 <_ZN7android19GraphicBufferMapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE>:
   5e1c0:      	paciasp
   5e1c4:      	sub	sp, sp, #0x60
   5e1c8:      	stp	x29, x30, [sp, #0x40]
   5e1cc:      	str	x19, [sp, #0x50]
   5e1d0:      	add	x29, sp, #0x40
   5e1d4:      	mrs	x19, TPIDR_EL0
   5e1d8:      	ldr	x8, [x19, #0x28]
   5e1dc:      	stur	x8, [x29, #-0x8]
   5e1e0:      	ldrb	w8, [x2, #0x18]
   5e1e4:      	ldr	x0, [x0]
   5e1e8:      	strb	wzr, [sp, #0x18]
   5e1ec:      	strb	wzr, [sp, #0x30]
   5e1f0:      	cbnz	w8, 0x5e234 <_ZN7android19GraphicBufferMapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x74>
   5e1f4:      	ldr	x8, [x0]
   5e1f8:      	add	x2, sp, #0x18
   5e1fc:      	ldr	x8, [x8, #0x158]
   5e200:      	blr	x8
   5e204:      	ldrb	w8, [sp, #0x30]
   5e208:      	cbnz	w8, 0x5e254 <_ZN7android19GraphicBufferMapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x94>
   5e20c:      	ldr	x8, [x19, #0x28]
   5e210:      	ldur	x9, [x29, #-0x8]
   5e214:      	cmp	x8, x9
   5e218:      	b.ne	0x5e230 <_ZN7android19GraphicBufferMapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x70>
   5e21c:      	ldp	x29, x30, [sp, #0x40]
   5e220:      	ldr	x19, [sp, #0x50]
   5e224:      	add	sp, sp, #0x60
   5e228:      	autiasp
   5e22c:      	ret
   5e230:      	bl	0x65340 <__stack_chk_fail@plt>
   5e234:      	stp	x1, x0, [sp, #0x8]
   5e238:      	add	x0, sp, #0x18
   5e23c:      	mov	x1, x2
   5e240:      	bl	0x43bdc <_ZN7android19GraphicBufferMapper15setSmpte2094_10EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0xc4>
   5e244:      	ldp	x1, x0, [sp, #0x8]
   5e248:      	mov	w8, #0x1
   5e24c:      	strb	w8, [sp, #0x30]
   5e250:      	b	0x5e1f4 <_ZN7android19GraphicBufferMapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x34>
   5e254:      	ldr	x8, [sp, #0x18]
   5e258:      	cbz	x8, 0x5e20c <_ZN7android19GraphicBufferMapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x4c>
   5e25c:      	ldr	x9, [sp, #0x28]
   5e260:      	str	w0, [sp, #0x10]
   5e264:      	mov	x0, x8
   5e268:      	str	x8, [sp, #0x20]
   5e26c:      	sub	x1, x9, x8
   5e270:      	bl	0x63b10 <_ZdlPvm@plt>
   5e274:      	ldr	w0, [sp, #0x10]
   5e278:      	b	0x5e20c <_ZN7android19GraphicBufferMapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x4c>
