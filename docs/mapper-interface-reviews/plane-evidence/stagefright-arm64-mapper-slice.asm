Bounded mapper receiver excerpt. Full exact function retained operator-side.
  1cb0c0:      	mov	x0, x19
  1cb0c4:      	mov	x1, x27
  1cb0c8:      	mov	w2, wzr
  1cb0cc:      	bl	0x20a658 <_ZN7android18FrameRenderTracker31checkFencesAndGetRenderedFramesEPKNS0_4InfoEb@plt>
  1cb0d0:      	ldr	x25, [sp, #0x80]
  1cb0d4:      	b	0x1cb9bc <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x7850>
  1cb0d8:      	adrp	x0, 0x216000
  1cb0dc:      	ldr	x0, [x0, #0x950]
  1cb0e0:      	bl	0x204880 <pthread_mutex_lock@plt>
  1cb0e4:      	cmp	wzr, w0
  1cb0e8:      	b.vs	0x1cbef4 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x7d88>
  1cb0ec:      	adrp	x20, 0x216000
  1cb0f0:      	ldr	x20, [x20, #0x958]
  1cb0f4:      	ldr	x21, [x20]
  1cb0f8:      	cbnz	x21, 0x1cb110 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x6fa4>
  1cb0fc:      	mov	w0, #0x10
  1cb100:      	bl	0x2022e8 <_Znwm@plt>
  1cb104:      	mov	x21, x0
  1cb108:      	bl	0x20a6d0 <_ZN7android19GraphicBufferMapperC1Ev@plt>
  1cb10c:      	str	x21, [x20]
  1cb110:      	adrp	x0, 0x216000
  1cb114:      	ldr	x0, [x0, #0x950]
  1cb118:      	bl	0x204898 <pthread_mutex_unlock@plt>
  1cb11c:      	ldp	w8, w9, [x19, #0x3c]
  1cb120:      	movi	v0.2d, #0000000000000000
  1cb124:      	stp	xzr, xzr, [x29, #-0xa0]
  1cb128:      	stp	w8, w9, [x29, #-0x90]
  1cb12c:      	ldr	x8, [x19, #0x8]
  1cb130:      	stp	q0, q0, [x29, #-0x50]
  1cb134:      	stp	q0, q0, [x29, #-0x30]
  1cb138:      	stur	q0, [x29, #-0x60]
  1cb13c:      	cbz	x8, 0x1cb170 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x7004>
  1cb140:      	ldur	x8, [x29, #-0x88]
  1cb144:      	sub	x3, x29, #0x98
  1cb148:      	sub	x4, x29, #0xa0
  1cb14c:      	mov	x0, x21
  1cb150:      	mov	w2, #0x20
  1cb154:      	ldr	x1, [x8, #0x60]
  1cb158:      	bl	0x20a688 <_ZN7android19GraphicBufferMapper4lockEPK13native_handlejRKNS_4RectEPPv@plt>
  1cb15c:      	cbz	w0, 0x1cb240 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x70d4>
  1cb160:      	stp	xzr, xzr, [sp, #0x90]
  1cb164:      	adrp	x1, 0x5d000
  1cb168:      	add	x1, x1, #0xd03
  1cb16c:      	b	0x1cbf44 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x7dd8>
  1cb170:      	ldr	w8, [x19]
  1cb174:      	mov	w9, #0xff
  1cb178:      	movk	w9, #0x7f00, lsl #16
  1cb17c:      	cmp	w8, w9
  1cb180:      	b.gt	0x1cb200 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x7094>
  1cb184:      	cmp	w8, #0x13
  1cb188:      	b.eq	0x1cb220 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x70b4>
  1cb18c:      	cmp	w8, #0x15
  1cb190:      	b.eq	0x1cb220 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x70b4>
  1cb194:      	b	0x1cb140 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x6fd4>
  1cb198:      	adds	w8, w26, #0x1
  1cb19c:      	b.vs	0x1cbcc4 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x7b58>
  1cb1a0:      	adds	w9, w27, #0x1
  1cb1a4:      	b.vs	0x1cbcc4 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x7b58>
  1cb1a8:      	and	w26, w8, #0xfffffffe
  1cb1ac:      	and	w27, w9, #0xfffffffe
  1cb1b0:      	mov	w24, #0x3
  1cb1b4:      	ldr	x20, [x19, #0x18]
  1cb1b8:      	cbnz	x20, 0x1cacd0 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x6b64>
  1cb1bc:      	b	0x1caf20 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x6db4>
  1cb1c0:      	mov	w0, #0xa8
  1cb1c4:      	bl	0x2022e8 <_Znwm@plt>
  1cb1c8:      	mov	w8, #0x6
  1cb1cc:      	strb	wzr, [x0, #0x8]
  1cb1d0:      	stp	w20, w8, [x0]
  1cb1d4:      	strb	wzr, [x0, #0x80]
  1cb1d8:      	str	xzr, [x0, #0x88]
  1cb1dc:      	str	wzr, [x0, #0x90]
  1cb1e0:      	stp	xzr, xzr, [x0, #0x98]
  1cb1e4:      	str	x0, [x19, #0x8]
  1cb1e8:      	bl	0x1c6e60 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x2cf4>
  1cb1ec:      	tbz	w0, #0x0, 0x1cbde8 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x7c7c>
  1cb1f0:      	mov	w24, #0x4
  1cb1f4:      	ldr	x20, [x19, #0x18]
  1cb1f8:      	cbnz	x20, 0x1cacd0 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x6b64>
  1cb1fc:      	b	0x1caf20 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x6db4>
  1cb200:      	mov	w9, #0x16b
  1cb204:      	movk	w9, #0x7f42, lsl #16
  1cb208:      	cmp	w8, w9
  1cb20c:      	b.eq	0x1cb220 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x70b4>
  1cb210:      	mov	w9, #0x100
  1cb214:      	movk	w9, #0x7f00, lsl #16
  1cb218:      	cmp	w8, w9
  1cb21c:      	b.ne	0x1cb140 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x6fd4>
  1cb220:      	ldur	x8, [x29, #-0x88]
  1cb224:      	sub	x3, x29, #0x98
  1cb228:      	sub	x4, x29, #0x60
  1cb22c:      	mov	x0, x21
  1cb230:      	mov	w2, #0x20
  1cb234:      	ldr	x1, [x8, #0x60]
  1cb238:      	bl	0x20a670 <_ZN7android19GraphicBufferMapper9lockYCbCrEPK13native_handlejRKNS_4RectEP13android_ycbcr@plt>
  1cb23c:      	cbnz	w0, 0x1cbf38 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x7dcc>
  1cb240:      	ldr	x0, [x19, #0x8]
  1cb244:      	str	x21, [sp, #0x60]
  1cb248:      	cbz	x0, 0x1cb388 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x721c>
  1cb24c:      	ldr	w8, [x19, #0x3c]
  1cb250:      	subs	w8, w8, #0x1
  1cb254:      	b.vs	0x1cbe34 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x7cc8>
  1cb258:      	ldr	w9, [x19, #0x40]
  1cb25c:      	subs	w9, w9, #0x1
  1cb260:      	b.vs	0x1cbe34 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x7cc8>
  1cb264:      	ldur	x10, [x29, #-0x88]
  1cb268:      	ldrsw	x11, [x19, #0x38]
  1cb26c:      	sxtw	x8, w8
  1cb270:      	ldpsw	x2, x3, [x19, #0x20]
  1cb274:      	ldpsw	x4, x5, [x19, #0x28]
  1cb278:      	ldpsw	x6, x7, [x19, #0x30]
  1cb27c:      	ldpsw	x10, x13, [x10, #0x3c]
  1cb280:      	ldur	x12, [x29, #-0xa0]
  1cb284:      	sxtw	x9, w9
  1cb288:      	ldr	x1, [sp, #0x78]
  1cb28c:      	stp	xzr, xzr, [sp, #0x20]
  1cb290:      	stp	xzr, x8, [sp, #0x30]
  1cb294:      	stp	x13, x10, [sp, #0x10]
  1cb298:      	stp	x11, x12, [sp]
  1cb29c:      	str	x9, [sp, #0x40]
  1cb2a0:      	bl	0x1c7094 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x2f28>
  1cb2a4:      	ldur	x8, [x29, #-0x88]
  1cb2a8:      	ldr	x0, [sp, #0x60]
  1cb2ac:      	mov	x2, xzr
  1cb2b0:      	ldr	x1, [x8, #0x60]
  1cb2b4:      	bl	0x20a6a0 <_ZN7android19GraphicBufferMapper6unlockEPK13native_handlePNS_4base14unique_fd_implINS4_13DefaultCloserEEE@plt>
  1cb2b8:      	cbnz	w0, 0x1cbef8 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x7d8c>
  1cb2bc:      	mov	x26, #0x841a
  1cb2c0:      	ldr	x24, [sp, #0x70]
  1cb2c4:      	movk	x26, #0x9f98, lsl #16
  1cb2c8:      	movk	x26, #0x9d1f, lsl #32
  1cb2cc:      	movk	x26, #0x2d84, lsl #48
  1cb2d0:      	tbnz	x24, #0x3f, 0x1cb318 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x71ac>
  1cb2d4:      	ldr	x20, [x19, #0x18]
  1cb2d8:      	mov	x0, x25
  1cb2dc:      	ldr	x21, [x20, #0x98]
  1cb2e0:      	mov	x1, x21
  1cb2e4:      	bl	0x202000 <__cfi_slowpath@plt>
  1cb2e8:      	mov	x0, x20
  1cb2ec:      	mov	w1, #0x7
  1cb2f0:      	mov	x2, x24
  1cb2f4:      	blr	x21
  1cb2f8:      	cbz	w0, 0x1cb318 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x71ac>
  1cb2fc:      	mov	w3, w0
  1cb300:      	adrp	x1, 0x62000
