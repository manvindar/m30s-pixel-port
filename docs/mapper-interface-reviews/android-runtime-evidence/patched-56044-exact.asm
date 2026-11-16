
retained-evidence/provider-callers-43776923589/legacy_graphics/patched/system/lib64/libui.so:	file format elf64-littleaarch64

Disassembly of section .text:

00000000000538c8 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE>:
   56044:      	paciasp
   56048:      	sub	sp, sp, #0x40
   5604c:      	stp	x29, x30, [sp, #0x20]
   56050:      	stp	x20, x19, [sp, #0x30]
   56054:      	add	x29, sp, #0x20
   56058:      	mrs	x20, TPIDR_EL0
   5605c:      	ldr	x8, [x20, #0x28]
   56060:      	stur	x8, [x29, #-0x8]
   56064:      	ldrb	w8, [x0, #0x18]
   56068:      	cbz	w8, 0x56094 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x27cc>
   5606c:      	mov	x19, x0
   56070:      	mov	x0, sp
   56074:      	stp	x1, x2, [sp]
   56078:      	str	wzr, [sp, #0x10]
   5607c:      	bl	0x560c0 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x27f8>
   56080:      	mov	x0, sp
   56084:      	mov	x1, x19
   56088:      	bl	0x55cc8 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x2400>
   5608c:      	ldr	w0, [sp, #0x10]
   56090:      	b	0x56098 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x27d0>
   56094:      	mov	w0, wzr
   56098:      	ldr	x8, [x20, #0x28]
   5609c:      	ldur	x9, [x29, #-0x8]
   560a0:      	cmp	x8, x9
   560a4:      	b.ne	0x560bc <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x27f4>
   560a8:      	ldp	x20, x19, [sp, #0x30]
   560ac:      	ldp	x29, x30, [sp, #0x20]
   560b0:      	add	sp, sp, #0x40
   560b4:      	autiasp
   560b8:      	ret
   560bc:      	bl	0x69468 <__stack_chk_fail@plt>
