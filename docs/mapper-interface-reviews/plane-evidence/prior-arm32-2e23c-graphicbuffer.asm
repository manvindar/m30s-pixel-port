
retained-evidence/bt-graphics-evidence-43772935293/prior-system-arm32-libui.so:	file format elf32-littlearm

Disassembly of section .text:

0002e23c <_ZN7android13GraphicBufferC2Ev>:
   2e23c:      	push.w	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
   2e240:      	sub	sp, #0x1c
   2e242:      	mov	r9, r0
   2e244:      	ldr	r0, [pc, #0x1e0]        @ 0x2e428 <_ZN7android13GraphicBufferC2Ev+0x1ec>
   2e246:      	movw	r1, #0x6672
   2e24a:      	vmov.i32	q8, #0x0
   2e24e:      	add	r0, pc
   2e250:      	movt	r1, #0x5f62
   2e254:      	add.w	r4, r9, #0x10
   2e258:      	ldr	r0, [r0]
   2e25a:      	ldr	r0, [r0]
   2e25c:      	str	r0, [sp, #0x18]
   2e25e:      	movs	r0, #0x60
   2e260:      	strd	r1, r0, [r9, #8]
   2e264:      	mov	r0, r9
   2e266:      	vst1.64	{d16, d17}, [r4]!
   2e26a:      	blx	0x43510                 @ imm = #0x152a4
   2e26e:      	ldr	r0, [pc, #0x1bc]        @ 0x2e42c <_ZN7android13GraphicBufferC2Ev+0x1f0>
   2e270:      	ldr	r1, [pc, #0x1bc]        @ 0x2e430 <_ZN7android13GraphicBufferC2Ev+0x1f4>
   2e272:      	add	r0, pc
   2e274:      	ldr	r2, [pc, #0x1bc]        @ 0x2e434 <_ZN7android13GraphicBufferC2Ev+0x1f8>
   2e276:      	add	r1, pc
   2e278:      	ldr	r3, [pc, #0x1bc]        @ 0x2e438 <_ZN7android13GraphicBufferC2Ev+0x1fc>
   2e27a:      	ldr	r0, [r0]
   2e27c:      	add	r2, pc
   2e27e:      	ldr	r5, [r1]
   2e280:      	movs	r1, #0x2
   2e282:      	adds	r0, #0x8
   2e284:      	str.w	r0, [r9]
   2e288:      	add	r3, pc
   2e28a:      	str.w	r2, [r9, #0x24]
   2e28e:      	mov	r0, r5
   2e290:      	str	r3, [r4]
   2e292:      	strb.w	r1, [r9, #0x68]
   2e296:      	blx	0x43520                 @ imm = #0x15288
   2e29a:      	movs	r1, #0x0
   2e29c:      	cmp	r1, r0
   2e29e:      	bvs.w	0x2e41c <_ZN7android13GraphicBufferC2Ev+0x1e0> @ imm = #0x17a
   2e2a2:      	ldr	r0, [pc, #0x198]        @ 0x2e43c <_ZN7android13GraphicBufferC2Ev+0x200>
   2e2a4:      	add	r0, pc
   2e2a6:      	ldr	r4, [r0]
   2e2a8:      	ldr	r6, [r4]
   2e2aa:      	cbnz	r6, 0x2e2ba <_ZN7android13GraphicBufferC2Ev+0x7e> @ imm = #0xc
   2e2ac:      	movs	r0, #0x8
   2e2ae:      	blx	0x42880                 @ imm = #0x145d0
   2e2b2:      	mov	r6, r0
   2e2b4:      	blx	0x43530                 @ imm = #0x15278
   2e2b8:      	str	r0, [r4]
   2e2ba:      	mov	r0, r5
   2e2bc:      	blx	0x43540                 @ imm = #0x15280
   2e2c0:      	movs	r0, #0x0
   2e2c2:      	strd	r6, r0, [r9, #108]
   2e2c6:      	blx	0x43550                 @ imm = #0x15288
   2e2ca:      	ldr	r2, [pc, #0x174]        @ 0x2e440 <_ZN7android13GraphicBufferC2Ev+0x204>
   2e2cc:      	add	r2, pc
   2e2ce:      	ldrex	r1, [r2]
   2e2d2:      	adds	r3, r1, #0x1
   2e2d4:      	stlex	r7, r3, [r2]
   2e2d8:      	cmp	r7, #0x0
   2e2da:      	bne	0x2e2ce <_ZN7android13GraphicBufferC2Ev+0x92> @ imm = #-0x10
   2e2dc:      	strd	r1, r0, [r9, #128]
   2e2e0:      	vmov.i32	q8, #0x0
   2e2e4:      	add.w	r1, r9, #0x8c
   2e2e8:      	movs	r0, #0x14
   2e2ea:      	vst1.32	{d16, d17}, [r1], r0
   2e2ee:      	mov.w	r10, #0xffffffff
   2e2f2:      	add.w	r11, r9, #0xb0
   2e2f6:      	movs	r4, #0x0
   2e2f8:      	str.w	r10, [r9, #0x88]
   2e2fc:      	movs	r6, #0x0
   2e2fe:      	str	r1, [sp, #0x4]
   2e300:      	vst1.64	{d16, d17}, [r1]
   2e304:      	ldr	r0, [pc, #0x13c]        @ 0x2e444 <_ZN7android13GraphicBufferC2Ev+0x208>
   2e306:      	add	r0, pc
   2e308:      	ldr	r7, [r0]
   2e30a:      	b	0x2e320 <_ZN7android13GraphicBufferC2Ev+0xe4> @ imm = #0x12
   2e30c:      	adds	r6, #0xa0
   2e30e:      	str.w	r4, [r8, #0x98]
   2e312:      	cmp.w	r6, #0x640
   2e316:      	strb.w	r4, [r8, #0x94]
   2e31a:      	strh.w	r4, [r8, #0x88]
   2e31e:      	beq	0x2e388 <_ZN7android13GraphicBufferC2Ev+0x14c> @ imm = #0x66
   2e320:      	add.w	r8, r11, r6
   2e324:      	str.w	r10, [r11, r6]
   2e328:      	str.w	r10, [r8, #0x4]
   2e32c:      	ldr	r0, [r7]
   2e32e:      	str.w	r0, [r8, #0x8]
   2e332:      	ldr	r0, [r7, #0x4]
   2e334:      	str.w	r0, [r8, #0xc]
   2e338:      	cbz	r0, 0x2e34a <_ZN7android13GraphicBufferC2Ev+0x10e> @ imm = #0xe
   2e33a:      	adds	r0, #0x4
   2e33c:      	ldrex	r1, [r0]
   2e340:      	adds	r1, #0x1
   2e342:      	strex	r2, r1, [r0]
   2e346:      	cmp	r2, #0x0
   2e348:      	bne	0x2e33c <_ZN7android13GraphicBufferC2Ev+0x100> @ imm = #-0x10
   2e34a:      	mov	r5, r8
   2e34c:      	movs	r1, #0x4
   2e34e:      	str	r4, [r5, #28]!
   2e352:      	add.w	r0, r5, #0x10
   2e356:      	str	r0, [r5, #0xc]
   2e358:      	mov	r0, r5
   2e35a:      	strb.w	r4, [r5, #0x60]
   2e35e:      	strd	r4, r4, [r5, #4]
   2e362:      	strh	r4, [r5, #-12]
   2e366:      	bl	0x2fc6c <_ZN7android13GraphicBuffer16addDeathCallbackENSt3__18functionIFvPvyEEES3_+0x74> @ imm = #0x1902
   2e36a:      	ldr	r0, [r7]
   2e36c:      	str	r0, [r5, #0x64]
   2e36e:      	ldr	r0, [r7, #0x4]
   2e370:      	str	r0, [r5, #0x68]
   2e372:      	cmp	r0, #0x0
   2e374:      	beq	0x2e30c <_ZN7android13GraphicBufferC2Ev+0xd0> @ imm = #-0x6c
   2e376:      	adds	r0, #0x4
   2e378:      	ldrex	r1, [r0]
   2e37c:      	adds	r1, #0x1
   2e37e:      	strex	r2, r1, [r0]
   2e382:      	cmp	r2, #0x0
   2e384:      	bne	0x2e378 <_ZN7android13GraphicBufferC2Ev+0x13c> @ imm = #-0x10
   2e386:      	b	0x2e30c <_ZN7android13GraphicBufferC2Ev+0xd0> @ imm = #-0x7e
   2e388:      	vmov.i32	q8, #0x0
   2e38c:      	mov.w	r1, #0xffffffff
   2e390:      	str.w	r1, [r9, #0x6f0]
   2e394:      	add.w	r1, r9, #0x28
   2e398:      	movs	r0, #0x0
   2e39a:      	ldrd	r2, r3, [r9, #128]
   2e39e:      	vst1.64	{d16, d17}, [r1]!
   2e3a2:      	str.w	r0, [r9, #0x6f4]
   2e3a6:      	strd	r0, r0, [r9, #68]
   2e3aa:      	str.w	r0, [r9, #0x4c]
   2e3ae:      	str.w	r0, [r9, #0x3c]
   2e3b2:      	str	r0, [r1]
   2e3b4:      	add	r0, sp, #0x8
   2e3b6:      	blx	0x43560                 @ imm = #0x151a8
   2e3ba:      	ldrb.w	r0, [r9, #0xa0]
   2e3be:      	ldr.w	r1, [r9, #0xa0]
   2e3c2:      	lsls	r0, r0, #0x1f
   2e3c4:      	beq	0x2e3ca <_ZN7android13GraphicBufferC2Ev+0x18e> @ imm = #0x2
   2e3c6:      	cmp	r1, #0x1
   2e3c8:      	bls	0x2e420 <_ZN7android13GraphicBufferC2Ev+0x1e4> @ imm = #0x54
   2e3ca:      	lsls	r0, r1, #0x1f
   2e3cc:      	beq	0x2e3de <_ZN7android13GraphicBufferC2Ev+0x1a2> @ imm = #0xe
   2e3ce:      	cmp	r1, #0x1
   2e3d0:      	bls	0x2e424 <_ZN7android13GraphicBufferC2Ev+0x1e8> @ imm = #0x50
   2e3d2:      	ldr.w	r0, [r9, #0xa8]
   2e3d6:      	bic	r1, r1, #0x1
   2e3da:      	blx	0x428e0                 @ imm = #0x14504
   2e3de:      	movs	r1, #0x0
   2e3e0:      	vldr	d16, [sp, #8]
   2e3e4:      	strh.w	r1, [sp, #0x8]
   2e3e8:      	ldrd	r2, r1, [sp, #4]
   2e3ec:      	ldr	r0, [sp, #0x10]
   2e3ee:      	str	r0, [r2, #0x8]
   2e3f0:      	lsls	r0, r1, #0x1f
   2e3f2:      	vstr	d16, [r2]
   2e3f6:      	beq	0x2e402 <_ZN7android13GraphicBufferC2Ev+0x1c6> @ imm = #0x8
   2e3f8:      	ldr	r0, [sp, #0x10]
   2e3fa:      	bic	r1, r1, #0x1
   2e3fe:      	blx	0x428e0                 @ imm = #0x144e0
   2e402:      	ldr	r0, [sp, #0x18]
   2e404:      	ldr	r1, [pc, #0x40]         @ 0x2e448 <_ZN7android13GraphicBufferC2Ev+0x20c>
   2e406:      	add	r1, pc
   2e408:      	ldr	r1, [r1]
   2e40a:      	ldr	r1, [r1]
   2e40c:      	cmp	r1, r0
   2e40e:      	ittt	eq
   2e410:      	moveq	r0, r9
   2e412:      	addeq	sp, #0x1c
   2e414:      	popeq.w	{r4, r5, r6, r7, r8, r9, r10, r11, pc}
   2e418:      	blx	0x428f0                 @ imm = #0x144d4
   2e41c:      	blx	0x42020 <android_convertGralloc1To0Usage+0x666> @ imm = #0x13c00
   2e420:      	blx	0x41fc8 <android_convertGralloc1To0Usage+0x60e> @ imm = #0x13ba4
   2e424:      	blx	0x41fc8 <android_convertGralloc1To0Usage+0x60e> @ imm = #0x13ba0
   2e428:      	strb	r2, [r1, #0x14]
   2e42a:      	movs	r1, r0
   2e42c:      	strb	r6, [r1, #0x16]
   2e42e:      	movs	r1, r0
   2e430:      	strb	r6, [r1, #0x16]
   2e432:      	movs	r1, r0
   2e434:      	movs	r0, #0x29
   2e436:      	movs	r0, r0
   2e438:      	movs	r0, #0xf
   2e43a:      	movs	r0, r0
   2e43c:      	strb	r4, [r4, #0x15]
   2e43e:      	movs	r1, r0
   2e440:      	str	r2, [sp, #0xf0]
   2e442:      	movs	r1, r0
   2e444:      	strb	r6, [r5, #0x11]
   2e446:      	movs	r1, r0
   2e448:      	strb	r2, [r2, #0xd]
   2e44a:      	movs	r1, r0
