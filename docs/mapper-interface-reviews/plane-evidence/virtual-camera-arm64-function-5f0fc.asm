   5f0fc:      	paciasp
   5f100:      	sub	sp, sp, #0xa0
   5f104:      	stp	x29, x30, [sp, #0x50]
   5f108:      	str	x25, [sp, #0x60]
   5f10c:      	stp	x24, x23, [sp, #0x70]
   5f110:      	stp	x22, x21, [sp, #0x80]
   5f114:      	stp	x20, x19, [sp, #0x90]
   5f118:      	add	x29, sp, #0x50
   5f11c:      	mrs	x25, TPIDR_EL0
   5f120:      	mov	x21, x8
   5f124:      	ldr	x8, [x25, #0x28]
   5f128:      	stur	x8, [x29, #-0x8]
   5f12c:      	ldp	x8, x9, [x1, #0x10]
   5f130:      	stp	xzr, xzr, [x21]
   5f134:      	cmp	x8, x9
   5f138:      	b.eq	0x5f19c <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32d44>
   5f13c:      	ldp	x11, x10, [x1, #0x28]
   5f140:      	mov	x22, x1
   5f144:      	ldr	x9, [x1, #0x18]
   5f148:      	mov	x19, x0
   5f14c:      	sub	x8, x9, x8
   5f150:      	sub	x9, x10, x11
   5f154:      	lsr	x0, x8, #2
   5f158:      	lsr	x1, x9, #2
   5f15c:      	bl	0x93fa0 <native_handle_create@plt>
   5f160:      	mov	x20, x0
   5f164:      	cbz	x0, 0x5f1e4 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32d8c>
   5f168:      	ldp	x9, x8, [x22, #0x10]
   5f16c:      	cmp	x8, x9
   5f170:      	b.eq	0x5f1cc <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32d74>
   5f174:      	mov	x8, xzr
   5f178:      	add	x10, x20, #0xc
   5f17c:      	ldr	w9, [x9, x8, lsl #2]
   5f180:      	str	w9, [x10, x8, lsl #2]
   5f184:      	add	x8, x8, #0x1
   5f188:      	ldp	x9, x11, [x22, #0x10]
   5f18c:      	sub	x11, x11, x9
   5f190:      	cmp	x8, x11, asr #2
   5f194:      	b.lo	0x5f17c <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32d24>
   5f198:      	b	0x5f1d0 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32d78>
   5f19c:      	nop
   5f1a0:      	adr	x1, #-0x5090c
   5f1a4:      	adrp	x2, 0xe000
   5f1a8:      	add	x2, x2, #0x739
   5f1ac:      	mov	w0, #0x6
   5f1b0:      	bl	0x93370 <__android_log_print@plt>
   5f1b4:      	ldr	x8, [x25, #0x28]
   5f1b8:      	ldur	x9, [x29, #-0x8]
   5f1bc:      	cmp	x8, x9
   5f1c0:      	b.ne	0x5f868 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33410>
   5f1c4:      	stp	xzr, xzr, [x21]
   5f1c8:      	b	0x5f668 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33210>
   5f1cc:      	mov	x11, xzr
   5f1d0:      	ldp	x1, x8, [x22, #0x28]
   5f1d4:      	add	x9, x20, x11
   5f1d8:      	add	x0, x9, #0xc
   5f1dc:      	sub	x2, x8, x1
   5f1e0:      	bl	0x956f8 <memcpy@plt>
   5f1e4:      	adrp	x0, 0x9a000
   5f1e8:      	ldr	x0, [x0, #0x1f8]
   5f1ec:      	bl	0x941b0 <pthread_mutex_lock@plt>
   5f1f0:      	adrp	x24, 0x9a000
   5f1f4:      	ldr	x24, [x24, #0x200]
   5f1f8:      	ldr	x23, [x24]
   5f1fc:      	cbnz	x23, 0x5f214 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32dbc>
   5f200:      	mov	w0, #0x10
   5f204:      	bl	0x93490 <_Znwm@plt>
   5f208:      	mov	x23, x0
   5f20c:      	bl	0x94198 <_ZN7android19GraphicBufferMapperC1Ev@plt>
   5f210:      	str	x23, [x24]
   5f214:      	adrp	x0, 0x9a000
   5f218:      	ldr	x0, [x0, #0x1f8]
   5f21c:      	bl	0x941c8 <pthread_mutex_unlock@plt>
   5f220:      	add	x2, sp, #0x8
   5f224:      	mov	x0, x23
   5f228:      	mov	x1, x20
   5f22c:      	str	xzr, [sp, #0x8]
   5f230:      	bl	0x94120 <_ZN7android19GraphicBufferMapper22importBufferNoValidateEPK13native_handlePS3_@plt>
   5f234:      	cbz	w0, 0x5f260 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32e08>
   5f238:      	mov	w3, w0
   5f23c:      	nop
   5f240:      	adr	x1, #-0x509ac
   5f244:      	adrp	x2, 0x9000
   5f248:      	add	x2, x2, #0x45a
   5f24c:      	mov	w0, #0x6
   5f250:      	bl	0x93370 <__android_log_print@plt>
   5f254:      	stp	xzr, xzr, [x21]
   5f258:      	mov	w24, #0x1
   5f25c:      	b	0x5f358 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32f00>
   5f260:      	ldr	x24, [sp, #0x8]
   5f264:      	sub	x2, x29, #0x18
   5f268:      	mov	x0, x23
   5f26c:      	str	xzr, [sp]
   5f270:      	mov	x1, x24
   5f274:      	stp	xzr, x24, [x29, #-0x18]
   5f278:      	stur	xzr, [x29, #-0x20]
   5f27c:      	stp	xzr, xzr, [sp, #0x20]
   5f280:      	str	wzr, [sp, #0x1c]
   5f284:      	bl	0x941e0 <_ZN7android19GraphicBufferMapper8getWidthEPK13native_handlePm@plt>
   5f288:      	cbnz	w0, 0x5f2dc <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32e84>
   5f28c:      	sub	x2, x29, #0x20
   5f290:      	mov	x0, x23
   5f294:      	mov	x1, x24
   5f298:      	bl	0x941f8 <_ZN7android19GraphicBufferMapper9getHeightEPK13native_handlePm@plt>
   5f29c:      	cbnz	w0, 0x5f2dc <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32e84>
   5f2a0:      	add	x2, sp, #0x28
   5f2a4:      	mov	x0, x23
   5f2a8:      	mov	x1, x24
   5f2ac:      	bl	0x94210 <_ZN7android19GraphicBufferMapper8getUsageEPK13native_handlePm@plt>
   5f2b0:      	cbnz	w0, 0x5f2dc <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32e84>
   5f2b4:      	add	x2, sp, #0x20
   5f2b8:      	mov	x0, x23
   5f2bc:      	mov	x1, x24
   5f2c0:      	bl	0x94228 <_ZN7android19GraphicBufferMapper13getLayerCountEPK13native_handlePm@plt>
   5f2c4:      	cbnz	w0, 0x5f2dc <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32e84>
   5f2c8:      	add	x2, sp, #0x1c
   5f2cc:      	mov	x0, x23
   5f2d0:      	mov	x1, x24
   5f2d4:      	bl	0x94240 <_ZN7android19GraphicBufferMapper23getPixelFormatRequestedEPK13native_handlePNS_8hardware8graphics6common4V1_211PixelFormatE@plt>
   5f2d8:      	cbz	w0, 0x5f784 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x3332c>
   5f2dc:      	nop
   5f2e0:      	adr	x1, #-0x50a4c
   5f2e4:      	adrp	x2, 0xd000
   5f2e8:      	add	x2, x2, #0x26a
   5f2ec:      	mov	w0, #0x6
   5f2f0:      	bl	0x93370 <__android_log_print@plt>
   5f2f4:      	str	xzr, [sp]
   5f2f8:      	nop
   5f2fc:      	adr	x1, #-0x50a68
   5f300:      	adrp	x2, 0xe000
   5f304:      	add	x2, x2, #0x1cd
   5f308:      	mov	w0, #0x6
   5f30c:      	bl	0x93370 <__android_log_print@plt>
   5f310:      	stp	xzr, xzr, [x21]
   5f314:      	mov	w24, #0x1
   5f318:      	ldr	x23, [sp]
   5f31c:      	cbz	x23, 0x5f358 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32f00>
   5f320:      	mov	x0, #0xd043
   5f324:      	ldr	x1, [x23]
   5f328:      	movk	x0, #0x840c, lsl #16
   5f32c:      	movk	x0, #0x7bf6, lsl #32
   5f330:      	movk	x0, #0x6a8, lsl #48
   5f334:      	bl	0x933b8 <__cfi_slowpath@plt>
   5f338:      	ldr	x1, [x23]
   5f33c:      	nop
   5f340:      	adr	x8, #0x39a20
   5f344:      	cmp	x1, x8
   5f348:      	b.ne	0x5f86c <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33414>
   5f34c:      	mov	x1, sp
   5f350:      	mov	x0, x23
   5f354:      	bl	0x93970 <_ZNK7android7RefBase9decStrongEPKv@plt>
   5f358:      	cbz	x20, 0x5f380 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32f28>
   5f35c:      	mov	x0, #0xef86
   5f360:      	adrp	x1, 0x9a000
   5f364:      	movk	x0, #0x5b10, lsl #16
   5f368:      	ldr	x1, [x1, #0x1c8]
   5f36c:      	movk	x0, #0x763f, lsl #32
   5f370:      	movk	x0, #0x6262, lsl #48
   5f374:      	bl	0x933b8 <__cfi_slowpath@plt>
   5f378:      	mov	x0, x20
   5f37c:      	bl	0x94018 <native_handle_delete@plt>
   5f380:      	tbnz	w24, #0x0, 0x5f658 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33200>
   5f384:      	add	x0, x19, #0x78
   5f388:      	bl	0x935c8 <_ZNSt3__15mutex4lockEv@plt>
   5f38c:      	mov	w0, #0x28
   5f390:      	bl	0x93490 <_Znwm@plt>
   5f394:      	ldp	x9, x8, [x21]
   5f398:      	mov	x20, x0
   5f39c:      	ldr	x22, [x22, #0x8]
   5f3a0:      	str	xzr, [x0]
   5f3a4:      	str	w22, [x0, #0x10]
   5f3a8:      	stp	x9, x8, [x0, #0x18]
   5f3ac:      	cbz	x8, 0x5f3bc <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32f64>
   5f3b0:      	add	x1, x8, #0x8
   5f3b4:      	mov	w0, #0x1
   5f3b8:      	bl	0x2d340 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0xee8>
   5f3bc:      	sxtw	x8, w22
   5f3c0:      	ldr	x22, [x19, #0xa8]
   5f3c4:      	str	x8, [x20, #0x8]
   5f3c8:      	cbz	x22, 0x5f458 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33000>
   5f3cc:      	sub	x9, x22, #0x1
   5f3d0:      	tst	x22, x9
   5f3d4:      	b.eq	0x5f3f0 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32f98>
   5f3d8:      	cmp	x8, x22
   5f3dc:      	mov	x10, x8
   5f3e0:      	b.lo	0x5f3f4 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32f9c>
   5f3e4:      	udiv	x10, x8, x22
   5f3e8:      	msub	x10, x10, x22, x8
   5f3ec:      	b	0x5f3f4 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32f9c>
   5f3f0:      	and	x10, x9, x8
   5f3f4:      	ldr	x11, [x19, #0xa0]
   5f3f8:      	ldr	x11, [x11, x10, lsl #3]
   5f3fc:      	cbz	x11, 0x5f458 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33000>
   5f400:      	ldr	x11, [x11]
   5f404:      	cbz	x11, 0x5f458 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33000>
   5f408:      	ldr	w12, [x20, #0x10]
   5f40c:      	b	0x5f424 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32fcc>
   5f410:      	ldr	w13, [x11, #0x10]
   5f414:      	cmp	w13, w12
   5f418:      	b.eq	0x5f688 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33230>
   5f41c:      	ldr	x11, [x11]
   5f420:      	cbz	x11, 0x5f458 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33000>
   5f424:      	ldr	x13, [x11, #0x8]
   5f428:      	cmp	x13, x8
   5f42c:      	b.eq	0x5f410 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32fb8>
   5f430:      	tst	x22, x9
   5f434:      	b.eq	0x5f44c <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32ff4>
   5f438:      	cmp	x13, x22
   5f43c:      	b.lo	0x5f450 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32ff8>
   5f440:      	udiv	x14, x13, x22
   5f444:      	msub	x13, x14, x22, x13
   5f448:      	b	0x5f450 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32ff8>
   5f44c:      	and	x13, x13, x9
   5f450:      	cmp	x13, x10
   5f454:      	b.eq	0x5f41c <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32fc4>
   5f458:      	ldr	x8, [x19, #0xb8]
   5f45c:      	ldr	s1, [x19, #0xc0]
   5f460:      	add	x8, x8, #0x1
   5f464:      	ucvtf	s0, x8
   5f468:      	cbz	x22, 0x5f4a4 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x3304c>
   5f46c:      	ucvtf	s2, x22
   5f470:      	fmul	s2, s1, s2
   5f474:      	fcmp	s2, s0
   5f478:      	b.mi	0x5f4a4 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x3304c>
   5f47c:      	ldr	x8, [x19, #0xa8]
   5f480:      	ldr	x10, [x20, #0x8]
   5f484:      	sub	x9, x8, #0x1
   5f488:      	tst	x8, x9
   5f48c:      	b.eq	0x5f4c0 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33068>
   5f490:      	cmp	x10, x8
   5f494:      	b.lo	0x5f4c4 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x3306c>
   5f498:      	udiv	x11, x10, x8
   5f49c:      	msub	x10, x11, x8, x10
   5f4a0:      	b	0x5f4c4 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x3306c>
   5f4a4:      	lsl	x8, x22, #1
   5f4a8:      	cmp	x22, #0x3
   5f4ac:      	b.lo	0x5f51c <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x330c4>
   5f4b0:      	sub	x9, x22, #0x1
   5f4b4:      	tst	x22, x9
   5f4b8:      	cset	w9, ne
   5f4bc:      	b	0x5f520 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x330c8>
   5f4c0:      	and	x10, x9, x10
   5f4c4:      	ldr	x11, [x19, #0xa0]
   5f4c8:      	ldr	x12, [x11, x10, lsl #3]
   5f4cc:      	cbz	x12, 0x5f4e0 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33088>
   5f4d0:      	ldr	x8, [x12]
   5f4d4:      	str	x8, [x20]
   5f4d8:      	str	x20, [x12]
   5f4dc:      	b	0x5f644 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x331ec>
   5f4e0:      	mov	x12, x19
   5f4e4:      	ldr	x13, [x12, #0xb0]!
   5f4e8:      	str	x20, [x12]
   5f4ec:      	str	x13, [x20]
   5f4f0:      	str	x12, [x11, x10, lsl #3]
   5f4f4:      	ldr	x10, [x20]
   5f4f8:      	cbz	x10, 0x5f644 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x331ec>
   5f4fc:      	ldr	x10, [x10, #0x8]
   5f500:      	tst	x8, x9
   5f504:      	b.eq	0x5f638 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x331e0>
   5f508:      	cmp	x10, x8
   5f50c:      	b.lo	0x5f63c <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x331e4>
   5f510:      	udiv	x9, x10, x8
   5f514:      	msub	x10, x9, x8, x10
   5f518:      	b	0x5f63c <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x331e4>
   5f51c:      	mov	w9, #0x1
   5f520:      	fdiv	s0, s0, s1
   5f524:      	orr	x8, x9, x8
   5f528:      	fcvtpu	x10, s0
   5f52c:      	cmp	x8, x10
   5f530:      	csel	x21, x8, x10, hi
   5f534:      	subs	x8, x21, #0x1
   5f538:      	b.ne	0x5f544 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x330ec>
   5f53c:      	mov	w21, #0x2
   5f540:      	b	0x5f55c <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33104>
   5f544:      	tst	x21, x8
   5f548:      	b.eq	0x5f55c <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33104>
   5f54c:      	mov	x0, x21
   5f550:      	bl	0x939a0 <_ZNSt3__112__next_primeEm@plt>
   5f554:      	ldr	x22, [x19, #0xa8]
   5f558:      	mov	x21, x0
   5f55c:      	cmp	x21, x22
   5f560:      	b.ls	0x5f580 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33128>
   5f564:      	cbz	x21, 0x5f5cc <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33174>
   5f568:      	lsr	x8, x21, #61
   5f56c:      	cbnz	x8, 0x5f884 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x3342c>
   5f570:      	lsl	x0, x21, #3
   5f574:      	bl	0x93490 <_Znwm@plt>
   5f578:      	mov	x8, x0
   5f57c:      	b	0x5f5d0 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33178>
   5f580:      	b.hs	0x5f47c <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33024>
   5f584:      	ldr	x8, [x19, #0xb8]
   5f588:      	ldr	s1, [x19, #0xc0]
   5f58c:      	cmp	x22, #0x3
   5f590:      	ucvtf	s0, x8
   5f594:      	fdiv	s0, s0, s1
   5f598:      	fcvtpu	x0, s0
   5f59c:      	b.lo	0x5f6c8 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33270>
   5f5a0:      	sub	x8, x22, #0x1
   5f5a4:      	and	x8, x22, x8
   5f5a8:      	cbnz	x8, 0x5f6c8 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33270>
   5f5ac:      	sub	x8, x0, #0x1
   5f5b0:      	mov	w9, #0x1
   5f5b4:      	cmp	x0, #0x2
   5f5b8:      	clz	x8, x8
   5f5bc:      	neg	x8, x8
   5f5c0:      	lsl	x8, x9, x8
   5f5c4:      	csel	x0, x0, x8, lo
   5f5c8:      	b	0x5f6cc <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33274>
   5f5cc:      	mov	x8, xzr
   5f5d0:      	ldr	x0, [x19, #0xa0]
   5f5d4:      	str	x8, [x19, #0xa0]
   5f5d8:      	cbz	x0, 0x5f5e8 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33190>
   5f5dc:      	ldr	x8, [x19, #0xa8]
   5f5e0:      	lsl	x1, x8, #3
   5f5e4:      	bl	0x934a8 <_ZdlPvm@plt>
   5f5e8:      	str	x21, [x19, #0xa8]
   5f5ec:      	cbz	x21, 0x5f47c <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33024>
   5f5f0:      	mov	x8, xzr
   5f5f4:      	ldr	x9, [x19, #0xa0]
   5f5f8:      	str	xzr, [x9, x8, lsl #3]
   5f5fc:      	add	x8, x8, #0x1
   5f600:      	cmp	x21, x8
   5f604:      	b.ne	0x5f5f4 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x3319c>
   5f608:      	mov	x11, x19
   5f60c:      	ldr	x9, [x11, #0xb0]!
   5f610:      	cbz	x9, 0x5f47c <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33024>
   5f614:      	sub	x8, x21, #0x1
   5f618:      	ldr	x10, [x9, #0x8]
   5f61c:      	tst	x21, x8
   5f620:      	b.eq	0x5f6e0 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33288>
   5f624:      	cmp	x10, x21
   5f628:      	b.lo	0x5f6e4 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x3328c>
   5f62c:      	udiv	x12, x10, x21
   5f630:      	msub	x10, x12, x21, x10
   5f634:      	b	0x5f6e4 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x3328c>
   5f638:      	and	x10, x10, x9
   5f63c:      	ldr	x8, [x19, #0xa0]
   5f640:      	str	x20, [x8, x10, lsl #3]
   5f644:      	ldr	x8, [x19, #0xb8]
   5f648:      	add	x8, x8, #0x1
   5f64c:      	str	x8, [x19, #0xb8]
   5f650:      	add	x0, x19, #0x78
   5f654:      	bl	0x93610 <_ZNSt3__15mutex6unlockEv@plt>
   5f658:      	ldr	x8, [x25, #0x28]
   5f65c:      	ldur	x9, [x29, #-0x8]
   5f660:      	cmp	x8, x9
   5f664:      	b.ne	0x5f868 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33410>
   5f668:      	ldp	x20, x19, [sp, #0x90]
   5f66c:      	ldr	x25, [sp, #0x60]
   5f670:      	ldp	x22, x21, [sp, #0x80]
   5f674:      	ldp	x24, x23, [sp, #0x70]
   5f678:      	ldp	x29, x30, [sp, #0x50]
   5f67c:      	add	sp, sp, #0xa0
   5f680:      	autiasp
   5f684:      	ret
   5f688:      	ldr	x21, [x20, #0x20]
   5f68c:      	cbz	x21, 0x5f6b8 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33260>
   5f690:      	add	x1, x21, #0x8
   5f694:      	mov	x0, #-0x1
   5f698:      	bl	0x2d310 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0xeb8>
   5f69c:      	cbnz	x0, 0x5f6b8 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33260>
   5f6a0:      	ldr	x8, [x21]
   5f6a4:      	mov	x0, x21
   5f6a8:      	ldr	x8, [x8, #0x10]
   5f6ac:      	blr	x8
   5f6b0:      	mov	x0, x21
   5f6b4:      	bl	0x93580 <_ZNSt3__119__shared_weak_count14__release_weakEv@plt>
   5f6b8:      	mov	x0, x20
   5f6bc:      	mov	w1, #0x28
   5f6c0:      	bl	0x934a8 <_ZdlPvm@plt>
   5f6c4:      	b	0x5f650 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x331f8>
   5f6c8:      	bl	0x939a0 <_ZNSt3__112__next_primeEm@plt>
   5f6cc:      	cmp	x21, x0
   5f6d0:      	csel	x21, x21, x0, hi
   5f6d4:      	cmp	x21, x22
   5f6d8:      	b.hs	0x5f47c <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33024>
   5f6dc:      	b	0x5f564 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x3310c>
   5f6e0:      	and	x10, x10, x8
   5f6e4:      	ldr	x12, [x19, #0xa0]
   5f6e8:      	str	x11, [x12, x10, lsl #3]
   5f6ec:      	ldr	x11, [x9]
   5f6f0:      	cbnz	x11, 0x5f70c <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x332b4>
   5f6f4:      	b	0x5f47c <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33024>
   5f6f8:      	mov	x12, x10
   5f6fc:      	mov	x9, x11
   5f700:      	ldr	x11, [x11]
   5f704:      	mov	x10, x12
   5f708:      	cbz	x11, 0x5f47c <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33024>
   5f70c:      	ldr	x12, [x11, #0x8]
   5f710:      	tst	x21, x8
   5f714:      	b.eq	0x5f734 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x332dc>
   5f718:      	cmp	x12, x21
   5f71c:      	b.lo	0x5f728 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x332d0>
   5f720:      	udiv	x13, x12, x21
   5f724:      	msub	x12, x13, x21, x12
   5f728:      	cmp	x12, x10
   5f72c:      	b.eq	0x5f6f8 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x332a0>
   5f730:      	b	0x5f740 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x332e8>
   5f734:      	and	x12, x12, x8
   5f738:      	cmp	x12, x10
   5f73c:      	b.eq	0x5f6f8 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x332a0>
   5f740:      	ldr	x13, [x19, #0xa0]
   5f744:      	ldr	x14, [x13, x12, lsl #3]
   5f748:      	cbz	x14, 0x5f77c <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33324>
   5f74c:      	ldr	x13, [x11]
   5f750:      	str	x13, [x9]
   5f754:      	ldr	x13, [x19, #0xa0]
   5f758:      	ldr	x13, [x13, x12, lsl #3]
   5f75c:      	ldr	x13, [x13]
   5f760:      	str	x13, [x11]
   5f764:      	ldr	x13, [x19, #0xa0]
   5f768:      	ldr	x13, [x13, x12, lsl #3]
   5f76c:      	mov	x12, x10
   5f770:      	str	x11, [x13]
   5f774:      	mov	x11, x9
   5f778:      	b	0x5f6fc <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x332a4>
   5f77c:      	str	x9, [x13, x12, lsl #3]
   5f780:      	b	0x5f6fc <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x332a4>
   5f784:      	mov	w8, #0x1
   5f788:      	ldr	w9, [sp, #0x1c]
   5f78c:      	sub	x0, x29, #0x10
   5f790:      	strb	w8, [sp, #0x18]
   5f794:      	mov	x8, sp
   5f798:      	add	x1, sp, #0x18
   5f79c:      	sub	x2, x29, #0x18
   5f7a0:      	sub	x3, x29, #0x20
   5f7a4:      	add	x4, sp, #0x14
   5f7a8:      	add	x5, sp, #0x20
   5f7ac:      	add	x6, sp, #0x28
   5f7b0:      	sub	x7, x29, #0x18
   5f7b4:      	str	w9, [sp, #0x14]
   5f7b8:      	bl	0x5fd60 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x33908>
   5f7bc:      	ldr	x24, [sp]
   5f7c0:      	cbz	x24, 0x5f2f8 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32ea0>
   5f7c4:      	mov	x23, #0x5f8c
   5f7c8:      	ldr	x1, [x24]
   5f7cc:      	movk	x23, #0xd1b6, lsl #16
   5f7d0:      	movk	x23, #0x3be7, lsl #32
   5f7d4:      	movk	x23, #0x86b, lsl #48
   5f7d8:      	mov	x0, x23
   5f7dc:      	bl	0x933b8 <__cfi_slowpath@plt>
   5f7e0:      	mov	x0, x24
   5f7e4:      	bl	0x94138 <_ZNK7android13GraphicBuffer9initCheckEv@plt>
   5f7e8:      	cbnz	w0, 0x5f2f8 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32ea0>
   5f7ec:      	ldr	x24, [sp]
   5f7f0:      	mov	x0, x23
   5f7f4:      	ldr	x1, [x24]
   5f7f8:      	bl	0x933b8 <__cfi_slowpath@plt>
   5f7fc:      	mov	x0, x24
   5f800:      	bl	0x94150 <_ZN7android13GraphicBuffer17toAHardwareBufferEv@plt>
   5f804:      	bl	0x94168 <AHardwareBuffer_acquire@plt>
   5f808:      	ldr	x24, [sp]
   5f80c:      	mov	x0, x23
   5f810:      	ldr	x1, [x24]
   5f814:      	bl	0x933b8 <__cfi_slowpath@plt>
   5f818:      	mov	x0, x24
   5f81c:      	bl	0x94150 <_ZN7android13GraphicBuffer17toAHardwareBufferEv@plt>
   5f820:      	mov	x23, x0
   5f824:      	str	x0, [x21]
   5f828:      	mov	w0, #0x28
   5f82c:      	bl	0x93490 <_Znwm@plt>
   5f830:      	adrp	x8, 0x9a000
   5f834:      	adrp	x9, 0x9a000
   5f838:      	cmp	x23, #0x0
   5f83c:      	ldr	x8, [x8, #0x1e8]
   5f840:      	stp	xzr, x23, [x0, #0x10]
   5f844:      	cset	w24, eq
   5f848:      	ldr	x9, [x9, #0x1f0]
   5f84c:      	str	x0, [x21, #0x8]
   5f850:      	add	x8, x8, #0x10
   5f854:      	stp	x8, xzr, [x0]
   5f858:      	str	x9, [x0, #0x20]
   5f85c:      	ldr	x23, [sp]
   5f860:      	cbnz	x23, 0x5f320 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32ec8>
   5f864:      	b	0x5f358 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32f00>
   5f868:      	bl	0x956c8 <__stack_chk_fail@plt>
   5f86c:      	mov	x0, #0xf7a8
   5f870:      	movk	x0, #0x2cdc, lsl #16
   5f874:      	movk	x0, #0x51af, lsl #32
   5f878:      	movk	x0, #0xbf2d, lsl #48
   5f87c:      	bl	0x933b8 <__cfi_slowpath@plt>
   5f880:      	b	0x5f34c <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x32ef4>
   5f884:      	bl	0x2fcf0 <_ZN7android23isAidlNativeHandleEmptyERKN4aidl7android8hardware6common12NativeHandleE+0x3898>
