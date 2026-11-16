
retained-evidence/bt-graphics-evidence-43772935293/latest-system-arm64-libui.so:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000057010 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE>:
   5701c:      	paciasp
   57020:      	sub	sp, sp, #0xf0
   57024:      	stp	x29, x30, [sp, #0xb0]
   57028:      	stp	x24, x23, [sp, #0xc0]
   5702c:      	stp	x22, x21, [sp, #0xd0]
   57030:      	stp	x20, x19, [sp, #0xe0]
   57034:      	add	x29, sp, #0xb0
   57038:      	mrs	x23, TPIDR_EL0
   5703c:      	mov	x21, x2
   57040:      	mov	x19, x1
   57044:      	ldr	x8, [x23, #0x28]
   57048:      	mov	x20, x0
   5704c:      	mov	x0, x2
   57050:      	mov	x1, xzr
   57054:      	mov	x2, xzr
   57058:      	stur	x8, [x29, #-0x8]
   5705c:      	bl	0x58474 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x1464>
   57060:      	mov	w22, w0
   57064:      	tbnz	w0, #0x1f, 0x570d8 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0xc8>
   57068:      	mov	x8, sp
   5706c:      	mov	x0, sp
   57070:      	mov	w1, wzr
   57074:      	mov	w2, #0xa8
   57078:      	add	x24, x8, #0x20
   5707c:      	bl	0x65358 <memset@plt>
   57080:      	mov	x0, sp
   57084:      	str	x24, [sp, #0x18]
   57088:      	bl	0x3d448 <_ZNK7android14Gralloc5Mapper14getCompressionEPK13native_handlePN4aidl7android8hardware8graphics6common14ExtendableTypeE+0x220>
   5708c:      	mov	w1, w22
   57090:      	mov	x0, sp
   57094:      	bl	0x3e69c <_ZNK7android14Gralloc5Mapper11getBufferIdEPK13native_handlePm+0x310>
   57098:      	ldp	x1, x8, [sp]
   5709c:      	mov	x0, x21
   570a0:      	sub	x2, x8, x1
   570a4:      	bl	0x58474 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x1464>
   570a8:      	ldp	x2, x8, [sp]
   570ac:      	mov	w21, w0
   570b0:      	tbnz	w0, #0x1f, 0x570fc <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0xec>
   570b4:      	sub	x4, x8, x2
   570b8:      	cmp	x4, w21, uxtw
   570bc:      	b.lo	0x57100 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0xf0>
   570c0:      	ldr	x8, [x20, #0x58]
   570c4:      	mov	w3, w21
   570c8:      	mov	x0, x19
   570cc:      	mov	w1, #0x18
   570d0:      	blr	x8
   570d4:      	b	0x57124 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x114>
   570d8:      	adrp	x1, 0x14000
   570dc:      	add	x1, x1, #0x699
   570e0:      	adrp	x2, 0x13000
   570e4:      	add	x2, x2, #0xbf3
   570e8:      	mov	w0, #0x5
   570ec:      	bl	0x63c60 <__android_log_print@plt>
   570f0:      	negs	w0, w22
   570f4:      	b.vc	0x57140 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x130>
   570f8:      	b	0x57184 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x174>
   570fc:      	sub	x4, x8, x2
   57100:      	adrp	x1, 0x14000
   57104:      	add	x1, x1, #0x699
   57108:      	adrp	x2, 0x15000
   5710c:      	add	x2, x2, #0x193
   57110:      	mov	w0, #0x5
   57114:      	mov	w3, w21
   57118:      	bl	0x63c60 <__android_log_print@plt>
   5711c:      	negs	w0, w21
   57120:      	b.vs	0x57184 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x174>
   57124:      	ldr	x8, [sp]
   57128:      	cbz	x8, 0x57140 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x130>
   5712c:      	ldr	x9, [sp, #0x18]
   57130:      	str	x8, [sp, #0x8]
   57134:      	cmp	x8, x9
   57138:      	b.ne	0x5716c <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x15c>
   5713c:      	strb	wzr, [x9, #0x80]
   57140:      	ldr	x8, [x23, #0x28]
   57144:      	ldur	x9, [x29, #-0x8]
   57148:      	cmp	x8, x9
   5714c:      	b.ne	0x57180 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x170>
   57150:      	ldp	x20, x19, [sp, #0xe0]
   57154:      	ldp	x22, x21, [sp, #0xd0]
   57158:      	ldp	x24, x23, [sp, #0xc0]
   5715c:      	ldp	x29, x30, [sp, #0xb0]
   57160:      	add	sp, sp, #0xf0
   57164:      	autiasp
   57168:      	ret
   5716c:      	mov	w19, w0
   57170:      	mov	x0, x8
   57174:      	bl	0x63cc0 <free@plt>
   57178:      	mov	w0, w19
   5717c:      	b	0x57140 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x130>
   57180:      	bl	0x65340 <__stack_chk_fail@plt>
   57184:      	bl	0x4c8ec <_ZN7android13GraphicBuffer9unflattenERPKvRmRPKiS4_+0xd24>
