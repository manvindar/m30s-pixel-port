
retained-evidence/provider-callers-43776923589/legacy_graphics/patched/system/lib64/libui.so:	file format elf64-littleaarch64

Disassembly of section .text:

00000000000538c8 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE>:
   538d4:      	paciasp
   538d8:      	sub	sp, sp, #0x110
   538dc:      	stp	x29, x30, [sp, #0xc0]
   538e0:      	stp	x28, x25, [sp, #0xd0]
   538e4:      	stp	x24, x23, [sp, #0xe0]
   538e8:      	stp	x22, x21, [sp, #0xf0]
   538ec:      	stp	x20, x19, [sp, #0x100]
   538f0:      	add	x29, sp, #0xc0
   538f4:      	mrs	x23, TPIDR_EL0
   538f8:      	mov	x21, x2
   538fc:      	mov	x19, x1
   53900:      	ldr	x8, [x23, #0x28]
   53904:      	mov	x20, x0
   53908:      	mov	x0, x2
   5390c:      	mov	x1, xzr
   53910:      	mov	x2, xzr
   53914:      	stur	x8, [x29, #-0x8]
   53918:      	bl	0x56044 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x277c>
   5391c:      	mov	w22, w0
   53920:      	tbnz	w0, #0x1f, 0x539a0 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0xd8>
   53924:      	add	x24, sp, #0x10
   53928:      	mov	w1, wzr
   5392c:      	mov	w2, #0x88
   53930:      	add	x0, x24, #0x20
   53934:      	add	x25, x24, #0x20
   53938:      	bl	0x69480 <memset@plt>
   5393c:      	add	x8, x24, #0xa0
   53940:      	mov	w9, #0x1
   53944:      	mov	w1, w22
   53948:      	add	x0, sp, #0x10
   5394c:      	stp	x8, x25, [sp, #0x20]
   53950:      	strb	w9, [sp, #0xb0]
   53954:      	stp	x25, x25, [sp, #0x10]
   53958:      	bl	0x3c5e4 <_ZNK7android14Gralloc5Mapper11setCta861_3EPK13native_handleNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEE+0x39c>
   5395c:      	ldp	x1, x8, [sp, #0x10]
   53960:      	mov	x0, x21
   53964:      	sub	x2, x8, x1
   53968:      	bl	0x56044 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x277c>
   5396c:      	ldp	x2, x8, [sp, #0x10]
   53970:      	mov	w21, w0
   53974:      	tbnz	w0, #0x1f, 0x539c4 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0xfc>
   53978:      	sub	x4, x8, x2
   5397c:      	cmp	x4, w21, uxtw
   53980:      	b.lo	0x539c8 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x100>
   53984:      	ldr	x8, [x20, #0x58]
   53988:      	mov	w3, w21
   5398c:      	mov	x0, x19
   53990:      	mov	w1, #0x18
   53994:      	blr	x8
   53998:      	mov	w19, w0
   5399c:      	b	0x539ec <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x124>
   539a0:      	adrp	x1, 0x15000
   539a4:      	add	x1, x1, #0xce7
   539a8:      	adrp	x2, 0x15000
   539ac:      	add	x2, x2, #0x1dd
   539b0:      	mov	w0, #0x5
   539b4:      	bl	0x67c20 <__android_log_print@plt>
   539b8:      	negs	w19, w22
   539bc:      	b.vc	0x539fc <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x134>
   539c0:      	b	0x53a34 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x16c>
   539c4:      	sub	x4, x8, x2
   539c8:      	adrp	x1, 0x15000
   539cc:      	add	x1, x1, #0xce7
   539d0:      	adrp	x2, 0x16000
   539d4:      	add	x2, x2, #0x7f9
   539d8:      	mov	w0, #0x5
   539dc:      	mov	w3, w21
   539e0:      	bl	0x67c20 <__android_log_print@plt>
   539e4:      	negs	w19, w21
   539e8:      	b.vs	0x53a34 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x16c>
   539ec:      	add	x8, sp, #0x10
   539f0:      	add	x0, sp, #0x8
   539f4:      	str	x8, [sp, #0x8]
   539f8:      	bl	0x31380 <_ZN7android13FenceTimeline4pushERKNSt3__110shared_ptrINS_9FenceTimeEEE+0x1a4>
   539fc:      	ldr	x8, [x23, #0x28]
   53a00:      	ldur	x9, [x29, #-0x8]
   53a04:      	cmp	x8, x9
   53a08:      	b.ne	0x53a30 <_ZNK7android14Gralloc5Mapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x168>
   53a0c:      	mov	w0, w19
   53a10:      	ldp	x20, x19, [sp, #0x100]
   53a14:      	ldp	x22, x21, [sp, #0xf0]
   53a18:      	ldp	x24, x23, [sp, #0xe0]
   53a1c:      	ldp	x28, x25, [sp, #0xd0]
   53a20:      	ldp	x29, x30, [sp, #0xc0]
   53a24:      	add	sp, sp, #0x110
   53a28:      	autiasp
   53a2c:      	ret
   53a30:      	bl	0x69468 <__stack_chk_fail@plt>
   53a34:      	bl	0x452d8 <_ZNK7android14Gralloc5Mapper18validateBufferSizeEPK13native_handlejjijmj+0xfac>
