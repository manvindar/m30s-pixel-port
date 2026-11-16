  17bdc0:      	paciasp
  17bdc4:      	stp	x29, x30, [sp, #-0x60]!
  17bdc8:      	stp	x28, x27, [sp, #0x10]
  17bdcc:      	stp	x26, x25, [sp, #0x20]
  17bdd0:      	stp	x24, x23, [sp, #0x30]
  17bdd4:      	stp	x22, x21, [sp, #0x40]
  17bdd8:      	stp	x20, x19, [sp, #0x50]
  17bddc:      	mov	x29, sp
  17bde0:      	sub	sp, sp, #0x360
  17bde4:      	mrs	x24, TPIDR_EL0
  17bde8:      	sub	x9, x0, #0x10
  17bdec:      	mov	x19, x0
  17bdf0:      	cmp	x0, #0x0
  17bdf4:      	ldr	x8, [x24, #0x28]
  17bdf8:      	mov	w20, w2
  17bdfc:      	csel	x22, xzr, x9, eq
  17be00:      	mov	x21, x1
  17be04:      	add	x0, x22, #0x248
  17be08:      	stur	x8, [x29, #-0x18]
  17be0c:      	bl	0x1e75b8 <_ZNSt3__119__shared_mutex_base11lock_sharedEv@plt>
  17be10:      	ldr	x8, [x19, #0x2f8]
  17be14:      	cbz	x8, 0x17be7c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xbc>
  17be18:      	adrp	x1, 0x212000 <_ZTTN7android3gui21BpWindowInfosListenerE+0x48>
  17be1c:      	ldr	x2, [x19, #0x300]
  17be20:      	mov	x0, x19
  17be24:      	ldr	x1, [x1, #0xb30]
  17be28:      	mov	x3, x21
  17be2c:      	mov	w4, w20
  17be30:      	blr	x8
  17be34:      	mov	w19, w0
  17be38:      	add	x0, x22, #0x248
  17be3c:      	bl	0x1e75d0 <_ZNSt3__119__shared_mutex_base13unlock_sharedEv@plt>
  17be40:      	ldr	x8, [x24, #0x28]
  17be44:      	ldur	x9, [x29, #-0x18]
  17be48:      	cmp	x8, x9
  17be4c:      	b.eq	0x17be54 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x94>
  17be50:      	bl	0x1eb0c8 <__stack_chk_fail@plt>
  17be54:      	mov	w0, w19
  17be58:      	add	sp, sp, #0x360
  17be5c:      	ldp	x20, x19, [sp, #0x50]
  17be60:      	ldp	x22, x21, [sp, #0x40]
  17be64:      	ldp	x24, x23, [sp, #0x30]
  17be68:      	ldp	x26, x25, [sp, #0x20]
  17be6c:      	ldp	x28, x27, [sp, #0x10]
  17be70:      	ldp	x29, x30, [sp], #0x60
  17be74:      	autiasp
  17be78:      	ret
  17be7c:      	add	x0, x22, #0x248
  17be80:      	bl	0x1e75d0 <_ZNSt3__119__shared_mutex_base13unlock_sharedEv@plt>
  17be84:      	add	x8, sp, #0x20
  17be88:      	mov	x0, x21
  17be8c:      	bl	0x1e71c8 <_ZN7android13GraphicBuffer4fromEP19ANativeWindowBuffer@plt>
  17be90:      	mov	w0, #0x10
  17be94:      	bl	0x1e5590 <_Znwm@plt>
  17be98:      	mov	w1, w20
  17be9c:      	mov	x21, x0
  17bea0:      	bl	0x1e75e8 <_ZN7android5FenceC1Ei@plt>
  17bea4:      	add	x1, x21, #0x8
  17bea8:      	mov	w0, #0x1
  17beac:      	str	x21, [sp, #0x18]
  17beb0:      	bl	0x173080 <_ZN7android13layer_state_t4readERKNS_6ParcelE+0x3fb8>
  17beb4:      	bl	0x1e5e60 <atrace_get_enabled_tags@plt>
  17beb8:      	tbz	w0, #0x1, 0x17bec8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x108>
  17bebc:      	adrp	x0, 0x6c000
  17bec0:      	add	x0, x0, #0xe49
  17bec4:      	bl	0x1e5e30 <atrace_begin_body@plt>
  17bec8:      	add	x0, x19, #0x4d0
  17becc:      	bl	0x1e5ea8 <_ZNSt3__15mutex4lockEv@plt>
  17bed0:      	add	x0, x19, #0x4d0
  17bed4:      	bl	0x1e5ec0 <_ZNSt3__15mutex6unlockEv@plt>
  17bed8:      	ldr	x8, [sp, #0x20]
  17bedc:      	cbz	x8, 0x17cc64 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xea4>
  17bee0:      	mov	w8, #0x502b
  17bee4:      	movi	v1.2d, #0000000000000000
  17bee8:      	add	x20, sp, #0x50
  17beec:      	movk	w8, #0xfe, lsl #16
  17bef0:      	add	x0, sp, #0xc0
  17bef4:      	mov	w1, wzr
  17bef8:      	dup	v0.2d, x8
  17befc:      	mov	w8, #0x40
  17bf00:      	mov	w2, #0x108
  17bf04:      	str	xzr, [sp, #0xb0]
  17bf08:      	add	x26, sp, #0xc0
  17bf0c:      	add	x25, sp, #0xc0
  17bf10:      	stp	q1, q1, [sp, #0x60]
  17bf14:      	stp	q1, q1, [sp, #0x80]
  17bf18:      	str	q1, [x20, #0x50]
  17bf1c:      	str	q1, [sp, #0x50]
  17bf20:      	stur	q0, [sp, #0x88]
  17bf24:      	str	w8, [sp, #0xa8]
  17bf28:      	bl	0x1eb0e0 <memset@plt>
  17bf2c:      	adrp	x8, 0x212000 <_ZTTN7android3gui21BpWindowInfosListenerE+0x48>
  17bf30:      	add	x0, x25, #0x38
  17bf34:      	ldr	x8, [x8, #0x9f0]
  17bf38:      	str	xzr, [sp, #0xf0]
  17bf3c:      	ldr	q0, [x8]
  17bf40:      	str	q0, [x20, #0x80]
  17bf44:      	bl	0x1e5608 <_ZN7android6RegionC1Ev@plt>
  17bf48:      	movi	v0.2d, #0000000000000000
  17bf4c:      	mov	w8, #-0x1
  17bf50:      	add	x0, x19, #0x210
  17bf54:      	strh	wzr, [sp, #0x160]
  17bf58:      	strb	wzr, [sp, #0x1c0]
  17bf5c:      	str	w8, [sp, #0x164]
  17bf60:      	stur	q0, [x26, #0xa8]
  17bf64:      	stur	q0, [x26, #0xb8]
  17bf68:      	stur	q0, [x26, #0xc8]
  17bf6c:      	str	wzr, [sp, #0x198]
  17bf70:      	stp	xzr, xzr, [sp, #0x1a8]
  17bf74:      	str	xzr, [sp, #0x1a0]
  17bf78:      	strb	wzr, [sp, #0x1b8]
  17bf7c:      	str	wzr, [sp, #0x2c]
  17bf80:      	bl	0x1e5ae8 <pthread_mutex_lock@plt>
  17bf84:      	ldr	x8, [sp, #0x20]
  17bf88:      	cbz	x8, 0x17c010 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x250>
  17bf8c:      	ldr	w9, [x19, #0x158]
  17bf90:      	add	x20, x19, #0x130
  17bf94:      	cbnz	w9, 0x17c330 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x570>
  17bf98:      	ldr	x9, [x20]
  17bf9c:      	cbz	x9, 0x17d2fc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x153c>
  17bfa0:      	add	x21, x19, #0x138
  17bfa4:      	ldr	x23, [x8, #0xd8]
  17bfa8:      	add	x0, x19, #0x128
  17bfac:      	bl	0xc8b5c <_ZN7android10BufferItemD2Ev+0x2b5c>
  17bfb0:      	cmp	x21, x0
  17bfb4:      	b.eq	0x17bfd4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x214>
  17bfb8:      	ldr	x8, [x21]
  17bfbc:      	cmp	x8, x23
  17bfc0:      	b.eq	0x17bfd4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x214>
  17bfc4:      	add	x21, x21, #0x8
  17bfc8:      	cmp	x21, x0
  17bfcc:      	b.ne	0x17bfb8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1f8>
  17bfd0:      	mov	x21, x0
  17bfd4:      	ldr	w8, [x19, #0x158]
  17bfd8:      	cmp	w8, #0x1
  17bfdc:      	b.ne	0x17c548 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x788>
  17bfe0:      	ldr	x8, [x19, #0x138]
  17bfe4:      	cmp	x21, x8
  17bfe8:      	b.eq	0x17d2fc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x153c>
  17bfec:      	sub	x9, x8, #0x8
  17bff0:      	cmp	x21, x9
  17bff4:      	b.eq	0x17c004 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x244>
  17bff8:      	ldr	x8, [x9]
  17bffc:      	str	x8, [x21]
  17c000:      	ldr	x8, [x19, #0x138]
  17c004:      	sub	x8, x8, #0x8
  17c008:      	str	x8, [x19, #0x138]
  17c00c:      	mov	w8, #0x1
  17c010:      	ldr	w10, [x19, #0x120]
  17c014:      	cbnz	w10, 0x17d1e0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1420>
  17c018:      	ldr	x11, [x19, #0xf8]
  17c01c:      	add	x9, x19, #0x100
  17c020:      	add	x12, x9, x11, lsl #3
  17c024:      	cmp	x9, x12
  17c028:      	b.ne	0x17cef0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1130>
  17c02c:      	cbnz	w10, 0x17d304 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1544>
  17c030:      	add	x10, x19, x11, lsl #3
  17c034:      	add	x10, x10, #0x100
  17c038:      	cmp	x9, x10
  17c03c:      	b.ne	0x17c798 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x9d8>
  17c040:      	cbz	w8, 0x17c04c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x28c>
  17c044:      	ldrb	w8, [x19, #0x328]
  17c048:      	cbz	w8, 0x17cbb0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xdf0>
  17c04c:      	ldr	x8, [sp, #0x20]
  17c050:      	cbz	x8, 0x17cd54 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xf94>
  17c054:      	ldp	x9, x8, [x19, #0xd8]
  17c058:      	mov	w21, #0xeeef
  17c05c:      	movk	w21, #0xeeee, lsl #16
  17c060:      	add	x12, sp, #0x240
  17c064:      	mov	w11, #0x1
  17c068:      	add	x27, x12, #0x20
  17c06c:      	str	xzr, [sp, #0x270]
  17c070:      	sub	x10, x8, x9
  17c074:      	str	xzr, [sp, #0x268]
  17c078:      	lsr	x10, x10, #3
  17c07c:      	strb	w11, [sp, #0x270]
  17c080:      	str	xzr, [sp, #0x260]
  17c084:      	mul	w10, w10, w21
  17c088:      	str	x27, [sp, #0x240]
  17c08c:      	str	x27, [sp, #0x248]
  17c090:      	str	x27, [sp, #0x258]
  17c094:      	cmp	w10, #0x1
  17c098:      	add	x10, x12, #0x30
  17c09c:      	str	x10, [sp, #0x250]
  17c0a0:      	b.ge	0x17d378 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x15b8>
  17c0a4:      	add	x0, x19, #0x4d0
  17c0a8:      	bl	0x1e5ea8 <_ZNSt3__15mutex4lockEv@plt>
  17c0ac:      	ldr	x8, [sp, #0x20]
  17c0b0:      	ldr	x3, [x19, #0x4f8]
  17c0b4:      	adrp	x1, 0x7a000
  17c0b8:      	add	x1, x1, #0x92e
  17c0bc:      	ldr	x4, [x19, #0x500]
  17c0c0:      	adrp	x2, 0x76000
  17c0c4:      	add	x2, x2, #0x5d9
  17c0c8:      	ldr	x6, [x8, #0x70]
  17c0cc:      	ldr	x7, [x8, #0xd8]
  17c0d0:      	adrp	x5, 0x70000
  17c0d4:      	add	x5, x5, #0x958
  17c0d8:      	mov	w0, #0x6
  17c0dc:      	bl	0x1e59f8 <__android_log_print@plt>
  17c0e0:      	add	x0, x19, #0x4d0
  17c0e4:      	bl	0x1e5ec0 <_ZNSt3__15mutex6unlockEv@plt>
  17c0e8:      	ldr	x0, [sp, #0x240]
  17c0ec:      	cbz	x0, 0x17cd8c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xfcc>
  17c0f0:      	mov	w22, #-0x16
  17c0f4:      	ldr	x8, [sp, #0x258]
  17c0f8:      	str	x0, [sp, #0x248]
  17c0fc:      	cmp	x0, x8
  17c100:      	b.ne	0x17d3e0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1620>
  17c104:      	strb	wzr, [x8, #0x10]
  17c108:      	str	w22, [sp, #0x2c]
  17c10c:      	tbnz	w22, #0x1f, 0x17c9d0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xc10>
  17c110:      	ldr	w8, [x19, #0x3a8]
  17c114:      	cmp	w8, w22
  17c118:      	b.ne	0x17c124 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x364>
  17c11c:      	ldrb	w8, [x19, #0x3ac]
  17c120:      	tbnz	w8, #0x0, 0x17cbb0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xdf0>
  17c124:      	ldr	x20, [x19, #0x178]
  17c128:      	mov	x8, #-0x8000000000000000
  17c12c:      	cmp	x20, x8
  17c130:      	b.ne	0x17d3e8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1628>
  17c134:      	mov	w0, #0x1
  17c138:      	mov	w21, #0x1
  17c13c:      	bl	0x1e6220 <systemTime@plt>
  17c140:      	mov	x20, x0
  17c144:      	add	x0, x19, #0x4d0
  17c148:      	bl	0x1e5ea8 <_ZNSt3__15mutex4lockEv@plt>
  17c14c:      	add	x0, x19, #0x4d0
  17c150:      	bl	0x1e5ec0 <_ZNSt3__15mutex6unlockEv@plt>
  17c154:      	ldr	x8, [sp, #0x20]
  17c158:      	add	x0, x19, #0x1dc
  17c15c:      	add	x1, sp, #0x240
  17c160:      	add	x2, sp, #0x40
  17c164:      	stp	xzr, xzr, [sp, #0x40]
  17c168:      	add	x27, sp, #0x240
  17c16c:      	ldr	d0, [x8, #0x48]
  17c170:      	str	xzr, [sp, #0x240]
  17c174:      	add	x28, sp, #0x240
  17c178:      	str	d0, [sp, #0x248]
  17c17c:      	bl	0x1e6208 <_ZNK7android4Rect9intersectERKS0_PS0_@plt>
  17c180:      	add	x0, x28, #0x28
  17c184:      	mov	w1, wzr
  17c188:      	mov	w2, #0xe0
  17c18c:      	bl	0x1eb0e0 <memset@plt>
  17c190:      	ldr	w8, [x19, #0x180]
  17c194:      	ldr	w10, [x19, #0x1f0]
  17c198:      	ldr	w11, [x19, #0x1f4]
  17c19c:      	str	x20, [sp, #0x240]
  17c1a0:      	ldr	w9, [x19, #0x1ec]
  17c1a4:      	ldr	q0, [sp, #0x40]
  17c1a8:      	str	w8, [sp, #0x24c]
  17c1ac:      	eor	w8, w11, w10
  17c1b0:      	ldrb	w20, [x19, #0x40a]
  17c1b4:      	str	w8, [sp, #0x264]
  17c1b8:      	ldr	x8, [sp, #0x18]
  17c1bc:      	str	w21, [sp, #0x248]
  17c1c0:      	str	q0, [x26, #0x190]
  17c1c4:      	str	w9, [sp, #0x260]
  17c1c8:      	str	w11, [sp, #0x268]
  17c1cc:      	str	x8, [sp, #0x270]
  17c1d0:      	cbz	x8, 0x17c1e0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x420>
  17c1d4:      	add	x1, x8, #0x8
  17c1d8:      	mov	w0, #0x1
  17c1dc:      	bl	0x173080 <_ZN7android13layer_state_t4readERKNS_6ParcelE+0x3fb8>
  17c1e0:      	add	x0, x28, #0x38
  17c1e4:      	bl	0x1e5608 <_ZN7android6RegionC1Ev@plt>
  17c1e8:      	add	x8, x19, #0x188
  17c1ec:      	add	x9, x28, #0xe0
  17c1f0:      	ldr	w10, [x19, #0x1b8]
  17c1f4:      	ldp	q0, q1, [x8]
  17c1f8:      	add	x11, x19, #0x1c0
  17c1fc:      	cmp	x9, x11
  17c200:      	strb	w20, [sp, #0x2e0]
  17c204:      	strb	wzr, [sp, #0x2e1]
  17c208:      	stur	q0, [x27, #0xa8]
  17c20c:      	ldr	q0, [x8, #0x20]
  17c210:      	mov	w8, #-0x1
  17c214:      	strb	wzr, [sp, #0x340]
  17c218:      	str	xzr, [sp, #0x330]
  17c21c:      	str	xzr, [sp, #0x320]
  17c220:      	str	xzr, [sp, #0x328]
  17c224:      	stur	q1, [x27, #0xb8]
  17c228:      	strb	wzr, [sp, #0x338]
  17c22c:      	stur	q0, [x27, #0xc8]
  17c230:      	str	w8, [sp, #0x2e4]
  17c234:      	str	w10, [sp, #0x318]
  17c238:      	b.eq	0x17c248 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x488>
  17c23c:      	ldp	x20, x8, [x19, #0x1c0]
  17c240:      	subs	x21, x8, x20
  17c244:      	b.ne	0x17ce10 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1050>
  17c248:      	ldrb	w8, [x19, #0x329]
  17c24c:      	tbnz	w8, #0x0, 0x17cb24 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xd64>
  17c250:      	ldr	x8, [x19, #0x338]
  17c254:      	ldur	x9, [x8, #-0x10]
  17c258:      	cbnz	x9, 0x17c268 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x4a8>
  17c25c:      	ldur	x8, [x8, #-0x8]
  17c260:      	cmn	x8, #0x1
  17c264:      	b.eq	0x17cb24 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xd64>
  17c268:      	ldr	x8, [sp, #0x20]
  17c26c:      	movi	v0.2d, #0000000000000000
  17c270:      	ldr	w10, [x19, #0x1f0]
  17c274:      	ldr	w11, [x19, #0x1f4]
  17c278:      	add	x0, sp, #0x1d0
  17c27c:      	ldp	w9, w8, [x8, #0x48]
  17c280:      	eor	w10, w11, w10
  17c284:      	str	xzr, [sp, #0x230]
  17c288:      	tst	w10, #0x4
  17c28c:      	stp	q0, q0, [x26, #0x110]
  17c290:      	stp	q0, q0, [x26, #0x130]
  17c294:      	csel	w22, w8, w9, eq
  17c298:      	csel	w23, w9, w8, eq
  17c29c:      	stp	q0, q0, [x26, #0x150]
  17c2a0:      	bl	0x1e5608 <_ZN7android6RegionC1Ev@plt>
  17c2a4:      	add	x0, x19, #0x330
  17c2a8:      	bl	0x1e7210 <_ZNK7android6Region5beginEv@plt>
  17c2ac:      	mov	x20, x0
  17c2b0:      	add	x0, x19, #0x330
  17c2b4:      	bl	0x1e7228 <_ZNK7android6Region3endEv@plt>
  17c2b8:      	cmp	x20, x0
  17c2bc:      	b.eq	0x17c33c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x57c>
  17c2c0:      	mov	x21, x0
  17c2c4:      	ldr	w9, [x19, #0x1f0]
  17c2c8:      	ldr	w10, [x19, #0x1f4]
  17c2cc:      	ldp	w8, w11, [x20]
  17c2d0:      	eor	w13, w10, w9
  17c2d4:      	ldp	w9, w10, [x20, #0x8]
  17c2d8:      	cmp	w13, #0x3
  17c2dc:      	b.ne	0x17c30c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x54c>
  17c2e0:      	sub	w9, w23, w9
  17c2e4:      	sub	w8, w23, w8
  17c2e8:      	stp	w9, w11, [sp, #0x30]
  17c2ec:      	stp	w8, w10, [sp, #0x38]
  17c2f0:      	add	x0, sp, #0x1d0
  17c2f4:      	add	x1, sp, #0x30
  17c2f8:      	bl	0x1e7240 <_ZN7android6Region6orSelfERKNS_4RectE@plt>
  17c2fc:      	add	x20, x20, #0x10
  17c300:      	cmp	x20, x21
  17c304:      	b.ne	0x17c2c4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x504>
  17c308:      	b	0x17c33c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x57c>
  17c30c:      	cmp	w13, #0x4
  17c310:      	sub	w14, w22, w10
  17c314:      	sub	w12, w22, w11
  17c318:      	b.ne	0x17d53c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x177c>
  17c31c:      	sub	w9, w23, w9
  17c320:      	sub	w8, w23, w8
  17c324:      	stp	w14, w9, [sp, #0x30]
  17c328:      	stp	w12, w8, [sp, #0x38]
  17c32c:      	b	0x17c2f0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x530>
  17c330:      	cmp	w9, #0x1
  17c334:      	b.eq	0x17d2f0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1530>
  17c338:      	bl	0xc8b94 <_ZN7android10BufferItemD2Ev+0x2b94>
  17c33c:      	add	x0, x28, #0x38
  17c340:      	add	x1, sp, #0x1d0
  17c344:      	bl	0x1e5c80 <_ZN7android6RegionaSERKS0_@plt>
  17c348:      	add	x0, sp, #0x1d0
  17c34c:      	bl	0x1e5620 <_ZN7android6RegionD1Ev@plt>
  17c350:      	ldp	q0, q1, [x27]
  17c354:      	ldrb	w8, [x19, #0x518]
  17c358:      	ldur	q2, [x27, #0x1c]
  17c35c:      	strb	w8, [sp, #0x2e1]
  17c360:      	stp	q0, q1, [x26]
  17c364:      	stur	q2, [x26, #0x1c]
  17c368:      	ldr	x20, [sp, #0xf0]
  17c36c:      	ldr	x21, [sp, #0x270]
  17c370:      	cbz	x21, 0x17c380 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x5c0>
  17c374:      	add	x1, x21, #0x8
  17c378:      	mov	w0, #0x1
  17c37c:      	bl	0x173080 <_ZN7android13layer_state_t4readERKNS_6ParcelE+0x3fb8>
  17c380:      	cbnz	x20, 0x17cec4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1104>
  17c384:      	ldr	x8, [sp, #0xf0]
  17c388:      	cmp	x20, x8
  17c38c:      	b.ne	0x17d0f0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1330>
  17c390:      	add	x0, x25, #0x38
  17c394:      	add	x1, x28, #0x38
  17c398:      	str	x21, [sp, #0xf0]
  17c39c:      	bl	0x1e5c80 <_ZN7android6RegionaSERKS0_@plt>
  17c3a0:      	ldur	q0, [x28, #0xa8]
  17c3a4:      	ldr	x8, [sp, #0x2e0]
  17c3a8:      	ldr	x1, [sp, #0x320]
  17c3ac:      	ldr	x23, [sp, #0x328]
  17c3b0:      	ldr	x9, [sp, #0x1b0]
  17c3b4:      	ldr	x22, [sp, #0x1a0]
  17c3b8:      	stur	q0, [x25, #0xa8]
  17c3bc:      	ldur	q0, [x28, #0xb8]
  17c3c0:      	ldur	w10, [x28, #0xd8]
  17c3c4:      	sub	x20, x23, x1
  17c3c8:      	str	x8, [sp, #0x160]
  17c3cc:      	sub	x8, x9, x22
  17c3d0:      	cmp	x20, x8
  17c3d4:      	stur	q0, [x25, #0xb8]
  17c3d8:      	ldur	q0, [x28, #0xc8]
  17c3dc:      	stur	w10, [x25, #0xd8]
  17c3e0:      	stur	q0, [x25, #0xc8]
  17c3e4:      	b.hi	0x17cda0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xfe0>
  17c3e8:      	ldr	x8, [sp, #0x1a8]
  17c3ec:      	sub	x2, x8, x22
  17c3f0:      	cmp	x20, x2
  17c3f4:      	b.hi	0x17d488 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x16c8>
  17c3f8:      	mov	x0, x22
  17c3fc:      	mov	x2, x20
  17c400:      	bl	0x1eb0b0 <memmove@plt>
  17c404:      	add	x8, x22, x20
  17c408:      	ldur	x9, [x28, #0xf8]
  17c40c:      	str	x8, [sp, #0x1a8]
  17c410:      	ldrb	w8, [x28, #0x100]
  17c414:      	ldr	x0, [sp, #0x320]
  17c418:      	stur	x9, [x25, #0xf8]
  17c41c:      	strb	w8, [x25, #0x100]
  17c420:      	cbnz	x0, 0x17d3f0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1630>
  17c424:      	add	x0, x28, #0x38
  17c428:      	bl	0x1e5620 <_ZN7android6RegionD1Ev@plt>
  17c42c:      	ldr	x20, [sp, #0x270]
  17c430:      	cbz	x20, 0x17c448 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x688>
  17c434:      	add	x1, x20, #0x8
  17c438:      	mov	w0, #-0x1
  17c43c:      	bl	0x173420 <_ZN7android13layer_state_t4readERKNS_6ParcelE+0x4358>
  17c440:      	cmp	w0, #0x1
  17c444:      	b.eq	0x17cf8c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x11cc>
  17c448:      	bl	0x1e5e60 <atrace_get_enabled_tags@plt>
  17c44c:      	tbnz	w0, #0x1, 0x17cfa4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x11e4>
  17c450:      	adrp	x0, 0x212000 <_ZTTN7android3gui21BpWindowInfosListenerE+0x48>
  17c454:      	ldr	x0, [x0, #0xb88]
  17c458:      	bl	0x1e5ae8 <pthread_mutex_lock@plt>
  17c45c:      	adrp	x21, 0x212000 <_ZTTN7android3gui21BpWindowInfosListenerE+0x48>
  17c460:      	ldr	x21, [x21, #0xb90]
  17c464:      	ldr	x20, [x21]
  17c468:      	cbz	x20, 0x17ce48 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1088>
  17c46c:      	adrp	x0, 0x212000 <_ZTTN7android3gui21BpWindowInfosListenerE+0x48>
  17c470:      	ldr	x0, [x0, #0xb88]
  17c474:      	bl	0x1e5b00 <pthread_mutex_unlock@plt>
  17c478:      	ldr	x8, [sp, #0x20]
  17c47c:      	ldr	w2, [sp, #0xcc]
  17c480:      	mov	x0, x20
  17c484:      	ldr	x1, [x8, #0x70]
  17c488:      	bl	0x1e7258 <_ZN7android19GraphicBufferMapper12setDataspaceEPK13native_handleNS_8hardware8graphics6common4V1_29DataspaceE@plt>
  17c48c:      	ldr	w8, [x19, #0x1d8]
  17c490:      	tbnz	w8, #0x0, 0x17cf1c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x115c>
  17c494:      	tbnz	w8, #0x1, 0x17ce78 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x10b8>
  17c498:      	tbz	w8, #0x2, 0x17c4d8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x718>
  17c49c:      	ldr	x8, [sp, #0x20]
  17c4a0:      	ldrb	w9, [sp, #0x168]
  17c4a4:      	ldr	x21, [x8, #0x70]
  17c4a8:      	tbz	w9, #0x2, 0x17d404 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1644>
  17c4ac:      	add	x0, sp, #0x1d0
  17c4b0:      	add	x1, x25, #0xe0
  17c4b4:      	bl	0x12f1cc <_ZNK7android3gui17IBLASTBufferQueue22getInterfaceDescriptorEv+0xc0>
  17c4b8:      	mov	w8, #0x1
  17c4bc:      	add	x2, sp, #0x1d0
  17c4c0:      	mov	x0, x20
  17c4c4:      	mov	x1, x21
  17c4c8:      	strb	w8, [sp, #0x1e8]
  17c4cc:      	bl	0x1e72a0 <_ZN7android19GraphicBufferMapper15setSmpte2094_40EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE@plt>
  17c4d0:      	ldrb	w8, [sp, #0x1e8]
  17c4d4:      	cbnz	w8, 0x17d410 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1650>
  17c4d8:      	bl	0x1e5e60 <atrace_get_enabled_tags@plt>
  17c4dc:      	tbnz	w0, #0x1, 0x17cfb4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x11f4>
  17c4e0:      	ldr	w22, [sp, #0x2c]
  17c4e4:      	ldr	x8, [x19, #0x458]
  17c4e8:      	add	x15, x19, #0x450
  17c4ec:      	str	w22, [sp, #0x164]
  17c4f0:      	cbz	x8, 0x17c5d8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x818>
  17c4f4:      	ldr	x9, [x19, #0x468]
  17c4f8:      	cbz	x9, 0x17c5d8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x818>
  17c4fc:      	sub	x10, x8, #0x1
  17c500:      	sxtw	x9, w22
  17c504:      	tst	x8, x10
  17c508:      	b.ne	0x17c73c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x97c>
  17c50c:      	and	x12, x10, x9
  17c510:      	ldr	x11, [x15]
  17c514:      	ldr	x13, [x11, x12, lsl #3]
  17c518:      	cbz	x13, 0x17c5d8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x818>
  17c51c:      	ldr	x0, [x13]
  17c520:      	cbz	x0, 0x17c5d8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x818>
  17c524:      	ldr	x13, [x0, #0x8]
  17c528:      	cmp	x13, x9
  17c52c:      	b.ne	0x17d4cc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x170c>
  17c530:      	ldr	w13, [x0, #0x10]
  17c534:      	cmp	w13, w22
  17c538:      	b.eq	0x17c578 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x7b8>
  17c53c:      	ldr	x0, [x0]
  17c540:      	cbnz	x0, 0x17c524 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x764>
  17c544:      	b	0x17c5d8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x818>
  17c548:      	cbnz	w8, 0x17c338 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x578>
  17c54c:      	ldr	x8, [x19, #0x130]
  17c550:      	add	x9, x19, #0x138
  17c554:      	add	x9, x9, x8, lsl #3
  17c558:      	cmp	x21, x9
  17c55c:      	b.eq	0x17d2fc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x153c>
  17c560:      	add	x9, x20, x8, lsl #3
  17c564:      	cmp	x21, x9
  17c568:      	b.ne	0x17d500 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1740>
  17c56c:      	sub	x8, x8, #0x1
  17c570:      	str	x8, [x20]
  17c574:      	b	0x17c00c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x24c>
  17c578:      	tst	x8, x10
  17c57c:      	b.ne	0x17cbd0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xe10>
  17c580:      	and	x9, x10, x9
  17c584:      	ldr	x13, [x11, x9, lsl #3]
  17c588:      	mov	x12, x13
  17c58c:      	ldr	x13, [x13]
  17c590:      	cmp	x13, x0
  17c594:      	b.ne	0x17c588 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x7c8>
  17c598:      	add	x13, x19, #0x460
  17c59c:      	cmp	x12, x13
  17c5a0:      	b.ne	0x17cbe4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xe24>
  17c5a4:      	ldr	x13, [x0]
  17c5a8:      	cbnz	x13, 0x17cc44 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xe84>
  17c5ac:      	str	xzr, [x11, x9, lsl #3]
  17c5b0:      	ldr	x11, [x0]
  17c5b4:      	cbnz	x11, 0x17cc18 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xe58>
  17c5b8:      	str	x11, [x12]
  17c5bc:      	mov	w1, #0x18
  17c5c0:      	str	xzr, [x0]
  17c5c4:      	ldr	x8, [x19, #0x468]
  17c5c8:      	sub	x8, x8, #0x1
  17c5cc:      	str	x8, [x19, #0x468]
  17c5d0:      	bl	0x1e55a8 <_ZdlPvm@plt>
  17c5d4:      	ldr	w22, [sp, #0x2c]
  17c5d8:      	mov	w8, w22
  17c5dc:      	ldr	x20, [x19, #0x480]
  17c5e0:      	add	x23, x19, #0x478
  17c5e4:      	sxtw	x21, w8
  17c5e8:      	cbz	x20, 0x17ce40 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1080>
  17c5ec:      	sub	x8, x20, #0x1
  17c5f0:      	tst	x20, x8
  17c5f4:      	b.ne	0x17cb74 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xdb4>
  17c5f8:      	and	x28, x8, x21
  17c5fc:      	ldr	x9, [x23]
  17c600:      	ldr	x9, [x9, x28, lsl #3]
  17c604:      	cbnz	x9, 0x17d86c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1aac>
  17c608:      	mov	w0, #0x18
  17c60c:      	bl	0x1e5590 <_Znwm@plt>
  17c610:      	ucvtf	s2, x20
  17c614:      	ldr	x8, [x19, #0x490]
  17c618:      	ldr	s0, [x19, #0x498]
  17c61c:      	stp	xzr, x21, [x0]
  17c620:      	add	x8, x8, #0x1
  17c624:      	str	w22, [x0, #0x10]
  17c628:      	ucvtf	s1, x8
  17c62c:      	fmul	s2, s0, s2
  17c630:      	fcmp	s2, s1
  17c634:      	b.mi	0x17cc6c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xeac>
  17c638:      	ldr	x8, [x23]
  17c63c:      	ldr	x9, [x8, x28, lsl #3]
  17c640:      	cbnz	x9, 0x17d0f8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1338>
  17c644:      	add	x9, x19, #0x488
  17c648:      	ldr	x10, [x9]
  17c64c:      	str	x0, [x9]
  17c650:      	str	x10, [x0]
  17c654:      	str	x9, [x8, x28, lsl #3]
  17c658:      	ldr	x8, [x0]
  17c65c:      	cbnz	x8, 0x17cb8c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xdcc>
  17c660:      	ldr	x8, [x19, #0x490]
  17c664:      	ldrsw	x21, [sp, #0x2c]
  17c668:      	add	x8, x8, #0x1
  17c66c:      	str	x8, [x19, #0x490]
  17c670:      	mov	w8, #0x78
  17c674:      	ldr	x9, [x19, #0xd8]
  17c678:      	ldr	x22, [x19, #0x4a0]
  17c67c:      	nop
  17c680:      	smaddl	x8, w21, w8, x9
  17c684:      	add	x0, x19, #0x210
  17c688:      	ldrb	w8, [x8, #0x71]
  17c68c:      	str	w8, [sp, #0xc]
  17c690:      	bl	0x1e5b00 <pthread_mutex_unlock@plt>
  17c694:      	mov	w0, #0x1
  17c698:      	mov	w20, #0x1
  17c69c:      	bl	0x1e6220 <systemTime@plt>
  17c6a0:      	ldr	x8, [x19, #0xc0]
  17c6a4:      	ldr	w1, [sp, #0x2c]
  17c6a8:      	mov	x21, x0
  17c6ac:      	add	x2, sp, #0xc0
  17c6b0:      	add	x3, sp, #0x50
  17c6b4:      	ldr	x9, [x8]
  17c6b8:      	mov	x0, x8
  17c6bc:      	ldr	x9, [x9, #0x70]
  17c6c0:      	blr	x9
  17c6c4:      	str	w0, [sp, #0x10]
  17c6c8:      	add	x0, x19, #0x210
  17c6cc:      	bl	0x1e5ae8 <pthread_mutex_lock@plt>
  17c6d0:      	ldr	x28, [x19, #0x4a0]
  17c6d4:      	cmp	x28, x22
  17c6d8:      	b.ne	0x17c860 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xaa0>
  17c6dc:      	ldr	x8, [x19, #0x480]
  17c6e0:      	cbz	x8, 0x17c860 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xaa0>
  17c6e4:      	ldr	x9, [x19, #0x490]
  17c6e8:      	cbz	x9, 0x17c860 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xaa0>
  17c6ec:      	sub	x10, x8, #0x1
  17c6f0:      	ldrsw	x9, [sp, #0x2c]
  17c6f4:      	tst	x8, x10
  17c6f8:      	b.ne	0x17cbb8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xdf8>
  17c6fc:      	and	x12, x10, x9
  17c700:      	ldr	x11, [x23]
  17c704:      	ldr	x13, [x11, x12, lsl #3]
  17c708:      	cbz	x13, 0x17c758 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x998>
  17c70c:      	ldr	x13, [x13]
  17c710:      	cbz	x13, 0x17c758 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x998>
  17c714:      	ldr	x14, [x13, #0x8]
  17c718:      	cmp	x14, x9
  17c71c:      	b.ne	0x17d4e8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1728>
  17c720:      	ldr	w14, [x13, #0x10]
  17c724:      	cmp	w14, w9
  17c728:      	b.eq	0x17c754 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x994>
  17c72c:      	ldr	x13, [x13]
  17c730:      	cbnz	x13, 0x17c714 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x954>
  17c734:      	mov	w20, #0x1
  17c738:      	b	0x17c758 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x998>
  17c73c:      	cmp	x8, x9
  17c740:      	mov	x12, x9
  17c744:      	b.hi	0x17c510 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x750>
  17c748:      	udiv	x11, x9, x8
  17c74c:      	msub	x12, x11, x8, x9
  17c750:      	b	0x17c510 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x750>
  17c754:      	mov	w20, wzr
  17c758:      	tst	x8, x10
  17c75c:      	b.ne	0x17cb0c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xd4c>
  17c760:      	and	x12, x10, x9
  17c764:      	ldr	x13, [x11, x12, lsl #3]
  17c768:      	cbz	x13, 0x17c860 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xaa0>
  17c76c:      	ldr	x0, [x13]
  17c770:      	cbz	x0, 0x17c860 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xaa0>
  17c774:      	ldr	x13, [x0, #0x8]
  17c778:      	cmp	x13, x9
  17c77c:      	b.ne	0x17d510 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1750>
  17c780:      	ldr	w13, [x0, #0x10]
  17c784:      	cmp	w13, w9
  17c788:      	b.eq	0x17c804 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xa44>
  17c78c:      	ldr	x0, [x0]
  17c790:      	cbnz	x0, 0x17c774 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x9b4>
  17c794:      	b	0x17c860 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xaa0>
  17c798:      	add	x0, x19, #0x4d0
  17c79c:      	bl	0x1e5ea8 <_ZNSt3__15mutex4lockEv@plt>
  17c7a0:      	ldr	x3, [x19, #0x4f8]
  17c7a4:      	ldr	x4, [x19, #0x500]
  17c7a8:      	adrp	x1, 0x7a000
  17c7ac:      	add	x1, x1, #0x92e
  17c7b0:      	adrp	x2, 0x76000
  17c7b4:      	add	x2, x2, #0x60b
  17c7b8:      	mov	w0, #0x6
  17c7bc:      	bl	0x1e59f8 <__android_log_print@plt>
  17c7c0:      	add	x0, x19, #0x4d0
  17c7c4:      	bl	0x1e5ec0 <_ZNSt3__15mutex6unlockEv@plt>
  17c7c8:      	ldr	w8, [x19, #0x120]
  17c7cc:      	cbnz	w8, 0x17d284 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x14c4>
  17c7d0:      	ldr	x9, [x19, #0xf8]
  17c7d4:      	add	x1, x19, #0x100
  17c7d8:      	add	x10, x1, x9, lsl #3
  17c7dc:      	cmp	x1, x10
  17c7e0:      	b.ne	0x17d140 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1380>
  17c7e4:      	cbnz	w8, 0x17d564 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x17a4>
  17c7e8:      	add	x8, x22, x9, lsl #3
  17c7ec:      	add	x8, x8, #0x110
  17c7f0:      	cmp	x1, x8
  17c7f4:      	b.eq	0x17c044 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x284>
  17c7f8:      	add	x0, x19, #0xf0
  17c7fc:      	bl	0xf75e8 <_ZN7android7Surface12queueBuffersERKNSt3__16vectorINS0_17BatchQueuedBufferENS1_9allocatorIS3_EEEEPNS2_INS_24SurfaceQueueBufferOutputENS4_IS9_EEEE+0xa7c>
  17c800:      	b	0x17c044 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x284>
  17c804:      	tst	x8, x10
  17c808:      	b.ne	0x17cccc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xf0c>
  17c80c:      	and	x9, x10, x9
  17c810:      	ldr	x13, [x11, x9, lsl #3]
  17c814:      	mov	x12, x13
  17c818:      	ldr	x13, [x13]
  17c81c:      	cmp	x13, x0
  17c820:      	b.ne	0x17c814 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xa54>
  17c824:      	add	x13, x19, #0x488
  17c828:      	cmp	x12, x13
  17c82c:      	b.ne	0x17cce0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xf20>
  17c830:      	ldr	x13, [x0]
  17c834:      	cbnz	x13, 0x17cd2c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xf6c>
  17c838:      	str	xzr, [x11, x9, lsl #3]
  17c83c:      	ldr	x11, [x0]
  17c840:      	cbnz	x11, 0x17cd00 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xf40>
  17c844:      	str	x11, [x12]
  17c848:      	mov	w1, #0x18
  17c84c:      	str	xzr, [x0]
  17c850:      	ldr	x8, [x19, #0x490]
  17c854:      	sub	x8, x8, #0x1
  17c858:      	str	x8, [x19, #0x490]
  17c85c:      	bl	0x1e55a8 <_ZdlPvm@plt>
  17c860:      	ldrb	w8, [sp, #0x98]
  17c864:      	cbnz	w8, 0x17cc04 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xe44>
  17c868:      	mov	w0, #0x1
  17c86c:      	bl	0x1e6220 <systemTime@plt>
  17c870:      	sub	x8, x0, x21
  17c874:      	str	x8, [x19, #0x3b8]
  17c878:      	ldr	w8, [sp, #0x10]
  17c87c:      	cbnz	w8, 0x17d42c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x166c>
  17c880:      	ldrsw	x28, [sp, #0x2c]
  17c884:      	tbnz	w20, #0x0, 0x17c8a0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xae0>
  17c888:      	mov	w8, #0x78
  17c88c:      	ldr	x9, [x19, #0xd8]
  17c890:      	nop
  17c894:      	smaddl	x21, w28, w8, x9
  17c898:      	ldrb	w8, [x21, #0x70]
  17c89c:      	cbnz	w8, 0x17cb38 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xd78>
  17c8a0:      	ldrb	w8, [x19, #0x40a]
  17c8a4:      	cbz	w8, 0x17c948 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xb88>
  17c8a8:      	ldr	x0, [x19, #0x410]
  17c8ac:      	add	x8, sp, #0x50
  17c8b0:      	add	x1, x8, #0x18
  17c8b4:      	bl	0x1e6850 <_ZN7android25ProducerFrameEventHistory10applyDeltaERKNS_22FrameEventHistoryDeltaE@plt>
  17c8b8:      	ldr	x21, [x19, #0x410]
  17c8bc:      	ldr	x22, [x19, #0x3f8]
  17c8c0:      	mov	w0, #0x58
  17c8c4:      	bl	0x1e5590 <_Znwm@plt>
  17c8c8:      	adrp	x8, 0x212000 <_ZTTN7android3gui21BpWindowInfosListenerE+0x48>
  17c8cc:      	mov	x23, x0
  17c8d0:      	add	x20, x0, #0x18
  17c8d4:      	ldr	x8, [x8, #0x9f8]
  17c8d8:      	stp	xzr, xzr, [x0, #0x8]
  17c8dc:      	add	x1, sp, #0x18
  17c8e0:      	add	x8, x8, #0x10
  17c8e4:      	str	x8, [x0]
  17c8e8:      	add	x0, x0, #0x18
  17c8ec:      	bl	0x1e57d0 <_ZN7android9FenceTimeC1ERKNS_2spINS_5FenceEEE@plt>
  17c8f0:      	str	x20, [sp, #0x240]
  17c8f4:      	add	x2, sp, #0x240
  17c8f8:      	mov	x0, x21
  17c8fc:      	str	x23, [sp, #0x248]
  17c900:      	mov	x1, x22
  17c904:      	ldr	x8, [x21]
  17c908:      	ldr	x8, [x8, #0x10]
  17c90c:      	blr	x8
  17c910:      	ldr	x21, [sp, #0x248]
  17c914:      	cbz	x21, 0x17c940 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xb80>
  17c918:      	add	x1, x21, #0x8
  17c91c:      	mov	x0, #-0x1
  17c920:      	bl	0x173df0 <_ZN7android22IGraphicBufferProducer13detachBuffersERKNSt3__16vectorIiNS1_9allocatorIiEEEEPS5_+0x760>
  17c924:      	cbnz	x0, 0x17c940 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xb80>
  17c928:      	ldr	x8, [x21]
  17c92c:      	mov	x0, x21
  17c930:      	ldr	x8, [x8, #0x10]
  17c934:      	blr	x8
  17c938:      	mov	x0, x21
  17c93c:      	bl	0x1e5770 <_ZNSt3__119__shared_weak_count14__release_weakEv@plt>
  17c940:      	ldr	x0, [x19, #0x410]
  17c944:      	bl	0x1e6880 <_ZN7android25ProducerFrameEventHistory17updateSignalTimesEv@plt>
  17c948:      	ldr	x8, [x19, #0x3f8]
  17c94c:      	ldr	d0, [sp, #0x50]
  17c950:      	ldr	x9, [sp, #0x60]
  17c954:      	ldr	w10, [x19, #0x1f4]
  17c958:      	str	x8, [x19, #0x400]
  17c95c:      	str	d0, [x19, #0x1f8]
  17c960:      	str	x9, [x19, #0x3f8]
  17c964:      	cbnz	w10, 0x17c978 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xbb8>
  17c968:      	ldrb	w8, [x19, #0x1f0]
  17c96c:      	tbnz	w8, #0x3, 0x17c978 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xbb8>
  17c970:      	ldr	w8, [sp, #0x58]
  17c974:      	str	w8, [x19, #0x208]
  17c978:      	ldr	w8, [sp, #0x5c]
  17c97c:      	cmp	w8, #0x1
  17c980:      	ldrb	w8, [x19, #0x329]
  17c984:      	cset	w9, hi
  17c988:      	strb	w9, [x19, #0x20e]
  17c98c:      	tbnz	w8, #0x0, 0x17c9a0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xbe0>
  17c990:      	adrp	x1, 0x212000 <_ZTTN7android3gui21BpWindowInfosListenerE+0x48>
  17c994:      	add	x0, x19, #0x330
  17c998:      	ldr	x1, [x1, #0xa40]
  17c99c:      	bl	0x1e5c80 <_ZN7android6RegionaSERKS0_@plt>
  17c9a0:      	ldrb	w8, [x19, #0x3a5]
  17c9a4:      	cbz	w8, 0x17c9bc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xbfc>
  17c9a8:      	ldrb	w8, [x19, #0x3a6]
  17c9ac:      	cbz	w8, 0x17c9bc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xbfc>
  17c9b0:      	ldr	w8, [x19, #0x3a8]
  17c9b4:      	cmp	w8, w28
  17c9b8:      	b.eq	0x17cd94 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xfd4>
  17c9bc:      	add	x0, x19, #0x3c8
  17c9c0:      	bl	0x1e74e0 <pthread_cond_broadcast@plt>
  17c9c4:      	bl	0x1e5e60 <atrace_get_enabled_tags@plt>
  17c9c8:      	tbnz	w0, #0x1, 0x17cfbc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x11fc>
  17c9cc:      	ldr	w22, [sp, #0x10]
  17c9d0:      	add	x0, x19, #0x210
  17c9d4:      	bl	0x1e5b00 <pthread_mutex_unlock@plt>
  17c9d8:      	ldr	x0, [sp, #0x1a0]
  17c9dc:      	cbnz	x0, 0x17d314 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1554>
  17c9e0:      	add	x0, x25, #0x38
  17c9e4:      	bl	0x1e5620 <_ZN7android6RegionD1Ev@plt>
  17c9e8:      	ldr	x19, [sp, #0xf0]
  17c9ec:      	cbz	x19, 0x17ca04 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xc44>
  17c9f0:      	add	x1, x19, #0x8
  17c9f4:      	mov	w0, #-0x1
  17c9f8:      	bl	0x173420 <_ZN7android13layer_state_t4readERKNS_6ParcelE+0x4358>
  17c9fc:      	cmp	w0, #0x1
  17ca00:      	b.eq	0x17cf5c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x119c>
  17ca04:      	ldr	x20, [sp, #0x68]
  17ca08:      	cbz	x20, 0x17caa4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xce4>
  17ca0c:      	ldr	x21, [sp, #0x70]
  17ca10:      	mov	x0, x20
  17ca14:      	cmp	x20, x21
  17ca18:      	b.eq	0x17ca94 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xcd4>
  17ca1c:      	ldur	x19, [x21, #-0x10]
  17ca20:      	cbz	x19, 0x17ca38 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xc78>
  17ca24:      	add	x1, x19, #0x8
  17ca28:      	mov	w0, #-0x1
  17ca2c:      	bl	0x173420 <_ZN7android13layer_state_t4readERKNS_6ParcelE+0x4358>
  17ca30:      	cmp	w0, #0x1
  17ca34:      	b.eq	0x17d1f4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1434>
  17ca38:      	ldur	x19, [x21, #-0x28]
  17ca3c:      	cbz	x19, 0x17ca68 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xca8>
  17ca40:      	add	x1, x19, #0x8
  17ca44:      	mov	w0, #-0x1
  17ca48:      	bl	0x173420 <_ZN7android13layer_state_t4readERKNS_6ParcelE+0x4358>
  17ca4c:      	cmp	w0, #0x1
  17ca50:      	b.ne	0x17ca68 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xca8>
  17ca54:      	dmb	ishld
  17ca58:      	mov	x0, x19
  17ca5c:      	ldr	x8, [x19]
  17ca60:      	ldr	x8, [x8, #0x18]
  17ca64:      	blr	x8
  17ca68:      	ldur	x19, [x21, #-0x40]
  17ca6c:      	cbz	x19, 0x17ca84 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xcc4>
  17ca70:      	add	x1, x19, #0x8
  17ca74:      	mov	w0, #-0x1
  17ca78:      	bl	0x173420 <_ZN7android13layer_state_t4readERKNS_6ParcelE+0x4358>
  17ca7c:      	cmp	w0, #0x1
  17ca80:      	b.eq	0x17d20c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x144c>
  17ca84:      	sub	x21, x21, #0x90
  17ca88:      	cmp	x21, x20
  17ca8c:      	b.ne	0x17ca1c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xc5c>
  17ca90:      	ldr	x0, [sp, #0x68]
  17ca94:      	ldr	x8, [sp, #0x78]
  17ca98:      	str	x20, [sp, #0x70]
  17ca9c:      	sub	x1, x8, x0
  17caa0:      	bl	0x1e55a8 <_ZdlPvm@plt>
  17caa4:      	bl	0x1e5e60 <atrace_get_enabled_tags@plt>
  17caa8:      	tbz	w0, #0x1, 0x17cab0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xcf0>
  17caac:      	bl	0x1e5e48 <atrace_end_body@plt>
  17cab0:      	ldr	x19, [sp, #0x18]
  17cab4:      	cbz	x19, 0x17cacc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xd0c>
  17cab8:      	add	x1, x19, #0x8
  17cabc:      	mov	w0, #-0x1
  17cac0:      	bl	0x173420 <_ZN7android13layer_state_t4readERKNS_6ParcelE+0x4358>
  17cac4:      	cmp	w0, #0x1
  17cac8:      	b.eq	0x17caf4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xd34>
  17cacc:      	ldr	x0, [sp, #0x20]
  17cad0:      	cbz	x0, 0x17cadc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xd1c>
  17cad4:      	add	x1, sp, #0x20
  17cad8:      	bl	0x1e5560 <_ZNK7android7RefBase9decStrongEPKv@plt>
  17cadc:      	ldr	x8, [x24, #0x28]
  17cae0:      	ldur	x9, [x29, #-0x18]
  17cae4:      	cmp	x8, x9
  17cae8:      	b.ne	0x17be50 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x90>
  17caec:      	mov	w0, w22
  17caf0:      	b	0x17be58 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x98>
  17caf4:      	dmb	ishld
  17caf8:      	mov	x0, x19
  17cafc:      	ldr	x8, [x19]
  17cb00:      	ldr	x8, [x8, #0x18]
  17cb04:      	blr	x8
  17cb08:      	b	0x17cacc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xd0c>
  17cb0c:      	cmp	x8, x9
  17cb10:      	mov	x12, x9
  17cb14:      	b.hi	0x17c764 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x9a4>
  17cb18:      	udiv	x12, x9, x8
  17cb1c:      	msub	x12, x12, x8, x9
  17cb20:      	b	0x17c764 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x9a4>
  17cb24:      	adrp	x1, 0x212000 <_ZTTN7android3gui21BpWindowInfosListenerE+0x48>
  17cb28:      	add	x0, x28, #0x38
  17cb2c:      	ldr	x1, [x1, #0xa40]
  17cb30:      	bl	0x1e5c80 <_ZN7android6RegionaSERKS0_@plt>
  17cb34:      	b	0x17c350 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x590>
  17cb38:      	ldr	x22, [x21]
  17cb3c:      	cbz	x22, 0x17cb4c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xd8c>
  17cb40:      	mov	x0, x22
  17cb44:      	mov	x1, x21
  17cb48:      	bl	0x1e5560 <_ZNK7android7RefBase9decStrongEPKv@plt>
  17cb4c:      	ldr	x8, [x21]
  17cb50:      	cmp	x22, x8
  17cb54:      	b.ne	0x17cd4c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xf8c>
  17cb58:      	str	xzr, [x21]
  17cb5c:      	mov	w8, #0x78
  17cb60:      	ldr	x9, [x19, #0xd8]
  17cb64:      	nop
  17cb68:      	smaddl	x8, w28, w8, x9
  17cb6c:      	strb	wzr, [x8, #0x70]
  17cb70:      	b	0x17c8a0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xae0>
  17cb74:      	cmp	x20, x21
  17cb78:      	mov	x28, x21
  17cb7c:      	b.hi	0x17c5fc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x83c>
  17cb80:      	udiv	x9, x21, x20
  17cb84:      	msub	x28, x9, x20, x21
  17cb88:      	b	0x17c5fc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x83c>
  17cb8c:      	sub	x9, x20, #0x1
  17cb90:      	ldr	x8, [x8, #0x8]
  17cb94:      	tst	x20, x9
  17cb98:      	b.eq	0x17ce70 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x10b0>
  17cb9c:      	cmp	x8, x20
  17cba0:      	b.hs	0x17d0e4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1324>
  17cba4:      	ldr	x9, [x23]
  17cba8:      	str	x0, [x9, x8, lsl #3]
  17cbac:      	b	0x17c660 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x8a0>
  17cbb0:      	mov	w22, wzr
  17cbb4:      	b	0x17c9d0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xc10>
  17cbb8:      	cmp	x8, x9
  17cbbc:      	mov	x12, x9
  17cbc0:      	b.hi	0x17c700 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x940>
  17cbc4:      	udiv	x11, x9, x8
  17cbc8:      	msub	x12, x11, x8, x9
  17cbcc:      	b	0x17c700 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x940>
  17cbd0:      	cmp	x8, x9
  17cbd4:      	b.hi	0x17c584 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x7c4>
  17cbd8:      	udiv	x12, x9, x8
  17cbdc:      	msub	x9, x12, x8, x9
  17cbe0:      	b	0x17c584 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x7c4>
  17cbe4:      	ldr	x13, [x12, #0x8]
  17cbe8:      	tst	x8, x10
  17cbec:      	b.eq	0x17cf74 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x11b4>
  17cbf0:      	cmp	x13, x8
  17cbf4:      	b.hs	0x17d134 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1374>
  17cbf8:      	cmp	x13, x9
  17cbfc:      	b.ne	0x17c5a4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x7e4>
  17cc00:      	b	0x17c5b0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x7f0>
  17cc04:      	ldr	x8, [sp, #0xa0]
  17cc08:      	mov	w9, #0x1
  17cc0c:      	strb	w9, [x19, #0x510]
  17cc10:      	str	x8, [x19, #0x508]
  17cc14:      	b	0x17c868 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xaa8>
  17cc18:      	ldr	x13, [x11, #0x8]
  17cc1c:      	tst	x8, x10
  17cc20:      	b.eq	0x17d298 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x14d8>
  17cc24:      	cmp	x13, x8
  17cc28:      	b.hs	0x17d11c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x135c>
  17cc2c:      	cmp	x13, x9
  17cc30:      	b.eq	0x17c5b8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x7f8>
  17cc34:      	ldr	x8, [x15]
  17cc38:      	str	x12, [x8, x13, lsl #3]
  17cc3c:      	ldr	x11, [x0]
  17cc40:      	b	0x17c5b8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x7f8>
  17cc44:      	ldr	x13, [x13, #0x8]
  17cc48:      	tst	x8, x10
  17cc4c:      	b.eq	0x17d2a0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x14e0>
  17cc50:      	cmp	x13, x8
  17cc54:      	b.hs	0x17d128 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1368>
  17cc58:      	cmp	x13, x9
  17cc5c:      	b.ne	0x17c5ac <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x7ec>
  17cc60:      	b	0x17c5b0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x7f0>
  17cc64:      	mov	w22, #-0x16
  17cc68:      	b	0x17caa4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xce4>
  17cc6c:      	lsl	x8, x20, #1
  17cc70:      	cmp	x20, #0x3
  17cc74:      	b.hs	0x17cf7c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x11bc>
  17cc78:      	mov	w9, #0x1
  17cc7c:      	fdiv	s0, s1, s0
  17cc80:      	orr	x8, x9, x8
  17cc84:      	mov	x22, x0
  17cc88:      	fcvtpu	x10, s0
  17cc8c:      	cmp	x8, x10
  17cc90:      	csel	x1, x8, x10, hi
  17cc94:      	subs	x8, x1, #0x1
  17cc98:      	b.ne	0x17cea8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x10e8>
  17cc9c:      	mov	w1, #0x2
  17cca0:      	cmp	x1, x20
  17cca4:      	b.ls	0x17d16c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x13ac>
  17cca8:      	add	x0, x19, #0x478
  17ccac:      	bl	0x1413d0 <_ZN7android7Surface12attachBufferERKNS_2spINS_13GraphicBufferEEE+0x604>
  17ccb0:      	ldr	x20, [x19, #0x480]
  17ccb4:      	mov	x0, x22
  17ccb8:      	sub	x8, x20, #0x1
  17ccbc:      	tst	x20, x8
  17ccc0:      	b.ne	0x17ce60 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x10a0>
  17ccc4:      	and	x28, x8, x21
  17ccc8:      	b	0x17c638 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x878>
  17cccc:      	cmp	x8, x9
  17ccd0:      	b.hi	0x17c810 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xa50>
  17ccd4:      	udiv	x12, x9, x8
  17ccd8:      	msub	x9, x12, x8, x9
  17ccdc:      	b	0x17c810 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xa50>
  17cce0:      	ldr	x13, [x12, #0x8]
  17cce4:      	tst	x8, x10
  17cce8:      	b.eq	0x17d114 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1354>
  17ccec:      	cmp	x13, x8
  17ccf0:      	b.hs	0x17d1d4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1414>
  17ccf4:      	cmp	x13, x9
  17ccf8:      	b.ne	0x17c830 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xa70>
  17ccfc:      	b	0x17c83c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xa7c>
  17cd00:      	ldr	x13, [x11, #0x8]
  17cd04:      	tst	x8, x10
  17cd08:      	b.eq	0x17d2a8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x14e8>
  17cd0c:      	cmp	x13, x8
  17cd10:      	b.hs	0x17d1bc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x13fc>
  17cd14:      	cmp	x13, x9
  17cd18:      	b.eq	0x17c844 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xa84>
  17cd1c:      	ldr	x8, [x23]
  17cd20:      	str	x12, [x8, x13, lsl #3]
  17cd24:      	ldr	x11, [x0]
  17cd28:      	b	0x17c844 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xa84>
  17cd2c:      	ldr	x13, [x13, #0x8]
  17cd30:      	tst	x8, x10
  17cd34:      	b.eq	0x17d2b0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x14f0>
  17cd38:      	cmp	x13, x8
  17cd3c:      	b.hs	0x17d1c8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1408>
  17cd40:      	cmp	x13, x9
  17cd44:      	b.ne	0x17c838 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xa78>
  17cd48:      	b	0x17c83c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xa7c>
  17cd4c:      	bl	0x1e57b8 <_ZN7android14sp_report_raceEv@plt>
  17cd50:      	b	0x17cb58 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xd98>
  17cd54:      	add	x0, x19, #0x4d0
  17cd58:      	bl	0x1e5ea8 <_ZNSt3__15mutex4lockEv@plt>
  17cd5c:      	ldr	x3, [x19, #0x4f8]
  17cd60:      	ldr	x4, [x19, #0x500]
  17cd64:      	adrp	x1, 0x7a000
  17cd68:      	add	x1, x1, #0x92e
  17cd6c:      	adrp	x2, 0x72000
  17cd70:      	add	x2, x2, #0xd30
  17cd74:      	adrp	x5, 0x70000
  17cd78:      	add	x5, x5, #0x958
  17cd7c:      	mov	w0, #0x6
  17cd80:      	bl	0x1e59f8 <__android_log_print@plt>
  17cd84:      	add	x0, x19, #0x4d0
  17cd88:      	bl	0x1e5ec0 <_ZNSt3__15mutex6unlockEv@plt>
  17cd8c:      	mov	w22, #-0x16
  17cd90:      	b	0x17c9d0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xc10>
  17cd94:      	mov	w8, #0x1
  17cd98:      	strb	w8, [x19, #0x3ac]
  17cd9c:      	b	0x17c9bc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xbfc>
  17cda0:      	mov	x21, x1
  17cda4:      	cbz	x22, 0x17cdc4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1004>
  17cda8:      	mov	x0, x22
  17cdac:      	mov	x1, x8
  17cdb0:      	str	x22, [sp, #0x1a8]
  17cdb4:      	bl	0x1e55a8 <_ZdlPvm@plt>
  17cdb8:      	mov	x9, xzr
  17cdbc:      	stp	xzr, xzr, [x25, #0xe0]
  17cdc0:      	stur	xzr, [x25, #0xf0]
  17cdc4:      	tbnz	x20, #0x3f, 0x17d5dc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x181c>
  17cdc8:      	lsl	x8, x9, #1
  17cdcc:      	mov	x10, #0x3fffffffffffffff
  17cdd0:      	cmp	x8, x20
  17cdd4:      	csel	x8, x8, x20, hi
  17cdd8:      	cmp	x9, x10
  17cddc:      	mov	x9, #0x7fffffffffffffff
  17cde0:      	csel	x22, x8, x9, lo
  17cde4:      	mov	x0, x22
  17cde8:      	bl	0x1e5590 <_Znwm@plt>
  17cdec:      	add	x8, x0, x22
  17cdf0:      	mov	x1, x21
  17cdf4:      	mov	x2, x20
  17cdf8:      	mov	x23, x0
  17cdfc:      	stp	x0, x0, [sp, #0x1a0]
  17ce00:      	str	x8, [sp, #0x1b0]
  17ce04:      	bl	0x1eb0f8 <memcpy@plt>
  17ce08:      	add	x8, x23, x20
  17ce0c:      	b	0x17c408 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x648>
  17ce10:      	tbnz	x21, #0x3f, 0x17d5dc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x181c>
  17ce14:      	mov	x0, x21
  17ce18:      	bl	0x1e5590 <_Znwm@plt>
  17ce1c:      	add	x22, x0, x21
  17ce20:      	mov	x1, x20
  17ce24:      	mov	x2, x21
  17ce28:      	str	x0, [sp, #0x320]
  17ce2c:      	str	x0, [sp, #0x328]
  17ce30:      	str	x22, [sp, #0x330]
  17ce34:      	bl	0x1eb0f8 <memcpy@plt>
  17ce38:      	str	x22, [sp, #0x328]
  17ce3c:      	b	0x17c248 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x488>
  17ce40:      	mov	x28, xzr
  17ce44:      	b	0x17c608 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x848>
  17ce48:      	mov	w0, #0x10
  17ce4c:      	bl	0x1e5590 <_Znwm@plt>
  17ce50:      	mov	x20, x0
  17ce54:      	bl	0x1e74c8 <_ZN7android19GraphicBufferMapperC1Ev@plt>
  17ce58:      	str	x20, [x21]
  17ce5c:      	b	0x17c46c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x6ac>
  17ce60:      	cmp	x20, x21
  17ce64:      	b.ls	0x17d108 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1348>
  17ce68:      	mov	x28, x21
  17ce6c:      	b	0x17c638 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x878>
  17ce70:      	and	x8, x8, x9
  17ce74:      	b	0x17cba4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xde4>
  17ce78:      	ldr	w8, [sp, #0x168]
  17ce7c:      	ldr	x9, [sp, #0x20]
  17ce80:      	mov	x0, x20
  17ce84:      	ldur	x11, [x26, #0xd4]
  17ce88:      	and	x10, x8, #0x2
  17ce8c:      	ldr	x1, [x9, #0x70]
  17ce90:      	ubfx	x3, x8, #1, #1
  17ce94:      	cmp	w10, #0x0
  17ce98:      	csel	x2, xzr, x11, eq
  17ce9c:      	bl	0x1e7288 <_ZN7android19GraphicBufferMapper11setCta861_3EPK13native_handleNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEE@plt>
  17cea0:      	ldr	w8, [x19, #0x1d8]
  17cea4:      	b	0x17c498 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x6d8>
  17cea8:      	tst	x1, x8
  17ceac:      	b.eq	0x17cca0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xee0>
  17ceb0:      	mov	x0, x1
  17ceb4:      	bl	0x1e7600 <_ZNSt3__112__next_primeEm@plt>
  17ceb8:      	ldr	x20, [x19, #0x480]
  17cebc:      	mov	x1, x0
  17cec0:      	b	0x17cca0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xee0>
  17cec4:      	add	x1, x20, #0x8
  17cec8:      	mov	w0, #-0x1
  17cecc:      	bl	0x173420 <_ZN7android13layer_state_t4readERKNS_6ParcelE+0x4358>
  17ced0:      	cmp	w0, #0x1
  17ced4:      	b.ne	0x17c384 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x5c4>
  17ced8:      	dmb	ishld
  17cedc:      	mov	x0, x20
  17cee0:      	ldr	x8, [x20]
  17cee4:      	ldr	x8, [x8, #0x18]
  17cee8:      	blr	x8
  17ceec:      	b	0x17c384 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x5c4>
  17cef0:      	ldr	x13, [sp, #0x20]
  17cef4:      	sub	x14, x12, x9
  17cef8:      	add	x14, x9, x14
  17cefc:      	ldr	x15, [x9]
  17cf00:      	cmp	x15, x13
  17cf04:      	b.eq	0x17c02c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x26c>
  17cf08:      	add	x9, x9, #0x8
  17cf0c:      	cmp	x9, x12
  17cf10:      	b.ne	0x17cefc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x113c>
  17cf14:      	mov	x9, x14
  17cf18:      	b	0x17c02c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x26c>
  17cf1c:      	ldr	x8, [sp, #0x20]
  17cf20:      	ldrb	w9, [sp, #0x168]
  17cf24:      	ldr	x1, [x8, #0x70]
  17cf28:      	tbz	w9, #0x0, 0x17d5e0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1820>
  17cf2c:      	ldur	q0, [x26, #0xac]
  17cf30:      	ldur	q1, [x26, #0xbc]
  17cf34:      	mov	w8, #0x1
  17cf38:      	ldur	d2, [x26, #0xcc]
  17cf3c:      	stp	q0, q1, [x27]
  17cf40:      	str	d2, [sp, #0x260]
  17cf44:      	add	x2, sp, #0x240
  17cf48:      	mov	x0, x20
  17cf4c:      	strb	w8, [sp, #0x268]
  17cf50:      	bl	0x1e7270 <_ZN7android19GraphicBufferMapper12setSmpte2086EPK13native_handleNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEE@plt>
  17cf54:      	ldr	w8, [x19, #0x1d8]
  17cf58:      	b	0x17c494 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x6d4>
  17cf5c:      	dmb	ishld
  17cf60:      	mov	x0, x19
  17cf64:      	ldr	x8, [x19]
  17cf68:      	ldr	x8, [x8, #0x18]
  17cf6c:      	blr	x8
  17cf70:      	b	0x17ca04 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xc44>
  17cf74:      	and	x13, x13, x10
  17cf78:      	b	0x17cbf8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xe38>
  17cf7c:      	sub	x9, x20, #0x1
  17cf80:      	tst	x20, x9
  17cf84:      	cset	w9, ne
  17cf88:      	b	0x17cc7c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xebc>
  17cf8c:      	dmb	ishld
  17cf90:      	mov	x0, x20
  17cf94:      	ldr	x8, [x20]
  17cf98:      	ldr	x8, [x8, #0x18]
  17cf9c:      	blr	x8
  17cfa0:      	b	0x17c448 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x688>
  17cfa4:      	adrp	x0, 0x6a000
  17cfa8:      	add	x0, x0, #0xa5e
  17cfac:      	bl	0x1e5e30 <atrace_begin_body@plt>
  17cfb0:      	b	0x17c450 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x690>
  17cfb4:      	bl	0x1e5e48 <atrace_end_body@plt>
  17cfb8:      	b	0x17c4e0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x720>
  17cfbc:      	nop
  17cfc0:      	adr	x8, #0x9b640
  17cfc4:      	ldarb	w8, [x8]
  17cfc8:      	tbz	w8, #0x0, 0x17d328 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1568>
  17cfcc:      	movi	v0.2d, #0000000000000000
  17cfd0:      	nop
  17cfd4:      	adr	x20, #0x9b594
  17cfd8:      	add	x0, x20, #0x70
  17cfdc:      	stp	q0, q0, [x27]
  17cfe0:      	stp	q0, q0, [x27, #0x20]
  17cfe4:      	bl	0x1e5ea8 <_ZNSt3__15mutex4lockEv@plt>
  17cfe8:      	ldr	x0, [sp, #0x18]
  17cfec:      	ldr	x8, [x0]
  17cff0:      	ldr	x8, [x8]
  17cff4:      	blr	x8
  17cff8:      	mov	x8, #0x7fffffffffffffff
  17cffc:      	ldr	x4, [x20]
  17d000:      	ldr	w5, [x20, #0x8]
  17d004:      	cmp	x0, x8
  17d008:      	b.ne	0x17d254 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1494>
  17d00c:      	adrp	x3, 0x6a000
  17d010:      	add	x3, x3, #0x99d
  17d014:      	add	x0, sp, #0x240
  17d018:      	bl	0xc0a78 <_ZN7android3guilsERNSt3__113basic_ostreamIcNS1_11char_traitsIcEEEERKNS0_10WindowInfoE+0x3ecc>
  17d01c:      	bl	0x1e5e60 <atrace_get_enabled_tags@plt>
  17d020:      	tbnz	w0, #0x1, 0x17d2c0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1500>
  17d024:      	adrp	x23, 0x218000 <_ZN7android22IGraphicBufferProducer10descriptorE>
  17d028:      	add	x23, x23, #0x580
  17d02c:      	ldp	x9, x8, [x23]
  17d030:      	subs	x10, x8, x9
  17d034:      	lsl	x11, x10, #3
  17d038:      	ldp	x10, x12, [x23, #0x18]
  17d03c:      	subs	x22, x8, x9
  17d040:      	sub	x11, x11, #0x1
  17d044:      	csel	x11, xzr, x11, eq
  17d048:      	add	x12, x12, x10
  17d04c:      	cmp	x11, x12
  17d050:      	b.eq	0x17d224 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1464>
  17d054:      	ldp	x8, x9, [x23]
  17d058:      	cmp	x8, x9
  17d05c:      	b.eq	0x17d2dc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x151c>
  17d060:      	adrp	x9, 0x218000 <_ZN7android22IGraphicBufferProducer10descriptorE>
  17d064:      	add	x9, x9, #0x598
  17d068:      	ldp	x9, x10, [x9]
  17d06c:      	add	x9, x9, x10
  17d070:      	lsr	x10, x9, #6
  17d074:      	and	x9, x9, #0x3f
  17d078:      	ldr	x8, [x8, x10, lsl #3]
  17d07c:      	add	x21, x8, x9, lsl #6
  17d080:      	ldr	x8, [sp, #0x18]
  17d084:      	str	x8, [x21]
  17d088:      	cbz	x8, 0x17d098 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x12d8>
  17d08c:      	add	x1, x8, #0x8
  17d090:      	mov	w0, #0x1
  17d094:      	bl	0x173080 <_ZN7android13layer_state_t4readERKNS_6ParcelE+0x3fb8>
  17d098:      	str	xzr, [x21, #0x30]
  17d09c:      	add	x0, x20, #0x40
  17d0a0:      	ldr	x8, [x20, #0x38]
  17d0a4:      	add	x8, x8, #0x1
  17d0a8:      	str	x8, [x20, #0x38]
  17d0ac:      	bl	0x1e6778 <_ZNSt3__118condition_variable10notify_oneEv@plt>
  17d0b0:      	ldr	w8, [x20, #0x8]
  17d0b4:      	ldr	x21, [x20]
  17d0b8:      	ldr	x22, [x20, #0x38]
  17d0bc:      	add	w8, w8, #0x1
  17d0c0:      	str	w8, [x20, #0x8]
  17d0c4:      	bl	0x1e5e60 <atrace_get_enabled_tags@plt>
  17d0c8:      	tbnz	w0, #0x1, 0x17d2cc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x150c>
  17d0cc:      	bl	0x1e5e60 <atrace_get_enabled_tags@plt>
  17d0d0:      	tbnz	w0, #0x1, 0x17d2b8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x14f8>
  17d0d4:      	adrp	x0, 0x218000 <_ZN7android22IGraphicBufferProducer10descriptorE>
  17d0d8:      	add	x0, x0, #0x5d8
  17d0dc:      	bl	0x1e5ec0 <_ZNSt3__15mutex6unlockEv@plt>
  17d0e0:      	b	0x17c9cc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xc0c>
  17d0e4:      	udiv	x9, x8, x20
  17d0e8:      	msub	x8, x9, x20, x8
  17d0ec:      	b	0x17cba4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xde4>
  17d0f0:      	bl	0x1e57b8 <_ZN7android14sp_report_raceEv@plt>
  17d0f4:      	b	0x17c390 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x5d0>
  17d0f8:      	ldr	x8, [x9]
  17d0fc:      	str	x8, [x0]
  17d100:      	str	x0, [x9]
  17d104:      	b	0x17c660 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x8a0>
  17d108:      	udiv	x8, x21, x20
  17d10c:      	msub	x28, x8, x20, x21
  17d110:      	b	0x17c638 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x878>
  17d114:      	and	x13, x13, x10
  17d118:      	b	0x17ccf4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xf34>
  17d11c:      	udiv	x10, x13, x8
  17d120:      	msub	x13, x10, x8, x13
  17d124:      	b	0x17cc2c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xe6c>
  17d128:      	udiv	x14, x13, x8
  17d12c:      	msub	x13, x14, x8, x13
  17d130:      	b	0x17cc58 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xe98>
  17d134:      	udiv	x14, x13, x8
  17d138:      	msub	x13, x14, x8, x13
  17d13c:      	b	0x17cbf8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xe38>
  17d140:      	sub	x11, x10, x1
  17d144:      	ldr	x12, [sp, #0x20]
  17d148:      	add	x11, x1, x11
  17d14c:      	ldr	x13, [x1]
  17d150:      	cmp	x13, x12
  17d154:      	b.eq	0x17c7e4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xa24>
  17d158:      	add	x1, x1, #0x8
  17d15c:      	cmp	x1, x10
  17d160:      	b.ne	0x17d14c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x138c>
  17d164:      	mov	x1, x11
  17d168:      	b	0x17c7e4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xa24>
  17d16c:      	b.hs	0x17ccb0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xef0>
  17d170:      	ldr	x8, [x19, #0x490]
  17d174:      	ldr	s1, [x19, #0x498]
  17d178:      	mov	x28, x1
  17d17c:      	cmp	x20, #0x3
  17d180:      	ucvtf	s0, x8
  17d184:      	fdiv	s0, s0, s1
  17d188:      	fcvtpu	x0, s0
  17d18c:      	b.lo	0x17d670 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x18b0>
  17d190:      	sub	x8, x20, #0x1
  17d194:      	and	x8, x20, x8
  17d198:      	cbnz	x8, 0x17d670 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x18b0>
  17d19c:      	sub	x8, x0, #0x1
  17d1a0:      	mov	w9, #0x1
  17d1a4:      	cmp	x0, #0x2
  17d1a8:      	clz	x8, x8
  17d1ac:      	neg	x8, x8
  17d1b0:      	lsl	x8, x9, x8
  17d1b4:      	csel	x0, x0, x8, lo
  17d1b8:      	b	0x17d674 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x18b4>
  17d1bc:      	udiv	x10, x13, x8
  17d1c0:      	msub	x13, x10, x8, x13
  17d1c4:      	b	0x17cd14 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xf54>
  17d1c8:      	udiv	x14, x13, x8
  17d1cc:      	msub	x13, x14, x8, x13
  17d1d0:      	b	0x17cd40 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xf80>
  17d1d4:      	udiv	x14, x13, x8
  17d1d8:      	msub	x13, x14, x8, x13
  17d1dc:      	b	0x17ccf4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xf34>
  17d1e0:      	cmp	w10, #0x1
  17d1e4:      	b.ne	0x17c338 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x578>
  17d1e8:      	ldp	x9, x12, [x19, #0xf8]
  17d1ec:      	mov	x11, x9
  17d1f0:      	b	0x17c024 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x264>
  17d1f4:      	dmb	ishld
  17d1f8:      	mov	x0, x19
  17d1fc:      	ldr	x8, [x19]
  17d200:      	ldr	x8, [x8, #0x18]
  17d204:      	blr	x8
  17d208:      	b	0x17ca38 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xc78>
  17d20c:      	dmb	ishld
  17d210:      	mov	x0, x19
  17d214:      	ldr	x8, [x19]
  17d218:      	ldr	x8, [x8, #0x18]
  17d21c:      	blr	x8
  17d220:      	b	0x17ca84 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xcc4>
  17d224:      	subs	x10, x10, #0x40
  17d228:      	adrp	x21, 0x218000 <_ZN7android22IGraphicBufferProducer10descriptorE>
  17d22c:      	add	x21, x21, #0x578
  17d230:      	b.lo	0x17d688 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x18c8>
  17d234:      	str	x10, [x21, #0x20]
  17d238:      	ldr	x8, [x9], #0x8
  17d23c:      	str	x9, [x21, #0x8]
  17d240:      	str	x8, [sp, #0x1d0]
  17d244:      	add	x1, sp, #0x1d0
  17d248:      	mov	x0, x21
  17d24c:      	bl	0x10fce4 <_ZN7android8hardware8graphics11bufferqueue4V1_05utils24H2BGraphicBufferProducer14setAutoRefreshEb+0x14b4>
  17d250:      	b	0x17d054 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1294>
  17d254:      	adrp	x3, 0x6a000
  17d258:      	add	x3, x3, #0x984
  17d25c:      	add	x0, sp, #0x240
  17d260:      	bl	0xc0a78 <_ZN7android3guilsERNSt3__113basic_ostreamIcNS1_11char_traitsIcEEEERKNS0_10WindowInfoE+0x3ecc>
  17d264:      	bl	0x1e5e60 <atrace_get_enabled_tags@plt>
  17d268:      	tbnz	w0, #0x1, 0x17d2e4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1524>
  17d26c:      	movi	v0.2s, #0x1
  17d270:      	adrp	x8, 0x218000 <_ZN7android22IGraphicBufferProducer10descriptorE>
  17d274:      	ldr	d1, [x8, #0x570]
  17d278:      	add	v0.2s, v1.2s, v0.2s
  17d27c:      	str	d0, [x8, #0x570]
  17d280:      	b	0x17d0cc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x130c>
  17d284:      	cmp	w8, #0x1
  17d288:      	b.ne	0x17c338 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x578>
  17d28c:      	ldp	x1, x10, [x19, #0xf8]
  17d290:      	mov	x9, x1
  17d294:      	b	0x17c7dc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xa1c>
  17d298:      	and	x13, x13, x10
  17d29c:      	b	0x17cc2c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xe6c>
  17d2a0:      	and	x13, x13, x10
  17d2a4:      	b	0x17cc58 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xe98>
  17d2a8:      	and	x13, x13, x10
  17d2ac:      	b	0x17cd14 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xf54>
  17d2b0:      	and	x13, x13, x10
  17d2b4:      	b	0x17cd40 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xf80>
  17d2b8:      	bl	0x1e5e48 <atrace_end_body@plt>
  17d2bc:      	b	0x17d0d4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1314>
  17d2c0:      	add	x0, sp, #0x240
  17d2c4:      	bl	0x1e5e30 <atrace_begin_body@plt>
  17d2c8:      	b	0x17d024 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1264>
  17d2cc:      	mov	x0, x21
  17d2d0:      	mov	w1, w22
  17d2d4:      	bl	0x1e5e78 <atrace_int_body@plt>
  17d2d8:      	b	0x17d0cc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x130c>
  17d2dc:      	mov	x21, xzr
  17d2e0:      	b	0x17d080 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x12c0>
  17d2e4:      	add	x0, sp, #0x240
  17d2e8:      	bl	0x1e5e30 <atrace_begin_body@plt>
  17d2ec:      	b	0x17d26c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x14ac>
  17d2f0:      	ldp	x21, x9, [x19, #0x130]
  17d2f4:      	cmp	x21, x9
  17d2f8:      	b.ne	0x17bfa4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1e4>
  17d2fc:      	mov	w8, wzr
  17d300:      	b	0x17c010 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x250>
  17d304:      	cmp	w10, #0x1
  17d308:      	b.ne	0x17c338 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x578>
  17d30c:      	ldr	x10, [x19, #0x100]
  17d310:      	b	0x17c038 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x278>
  17d314:      	ldr	x8, [sp, #0x1b0]
  17d318:      	str	x0, [sp, #0x1a8]
  17d31c:      	sub	x1, x8, x0
  17d320:      	bl	0x1e55a8 <_ZdlPvm@plt>
  17d324:      	b	0x17c9e0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xc20>
  17d328:      	nop
  17d32c:      	adr	x0, #0x9b2d4
  17d330:      	bl	0x1e6040 <__cxa_guard_acquire@plt>
  17d334:      	cbz	w0, 0x17cfcc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x120c>
  17d338:      	nop
  17d33c:      	adr	x21, #0x9b22c
  17d340:      	adrp	x1, 0x69000
  17d344:      	add	x1, x1, #0xe40
  17d348:      	mov	x0, x21
  17d34c:      	bl	0x1e6718 <_ZN7android3gui12FenceMonitorC1EPKc@plt>
  17d350:      	nop
  17d354:      	adr	x0, #-0x5a7a8
  17d358:      	nop
  17d35c:      	adr	x2, #0x6eca4
  17d360:      	mov	x1, x21
  17d364:      	bl	0x1e5548 <__cxa_atexit@plt>
  17d368:      	nop
  17d36c:      	adr	x0, #0x9b294
  17d370:      	bl	0x1e6058 <__cxa_guard_release@plt>
  17d374:      	b	0x17cfcc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x120c>
  17d378:      	mov	x22, xzr
  17d37c:      	mov	w23, wzr
  17d380:      	ldr	x10, [x9, x22]
  17d384:      	cbnz	x10, 0x17d594 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x17d4>
  17d388:      	sub	x10, x8, x9
  17d38c:      	add	w23, w23, #0x1
  17d390:      	add	x22, x22, #0x78
  17d394:      	lsr	x10, x10, #3
  17d398:      	mul	w10, w10, w21
  17d39c:      	cmp	w23, w10
  17d3a0:      	b.lt	0x17d380 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x15c0>
  17d3a4:      	ldr	x20, [sp, #0x240]
  17d3a8:      	add	x0, x19, #0x4d0
  17d3ac:      	bl	0x1e5ea8 <_ZNSt3__15mutex4lockEv@plt>
  17d3b0:      	cmp	x27, x20
  17d3b4:      	b.eq	0x17c0ac <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x2ec>
  17d3b8:      	ldr	x8, [sp, #0x248]
  17d3bc:      	ldr	x9, [sp, #0x240]
  17d3c0:      	sub	x8, x8, x9
  17d3c4:      	cmp	x8, #0x4
  17d3c8:      	b.ne	0x17d5ec <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x182c>
  17d3cc:      	add	x0, x19, #0x4d0
  17d3d0:      	bl	0x1e5ec0 <_ZNSt3__15mutex6unlockEv@plt>
  17d3d4:      	ldr	x0, [sp, #0x240]
  17d3d8:      	ldr	w22, [x0]
  17d3dc:      	b	0x17c0f4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x334>
  17d3e0:      	bl	0x1e74b0 <free@plt>
  17d3e4:      	b	0x17c108 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x348>
  17d3e8:      	mov	w21, wzr
  17d3ec:      	b	0x17c154 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x394>
  17d3f0:      	ldr	x8, [sp, #0x330]
  17d3f4:      	str	x0, [sp, #0x328]
  17d3f8:      	sub	x1, x8, x0
  17d3fc:      	bl	0x1e55a8 <_ZdlPvm@plt>
  17d400:      	b	0x17c424 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x664>
  17d404:      	mov	w8, wzr
  17d408:      	strb	wzr, [sp, #0x1d0]
  17d40c:      	b	0x17c4bc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x6fc>
  17d410:      	ldr	x0, [sp, #0x1d0]
  17d414:      	cbz	x0, 0x17c4d8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x718>
  17d418:      	ldr	x8, [sp, #0x1e0]
  17d41c:      	str	x0, [sp, #0x1d8]
  17d420:      	sub	x1, x8, x0
  17d424:      	bl	0x1e55a8 <_ZdlPvm@plt>
  17d428:      	b	0x17c4d8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x718>
  17d42c:      	add	x0, x19, #0x4d0
  17d430:      	bl	0x1e5ea8 <_ZNSt3__15mutex4lockEv@plt>
  17d434:      	ldr	x3, [x19, #0x4f8]
  17d438:      	ldr	x4, [x19, #0x500]
  17d43c:      	adrp	x1, 0x7a000
  17d440:      	add	x1, x1, #0x92e
  17d444:      	ldr	w5, [sp, #0x10]
  17d448:      	adrp	x2, 0x6c000
  17d44c:      	add	x2, x2, #0xf65
  17d450:      	mov	w0, #0x6
  17d454:      	bl	0x1e59f8 <__android_log_print@plt>
  17d458:      	add	x0, x19, #0x4d0
  17d45c:      	bl	0x1e5ec0 <_ZNSt3__15mutex6unlockEv@plt>
  17d460:      	cmp	x28, x22
  17d464:      	b.ne	0x17d4b4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x16f4>
  17d468:      	tbnz	w20, #0x0, 0x17c9cc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xc0c>
  17d46c:      	add	x8, x19, #0x450
  17d470:      	add	x0, sp, #0x240
  17d474:      	add	x1, sp, #0x2c
  17d478:      	add	x2, sp, #0x2c
  17d47c:      	str	x8, [sp, #0x240]
  17d480:      	bl	0x141130 <_ZN7android7Surface12attachBufferERKNS_2spINS_13GraphicBufferEEE+0x364>
  17d484:      	b	0x17c9cc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xc0c>
  17d488:      	mov	x0, x22
  17d48c:      	add	x20, x1, x2
  17d490:      	bl	0x1eb0b0 <memmove@plt>
  17d494:      	ldr	x21, [sp, #0x1a8]
  17d498:      	sub	x22, x23, x20
  17d49c:      	mov	x1, x20
  17d4a0:      	mov	x2, x22
  17d4a4:      	mov	x0, x21
  17d4a8:      	bl	0x1eb0b0 <memmove@plt>
  17d4ac:      	add	x8, x21, x22
  17d4b0:      	b	0x17c408 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x648>
  17d4b4:      	ldr	w8, [sp, #0xc]
  17d4b8:      	tbnz	w8, #0x0, 0x17c9cc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xc0c>
  17d4bc:      	add	x0, x19, #0xf0
  17d4c0:      	add	x1, sp, #0x20
  17d4c4:      	bl	0x17efec <_ZN7android7Surface20onBufferQueuedLockedEiRKNS_2spINS_5FenceEEERKNS_22IGraphicBufferProducer17QueueBufferOutputEb+0x29c>
  17d4c8:      	b	0x17c9cc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xc0c>
  17d4cc:      	tst	x8, x10
  17d4d0:      	b.ne	0x17d528 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1768>
  17d4d4:      	and	x13, x13, x10
  17d4d8:      	cmp	x13, x12
  17d4dc:      	add	x15, x19, #0x450
  17d4e0:      	b.ne	0x17c5d8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x818>
  17d4e4:      	b	0x17c53c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x77c>
  17d4e8:      	tst	x8, x10
  17d4ec:      	b.ne	0x17d550 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1790>
  17d4f0:      	and	x14, x14, x10
  17d4f4:      	cmp	x14, x12
  17d4f8:      	b.ne	0x17c734 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x974>
  17d4fc:      	b	0x17c72c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x96c>
  17d500:      	ldr	x8, [x9]
  17d504:      	str	x8, [x21]
  17d508:      	ldr	x8, [x20]
  17d50c:      	b	0x17c56c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x7ac>
  17d510:      	tst	x8, x10
  17d514:      	b.ne	0x17d574 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x17b4>
  17d518:      	and	x13, x13, x10
  17d51c:      	cmp	x13, x12
  17d520:      	b.ne	0x17c860 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xaa0>
  17d524:      	b	0x17c78c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x9cc>
  17d528:      	cmp	x13, x8
  17d52c:      	b.lo	0x17d4d8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1718>
  17d530:      	udiv	x14, x13, x8
  17d534:      	msub	x13, x14, x8, x13
  17d538:      	b	0x17d4d8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1718>
  17d53c:      	cmp	w13, #0x7
  17d540:      	b.ne	0x17d588 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x17c8>
  17d544:      	stp	w11, w8, [sp, #0x30]
  17d548:      	stp	w10, w9, [sp, #0x38]
  17d54c:      	b	0x17c2f0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x530>
  17d550:      	cmp	x14, x8
  17d554:      	b.lo	0x17d4f4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1734>
  17d558:      	udiv	x15, x14, x8
  17d55c:      	msub	x14, x15, x8, x14
  17d560:      	b	0x17d4f4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1734>
  17d564:      	cmp	w8, #0x1
  17d568:      	b.ne	0x17c338 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x578>
  17d56c:      	ldr	x8, [x19, #0x100]
  17d570:      	b	0x17c7f0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xa30>
  17d574:      	cmp	x13, x8
  17d578:      	b.lo	0x17d51c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x175c>
  17d57c:      	udiv	x14, x13, x8
  17d580:      	msub	x13, x14, x8, x13
  17d584:      	b	0x17d51c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x175c>
  17d588:      	stp	w8, w14, [sp, #0x30]
  17d58c:      	stp	w9, w12, [sp, #0x38]
  17d590:      	b	0x17c2f0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x530>
  17d594:      	ldr	x11, [sp, #0x20]
  17d598:      	cmp	x10, x11
  17d59c:      	b.eq	0x17d5c0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1800>
  17d5a0:      	ldr	x12, [x10, #0x70]
  17d5a4:      	ldr	x13, [x11, #0x70]
  17d5a8:      	cmp	x12, x13
  17d5ac:      	b.eq	0x17d5c0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1800>
  17d5b0:      	ldr	x10, [x10, #0xd8]
  17d5b4:      	ldr	x11, [x11, #0xd8]
  17d5b8:      	cmp	x10, x11
  17d5bc:      	b.ne	0x17d388 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x15c8>
  17d5c0:      	ldr	x8, [sp, #0x250]
  17d5c4:      	cmp	x27, x8
  17d5c8:      	b.hs	0x17d6c4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1904>
  17d5cc:      	str	w23, [x27], #0x4
  17d5d0:      	ldp	x9, x8, [x19, #0xd8]
  17d5d4:      	str	x27, [sp, #0x248]
  17d5d8:      	b	0x17d388 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x15c8>
  17d5dc:      	bl	0xbd404 <_ZN7android3guilsERNSt3__113basic_ostreamIcNS1_11char_traitsIcEEEERKNS0_10WindowInfoE+0x858>
  17d5e0:      	mov	w8, wzr
  17d5e4:      	strb	wzr, [sp, #0x240]
  17d5e8:      	b	0x17cf44 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1184>
  17d5ec:      	ldr	x8, [sp, #0x20]
  17d5f0:      	ldr	x20, [x19, #0x4f8]
  17d5f4:      	add	x0, sp, #0x240
  17d5f8:      	ldr	x21, [x19, #0x500]
  17d5fc:      	add	x27, sp, #0x1d0
  17d600:      	ldr	x22, [x8, #0x70]
  17d604:      	ldr	x23, [x8, #0xd8]
  17d608:      	add	x8, sp, #0x1d0
  17d60c:      	bl	0xbc48c <_ZNK7android4view7Surface8toStringEv+0x23c>
  17d610:      	ldrb	w8, [sp, #0x1d0]
  17d614:      	ldr	x9, [sp, #0x1e0]
  17d618:      	adrp	x1, 0x7a000
  17d61c:      	add	x1, x1, #0x92e
  17d620:      	adrp	x2, 0x69000
  17d624:      	add	x2, x2, #0xdef
  17d628:      	tst	w8, #0x1
  17d62c:      	adrp	x5, 0x70000
  17d630:      	add	x5, x5, #0x958
  17d634:      	csinc	x8, x9, x27, ne
  17d638:      	mov	w0, #0x6
  17d63c:      	mov	x3, x20
  17d640:      	mov	x4, x21
  17d644:      	mov	x6, x22
  17d648:      	mov	x7, x23
  17d64c:      	str	x8, [sp]
  17d650:      	bl	0x1e59f8 <__android_log_print@plt>
  17d654:      	ldrb	w8, [sp, #0x1d0]
  17d658:      	tbz	w8, #0x0, 0x17d3cc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x160c>
  17d65c:      	ldr	x8, [sp, #0x1d0]
  17d660:      	ldr	x0, [sp, #0x1e0]
  17d664:      	and	x1, x8, #0xfffffffffffffffe
  17d668:      	bl	0x1e55a8 <_ZdlPvm@plt>
  17d66c:      	b	0x17d3cc <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x160c>
  17d670:      	bl	0x1e7600 <_ZNSt3__112__next_primeEm@plt>
  17d674:      	cmp	x28, x0
  17d678:      	csel	x1, x28, x0, hi
  17d67c:      	cmp	x1, x20
  17d680:      	b.lo	0x17cca8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xee8>
  17d684:      	b	0x17ccb0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0xef0>
  17d688:      	ldr	x9, [x21, #0x18]
  17d68c:      	ldr	x10, [x21]
  17d690:      	sub	x11, x9, x10
  17d694:      	cmp	x22, x11
  17d698:      	b.hs	0x17d724 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1964>
  17d69c:      	mov	w0, #0x1000
  17d6a0:      	cmp	x9, x8
  17d6a4:      	b.eq	0x17d838 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1a78>
  17d6a8:      	bl	0x1e5590 <_Znwm@plt>
  17d6ac:      	str	x0, [sp, #0x1d0]
  17d6b0:      	adrp	x0, 0x218000 <_ZN7android22IGraphicBufferProducer10descriptorE>
  17d6b4:      	add	x0, x0, #0x578
  17d6b8:      	add	x1, sp, #0x1d0
  17d6bc:      	bl	0x10fce4 <_ZN7android8hardware8graphics11bufferqueue4V1_05utils24H2BGraphicBufferProducer14setAutoRefreshEb+0x14b4>
  17d6c0:      	b	0x17d054 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1294>
  17d6c4:      	ldr	x10, [sp, #0x240]
  17d6c8:      	sub	x20, x27, x10
  17d6cc:      	asr	x9, x20, #2
  17d6d0:      	add	x9, x9, #0x1
  17d6d4:      	lsr	x11, x9, #62
  17d6d8:      	cbnz	x11, 0x17d860 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1aa0>
  17d6dc:      	sub	x8, x8, x10
  17d6e0:      	mov	x11, #0x7ffffffffffffffc
  17d6e4:      	ldr	x28, [sp, #0x258]
  17d6e8:      	asr	x10, x8, #1
  17d6ec:      	cmp	x10, x9
  17d6f0:      	csel	x9, x10, x9, hi
  17d6f4:      	cmp	x8, x11
  17d6f8:      	mov	x8, #0x3fffffffffffffff
  17d6fc:      	csel	x8, x9, x8, lo
  17d700:      	cmp	x8, #0x4
  17d704:      	str	x8, [sp, #0x10]
  17d708:      	b.hi	0x17d7d4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1a14>
  17d70c:      	ldrb	w8, [x28, #0x10]
  17d710:      	tbnz	w8, #0x0, 0x17d7d4 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1a14>
  17d714:      	mov	w8, #0x1
  17d718:      	mov	x0, x28
  17d71c:      	strb	w8, [x28, #0x10]
  17d720:      	b	0x17d7e0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1a20>
  17d724:      	movi	v0.2d, #0000000000000000
  17d728:      	asr	x8, x11, #2
  17d72c:      	cmp	x9, x10
  17d730:      	csinc	x1, x8, xzr, ne
  17d734:      	add	x8, sp, #0x1d0
  17d738:      	add	x0, x8, #0x18
  17d73c:      	stp	q0, q0, [x26, #0x110]
  17d740:      	bl	0xd6b80 <_ZN7android21SurfaceComposerClient11Transaction14takeScreenshotERKNS_3gui18DisplayCaptureArgsERKNS_2spINS2_22IScreenCaptureListenerEEE+0x5f0>
  17d744:      	add	x8, x0, x22
  17d748:      	add	x9, x0, x1, lsl #3
  17d74c:      	stp	x0, x8, [sp, #0x1d0]
  17d750:      	mov	w0, #0x1000
  17d754:      	stp	x8, x9, [sp, #0x1e0]
  17d758:      	bl	0x1e5590 <_Znwm@plt>
  17d75c:      	str	x0, [sp, #0x40]
  17d760:      	add	x0, sp, #0x1d0
  17d764:      	add	x1, sp, #0x40
  17d768:      	bl	0x10fce4 <_ZN7android8hardware8graphics11bufferqueue4V1_05utils24H2BGraphicBufferProducer14setAutoRefreshEb+0x14b4>
  17d76c:      	ldp	x8, x22, [x23]
  17d770:      	cmp	x22, x8
  17d774:      	b.eq	0x17d7a0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x19e0>
  17d778:      	adrp	x27, 0x218000 <_ZN7android22IGraphicBufferProducer10descriptorE>
  17d77c:      	sub	x22, x22, #0x8
  17d780:      	add	x0, sp, #0x1d0
  17d784:      	mov	x1, x22
  17d788:      	bl	0xd6998 <_ZN7android21SurfaceComposerClient11Transaction14takeScreenshotERKNS_3gui18DisplayCaptureArgsERKNS_2spINS2_22IScreenCaptureListenerEEE+0x408>
  17d78c:      	ldr	x8, [x27, #0x580]
  17d790:      	cmp	x22, x8
  17d794:      	b.ne	0x17d77c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x19bc>
  17d798:      	adrp	x9, 0x218000 <_ZN7android22IGraphicBufferProducer10descriptorE>
  17d79c:      	ldr	x22, [x9, #0x588]
  17d7a0:      	ldr	x0, [x21]
  17d7a4:      	ldp	q0, q1, [x26, #0x110]
  17d7a8:      	sub	x10, x22, x8
  17d7ac:      	ldr	x9, [x21, #0x18]
  17d7b0:      	stp	x0, x8, [sp, #0x1d0]
  17d7b4:      	and	x8, x10, #0xfffffffffffffff8
  17d7b8:      	sub	x8, x22, x8
  17d7bc:      	stp	q0, q1, [x21]
  17d7c0:      	stp	x8, x9, [sp, #0x1e0]
  17d7c4:      	cbz	x0, 0x17d054 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1294>
  17d7c8:      	sub	x1, x9, x0
  17d7cc:      	bl	0x1e55a8 <_ZdlPvm@plt>
  17d7d0:      	b	0x17d054 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1294>
  17d7d4:      	ldr	x8, [sp, #0x10]
  17d7d8:      	lsl	x0, x8, #2
  17d7dc:      	bl	0x1e7498 <malloc@plt>
  17d7e0:      	add	x8, x0, x20
  17d7e4:      	ldr	x10, [sp, #0x10]
  17d7e8:      	mov	x27, x8
  17d7ec:      	str	w23, [x27], #0x4
  17d7f0:      	add	x10, x0, x10, lsl #2
  17d7f4:      	ldr	x9, [sp, #0x248]
  17d7f8:      	ldr	x1, [sp, #0x240]
  17d7fc:      	str	x10, [sp, #0x10]
  17d800:      	sub	x2, x9, x1
  17d804:      	sub	x20, x8, x2
  17d808:      	mov	x0, x20
  17d80c:      	bl	0x1eb0f8 <memcpy@plt>
  17d810:      	ldr	x0, [sp, #0x240]
  17d814:      	ldr	x8, [sp, #0x10]
  17d818:      	str	x20, [sp, #0x240]
  17d81c:      	str	x27, [sp, #0x248]
  17d820:      	str	x8, [sp, #0x250]
  17d824:      	cbz	x0, 0x17d5d0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1810>
  17d828:      	cmp	x0, x28
  17d82c:      	b.eq	0x17d864 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1aa4>
  17d830:      	bl	0x1e74b0 <free@plt>
  17d834:      	b	0x17d5d0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1810>
  17d838:      	bl	0x1e5590 <_Znwm@plt>
  17d83c:      	str	x0, [sp, #0x1d0]
  17d840:      	add	x1, sp, #0x1d0
  17d844:      	mov	x0, x21
  17d848:      	bl	0xd6bbc <_ZN7android21SurfaceComposerClient11Transaction14takeScreenshotERKNS_3gui18DisplayCaptureArgsERKNS_2spINS2_22IScreenCaptureListenerEEE+0x62c>
  17d84c:      	ldr	x8, [x21, #0x8]
  17d850:      	ldr	x9, [x8], #0x8
  17d854:      	str	x8, [x21, #0x8]
  17d858:      	str	x9, [sp, #0x1d0]
  17d85c:      	b	0x17d244 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1484>
  17d860:      	bl	0xbd404 <_ZN7android3guilsERNSt3__113basic_ostreamIcNS1_11char_traitsIcEEEERKNS0_10WindowInfoE+0x858>
  17d864:      	strb	wzr, [x28, #0x10]
  17d868:      	b	0x17d5d0 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1810>
  17d86c:      	ldr	x9, [x9]
  17d870:      	cbz	x9, 0x17c608 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x848>
  17d874:      	ldr	x10, [x9, #0x8]
  17d878:      	cmp	x10, x21
  17d87c:      	b.ne	0x17d890 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1ad0>
  17d880:      	ldr	w10, [x9, #0x10]
  17d884:      	cmp	w10, w22
  17d888:      	b.ne	0x17d86c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1aac>
  17d88c:      	b	0x17c670 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x8b0>
  17d890:      	tst	x20, x8
  17d894:      	b.ne	0x17d8a8 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1ae8>
  17d898:      	and	x10, x10, x8
  17d89c:      	cmp	x10, x28
  17d8a0:      	b.ne	0x17c608 <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x848>
  17d8a4:      	b	0x17d86c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1aac>
  17d8a8:      	cmp	x10, x20
  17d8ac:      	b.lo	0x17d89c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1adc>
  17d8b0:      	udiv	x11, x10, x20
  17d8b4:      	msub	x10, x11, x20, x10
  17d8b8:      	b	0x17d89c <_ZN7android7Surface16hook_queueBufferEP13ANativeWindowP19ANativeWindowBufferi+0x1adc>
