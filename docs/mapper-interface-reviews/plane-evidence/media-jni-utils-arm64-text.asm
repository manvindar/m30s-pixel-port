
retained-evidence/provider-callers-43776923589/legacy_graphics/abi-consumers/b6b501ae3b8e6f1857642b08b3a52212f28daa1011a1ef7a0d72b7870574401f.elf:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000004000 <.text>:
    4000:      	bti	c
    4004:      	nop
    4008:      	adr	x0, #0x3ff8
    400c:      	b	0x5960 <__cxa_finalize@plt>
    4010:      	bti	c
    4014:      	ret
    4018:      	bti	c
    401c:      	b	0x4010 <.text+0x10>
    4020:      	bti	c
    4024:      	adrp	x16, 0xc000
    4028:      	ldrb	w16, [x16]
    402c:      	cbz	w16, 0x4038 <.text+0x38>
    4030:      	ldadd	w0, w0, [x1]
    4034:      	ret
    4038:      	mov	w16, w0
    403c:      	ldxr	w0, [x1]
    4040:      	add	w17, w0, w16
    4044:      	stxr	w15, w17, [x1]
    4048:      	cbnz	w15, 0x403c <.text+0x3c>
    404c:      	ret
    4050:      	paciasp
    4054:      	sub	sp, sp, #0x70
    4058:      	str	x30, [sp, #0x60]
    405c:      	mov	w0, #0x10
    4060:      	bl	0x5b88 <getauxval@plt>
    4064:      	tbnz	w0, #0x8, 0x4080 <.text+0x80>
    4068:      	adrp	x9, 0xc000
    406c:      	ldr	x30, [sp, #0x60]
    4070:      	strb	wzr, [x9]
    4074:      	add	sp, sp, #0x70
    4078:      	autiasp
    407c:      	ret
    4080:      	nop
    4084:      	adr	x0, #-0x2cd4
    4088:      	add	x1, sp, #0x4
    408c:      	bl	0x5b40 <__system_property_get@plt>
    4090:      	cmp	w0, #0x1
    4094:      	b.lt	0x40cc <.text+0xcc>
    4098:      	adrp	x1, 0x1000
    409c:      	add	x1, x1, #0x42b
    40a0:      	add	x0, sp, #0x4
    40a4:      	mov	w2, #0xa
    40a8:      	bl	0x5b70 <strncmp@plt>
    40ac:      	cmp	w0, #0x0
    40b0:      	cset	w8, ne
    40b4:      	adrp	x9, 0xc000
    40b8:      	ldr	x30, [sp, #0x60]
    40bc:      	strb	w8, [x9]
    40c0:      	add	sp, sp, #0x70
    40c4:      	autiasp
    40c8:      	ret
    40cc:      	mov	w8, #0x1
    40d0:      	adrp	x9, 0xc000
    40d4:      	ldr	x30, [sp, #0x60]
    40d8:      	strb	w8, [x9]
    40dc:      	add	sp, sp, #0x70
    40e0:      	autiasp
    40e4:      	ret
    40e8:      	tbnz	x0, #0x3e, 0x40f4 <.text+0xf4>
    40ec:      	mov	x8, xzr
    40f0:      	b	0x40f8 <.text+0xf8>
    40f4:      	ldr	x8, [x1, #0x10]
    40f8:      	dup	v0.2d, x0
    40fc:      	adrp	x9, 0x1000
    4100:      	adrp	x10, 0x1000
    4104:      	adrp	x11, 0x1000
    4108:      	ldr	q1, [x9, #0xb0]
    410c:      	dup	v5.2d, x8
    4110:      	adrp	x9, 0x1000
    4114:      	ldr	q3, [x10, #0xd0]
    4118:      	ldr	q6, [x11, #0x170]
    411c:      	adrp	x10, 0x1000
    4120:      	ldr	q7, [x9, #0xa0]
    4124:      	ushl	v2.2d, v0.2d, v1.2d
    4128:      	ldr	q1, [x10, #0x1b0]
    412c:      	ushl	v4.2d, v0.2d, v3.2d
    4130:      	ushl	v3.2d, v0.2d, v6.2d
    4134:      	ushl	v6.2d, v5.2d, v7.2d
    4138:      	adrp	x9, 0x1000
    413c:      	adrp	x10, 0x1000
    4140:      	ushl	v5.2d, v0.2d, v1.2d
    4144:      	mov	v0.d[1], x8
    4148:      	ldr	q1, [x9, #0x1d0]
    414c:      	adrp	x9, 0x1000
    4150:      	ldr	q17, [x10, #0x180]
    4154:      	adrp	x10, 0x1000
    4158:      	dup	v7.2d, v6.d[0]
    415c:      	ldr	q16, [x9, #0x100]
    4160:      	adrp	x9, 0x1000
    4164:      	ldr	q20, [x10, #0xf0]
    4168:      	adrp	x11, 0x1000
    416c:      	adrp	x10, 0x1000
    4170:      	ushl	v18.2d, v0.2d, v1.2d
    4174:      	ldr	q1, [x9, #0xc0]
    4178:      	adrp	x9, 0x1000
    417c:      	ushl	v0.2d, v7.2d, v16.2d
    4180:      	ushl	v16.2d, v7.2d, v17.2d
    4184:      	ldr	q17, [x9, #0x1a0]
    4188:      	adrp	x9, 0x1000
    418c:      	ushl	v1.2d, v7.2d, v1.2d
    4190:      	ldr	q21, [x11, #0x190]
    4194:      	ldr	q19, [x9, #0x130]
    4198:      	adrp	x9, 0x1000
    419c:      	ushl	v17.2d, v7.2d, v17.2d
    41a0:      	ldr	q22, [x9, #0x1c0]
    41a4:      	adrp	x9, 0x1000
    41a8:      	ushl	v6.2d, v6.2d, v21.2d
    41ac:      	ushl	v19.2d, v7.2d, v19.2d
    41b0:      	ushl	v7.2d, v7.2d, v20.2d
    41b4:      	ldr	q20, [x9, #0x70]
    41b8:      	adrp	x9, 0x1000
    41bc:      	and	v18.16b, v18.16b, v22.16b
    41c0:      	adrp	x11, 0x1000
    41c4:      	adrp	x12, 0x1000
    41c8:      	adrp	x13, 0x1000
    41cc:      	ldr	q21, [x11, #0x120]
    41d0:      	and	v19.16b, v19.16b, v20.16b
    41d4:      	ldr	q20, [x9, #0x90]
    41d8:      	adrp	x9, 0x1000
    41dc:      	ldr	q23, [x9, #0x160]
    41e0:      	ldr	q22, [x12, #0x1e0]
    41e4:      	ldr	q24, [x10, #0xe0]
    41e8:      	and	v6.16b, v6.16b, v20.16b
    41ec:      	ldr	q25, [x13, #0x80]
    41f0:      	adrp	x9, 0x1000
    41f4:      	and	v7.16b, v7.16b, v23.16b
    41f8:      	and	v16.16b, v16.16b, v21.16b
    41fc:      	and	v20.16b, v0.16b, v22.16b
    4200:      	and	v17.16b, v17.16b, v24.16b
    4204:      	and	v21.16b, v1.16b, v25.16b
    4208:      	adrp	x10, 0x1000
    420c:      	lsl	x12, x0, #7
    4210:      	lsl	x11, x0, #3
    4214:      	lsr	x15, x0, #4
    4218:      	orr	v6.16b, v6.16b, v7.16b
    421c:      	orr	v7.16b, v18.16b, v19.16b
    4220:      	ldr	q18, [x9, #0x150]
    4224:      	adrp	x9, 0x1000
    4228:      	orr	v16.16b, v20.16b, v16.16b
    422c:      	orr	v17.16b, v21.16b, v17.16b
    4230:      	ldr	q19, [x9, #0x140]
    4234:      	adrp	x9, 0x1000
    4238:      	and	v4.16b, v4.16b, v18.16b
    423c:      	ldr	q20, [x10, #0x60]
    4240:      	ldr	q21, [x9, #0x110]
    4244:      	orr	v6.16b, v7.16b, v6.16b
    4248:      	and	v2.16b, v2.16b, v19.16b
    424c:      	orr	v16.16b, v17.16b, v16.16b
    4250:      	lsr	x10, x0, #16
    4254:      	and	v5.16b, v5.16b, v20.16b
    4258:      	and	v3.16b, v3.16b, v21.16b
    425c:      	and	x16, x12, #0x10000
    4260:      	and	x12, x12, #0x400000
    4264:      	and	x11, x11, #0x400
    4268:      	lsr	x13, x0, #7
    426c:      	orr	v2.16b, v2.16b, v4.16b
    4270:      	orr	v6.16b, v6.16b, v16.16b
    4274:      	bfi	x12, x10, #18, #1
    4278:      	orr	v3.16b, v3.16b, v5.16b
    427c:      	lsr	x14, x0, #6
    4280:      	lsr	x17, x8, #46
    4284:      	lsr	x8, x8, #23
    4288:      	lsr	x1, x0, #3
    428c:      	bfi	x16, x15, #15, #1
    4290:      	ext	v5.16b, v2.16b, v2.16b, #0x8
    4294:      	ext	v4.16b, v6.16b, v6.16b, #0x8
    4298:      	lsr	x9, x0, #22
    429c:      	ext	v7.16b, v3.16b, v3.16b, #0x8
    42a0:      	and	x13, x13, #0x20000
    42a4:      	and	x14, x14, #0x40
    42a8:      	and	x8, x8, #0x800
    42ac:      	and	x1, x1, #0x800000
    42b0:      	tst	x0, #0x1
    42b4:      	orr	x12, x12, x1
    42b8:      	orr	x8, x14, x8
    42bc:      	orr	v2.8b, v2.8b, v5.8b
    42c0:      	orr	v4.8b, v6.8b, v4.8b
    42c4:      	bfi	x12, x9, #30, #1
    42c8:      	orr	v3.8b, v3.8b, v7.8b
    42cc:      	mov	x9, v1.d[1]
    42d0:      	fmov	x10, d2
    42d4:      	fmov	x2, d4
    42d8:      	and	x9, x9, #0x1000000000
    42dc:      	orr	x10, x10, x11
    42e0:      	fmov	x11, d3
    42e4:      	orr	x10, x10, x16
    42e8:      	orr	x10, x10, x2
    42ec:      	orr	x11, x11, x13
    42f0:      	and	x13, x15, #0x2000
    42f4:      	orr	x8, x11, x8
    42f8:      	orr	x11, x12, x13
    42fc:      	orr	x8, x10, x8
    4300:      	fmov	x10, d0
    4304:      	bfi	x11, x17, #58, #1
    4308:      	orr	x12, x8, #0x300
    430c:      	csel	x8, x8, x12, eq
    4310:      	and	x10, x10, #0x8000000
    4314:      	orr	x10, x11, x10
    4318:      	orr	x9, x10, x9
    431c:      	orr	x8, x9, x8
    4320:      	adrp	x9, 0xc000
    4324:      	orr	x8, x8, #0x8000000000000000
    4328:      	str	x8, [x9, #0x8]
    432c:      	ret
    4330:      	bti	c
    4334:      	adrp	x8, 0xc000
    4338:      	ldr	x8, [x8, #0x8]
    433c:      	cbz	x8, 0x4344 <.text+0x344>
    4340:      	ret
    4344:      	paciasp
    4348:      	sub	sp, sp, #0x70
    434c:      	stp	x30, x19, [sp, #0x60]
    4350:      	nop
    4354:      	adr	x0, #-0x2fa4
    4358:      	mov	x1, sp
    435c:      	bl	0x5b40 <__system_property_get@plt>
    4360:      	cmp	w0, #0x0
    4364:      	b.le	0x4380 <.text+0x380>
    4368:      	adrp	x1, 0x1000
    436c:      	add	x1, x1, #0x42b
    4370:      	mov	x0, sp
    4374:      	mov	w2, #0xa
    4378:      	bl	0x5b70 <strncmp@plt>
    437c:      	cbz	w0, 0x43ac <.text+0x3ac>
    4380:      	mov	w0, #0x10
    4384:      	bl	0x5b88 <getauxval@plt>
    4388:      	mov	x19, x0
    438c:      	mov	w0, #0x1a
    4390:      	bl	0x5b88 <getauxval@plt>
    4394:      	mov	w8, #0x18
    4398:      	str	x0, [sp, #0x10]
    439c:      	orr	x0, x19, #0x4000000000000000
    43a0:      	mov	x1, sp
    43a4:      	stp	x8, x19, [sp]
    43a8:      	bl	0x40e8 <.text+0xe8>
    43ac:      	ldp	x30, x19, [sp, #0x60]
    43b0:      	add	sp, sp, #0x70
    43b4:      	autiasp
    43b8:      	ret
    43bc:      	udf	#0x0
    43c0:      	bti	c
    43c4:      	adrp	x16, 0xc000
    43c8:      	ldrb	w16, [x16]
    43cc:      	cbz	w16, 0x43d8 <.text+0x3d8>
    43d0:      	ldaddl	w0, w0, [x1]
    43d4:      	ret
    43d8:      	mov	w16, w0
    43dc:      	ldxr	w0, [x1]
    43e0:      	add	w17, w0, w16
    43e4:      	stlxr	w15, w17, [x1]
    43e8:      	cbnz	w15, 0x43dc <.text+0x3dc>
    43ec:      	ret

00000000000043f0 <_ZN7android23usingRGBAToJpegOverrideEii>:
    43f0:      	bti	c
    43f4:      	mov	w8, #0x21
    43f8:      	cmp	w0, #0x1
    43fc:      	ccmp	w1, w8, #0x0, eq
    4400:      	cset	w0, eq
    4404:      	ret

0000000000004408 <_ZN7android20applyFormatOverridesEii>:
    4408:      	bti	c
    440c:      	mov	w0, w1
    4410:      	ret

0000000000004414 <_ZN7android14isFormatOpaqueEi>:
    4414:      	bti	c
    4418:      	cmp	w0, #0x22
    441c:      	cset	w0, eq
    4420:      	ret

0000000000004424 <_ZN7android13isPossiblyYUVEi>:
    4424:      	bti	c
    4428:      	mov	w8, w0
    442c:      	cmp	w0, #0x3c
    4430:      	mov	w0, wzr
    4434:      	b.hi	0x4454 <_ZN7android13isPossiblyYUVEi+0x30>
    4438:      	mov	x10, #0x3e
    443c:      	mov	w9, w8
    4440:      	movk	x10, #0x1877, lsl #32
    4444:      	movk	x10, #0x1040, lsl #48
    4448:      	lsr	x9, x10, x9
    444c:      	tbz	w9, #0x0, 0x4454 <_ZN7android13isPossiblyYUVEi+0x30>
    4450:      	ret
    4454:      	mov	w9, #0x3859
    4458:      	movk	w9, #0x2020, lsl #16
    445c:      	cmp	w8, w9
    4460:      	b.eq	0x4450 <_ZN7android13isPossiblyYUVEi+0x2c>
    4464:      	mov	w9, #0x3159
    4468:      	movk	w9, #0x2036, lsl #16
    446c:      	cmp	w8, w9
    4470:      	b.eq	0x4450 <_ZN7android13isPossiblyYUVEi+0x2c>
    4474:      	mov	w0, #0x1
    4478:      	ret

000000000000447c <_ZN7android18isPossibly10BitYUVEi>:
    447c:      	bti	c
    4480:      	mov	w9, #0x3858
    4484:      	mov	w8, w0
    4488:      	movk	w9, #0x2020, lsl #16
    448c:      	cmp	w0, w9
    4490:      	mov	w0, wzr
    4494:      	b.gt	0x44bc <_ZN7android18isPossibly10BitYUVEi+0x40>
    4498:      	cmp	w8, #0x2c
    449c:      	b.hi	0x44ec <_ZN7android18isPossibly10BitYUVEi+0x70>
    44a0:      	mov	x9, #0x3e
    44a4:      	mov	w8, w8
    44a8:      	movk	x9, #0x2, lsl #16
    44ac:      	movk	x9, #0x187f, lsl #32
    44b0:      	lsr	x8, x9, x8
    44b4:      	tbz	w8, #0x0, 0x44ec <_ZN7android18isPossibly10BitYUVEi+0x70>
    44b8:      	ret
    44bc:      	mov	w9, #0x3859
    44c0:      	movk	w9, #0x2020, lsl #16
    44c4:      	cmp	w8, w9
    44c8:      	b.eq	0x44b8 <_ZN7android18isPossibly10BitYUVEi+0x3c>
    44cc:      	mov	w9, #0x3159
    44d0:      	movk	w9, #0x2036, lsl #16
    44d4:      	cmp	w8, w9
    44d8:      	b.eq	0x44b8 <_ZN7android18isPossibly10BitYUVEi+0x3c>
    44dc:      	mov	w9, #0x5659
    44e0:      	movk	w9, #0x3231, lsl #16
    44e4:      	cmp	w8, w9
    44e8:      	b.eq	0x44b8 <_ZN7android18isPossibly10BitYUVEi+0x3c>
    44ec:      	mov	w0, #0x1
    44f0:      	ret

00000000000044f4 <_ZN7android17Image_getBlobSizeEPNS_11CpuConsumer12LockedBufferEb>:
    44f4:      	paciasp
    44f8:      	stp	x29, x30, [sp, #-0x20]!
    44fc:      	str	x19, [sp, #0x10]
    4500:      	mov	x29, sp
    4504:      	cbz	x0, 0x457c <_ZN7android17Image_getBlobSizeEPNS_11CpuConsumer12LockedBufferEb+0x88>
    4508:      	ldr	w19, [x0, #0x8]
    450c:      	ldr	x8, [x0]
    4510:      	tbz	w1, #0x0, 0x4528 <_ZN7android17Image_getBlobSizeEPNS_11CpuConsumer12LockedBufferEb+0x34>
    4514:      	ldr	w9, [x0, #0xc]
    4518:      	ldr	w10, [x0, #0x14]
    451c:      	sub	w9, w9, #0x1
    4520:      	madd	w9, w9, w10, w19
    4524:      	lsl	w19, w9, #2
    4528:      	add	x8, x8, w19, uxtw
    452c:      	ldur	x8, [x8, #-0x8]
    4530:      	lsr	x0, x8, #32
    4534:      	sub	w8, w8, #0x100
    4538:      	cmp	x0, #0x0
    453c:      	ccmn	w8, #0x4, #0x0, ne
    4540:      	b.hi	0x456c <_ZN7android17Image_getBlobSizeEPNS_11CpuConsumer12LockedBufferEb+0x78>
    4544:      	adrp	x1, 0x1000
    4548:      	add	x1, x1, #0x256
    454c:      	adrp	x2, 0x1000
    4550:      	add	x2, x2, #0x2d5
    4554:      	adrp	x3, 0x1000
    4558:      	add	x3, x3, #0x32b
    455c:      	mov	w0, #0x5
    4560:      	mov	w4, w19
    4564:      	bl	0x59c0 <__android_log_print@plt>
    4568:      	mov	w0, w19
    456c:      	ldr	x19, [sp, #0x10]
    4570:      	ldp	x29, x30, [sp], #0x20
    4574:      	autiasp
    4578:      	ret
    457c:      	nop
    4580:      	adr	x0, #-0x2dd4
    4584:      	adrp	x1, 0x1000
    4588:      	add	x1, x1, #0x256
    458c:      	adrp	x2, 0x1000
    4590:      	add	x2, x2, #0x313
    4594:      	bl	0x59a8 <__android_log_assert@plt>

0000000000004598 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_>:
    4598:      	paciasp
    459c:      	stp	x29, x30, [sp, #-0x40]!
    45a0:      	stp	x24, x23, [sp, #0x10]
    45a4:      	stp	x22, x21, [sp, #0x20]
    45a8:      	stp	x20, x19, [sp, #0x30]
    45ac:      	mov	x29, sp
    45b0:      	cbz	x0, 0x4c60 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x6c8>
    45b4:      	cbz	x3, 0x4c7c <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x6e4>
    45b8:      	cbz	x4, 0x4c98 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x700>
    45bc:      	cbz	x5, 0x4cb4 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x71c>
    45c0:      	cbz	x6, 0x4cd0 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x738>
    45c4:      	cmp	w1, #0x3
    45c8:      	b.hs	0x4cec <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x754>
    45cc:      	ldr	w8, [x0, #0x48]
    45d0:      	cmp	w2, #0x21
    45d4:      	mov	w9, #0x3858
    45d8:      	movk	w9, #0x2020, lsl #16
    45dc:      	ccmp	w8, #0x1, #0x0, eq
    45e0:      	cset	w8, eq
    45e4:      	cmp	w2, w9
    45e8:      	mov	w9, #-0x16
    45ec:      	b.gt	0x4638 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0xa0>
    45f0:      	sub	w10, w2, #0x1
    45f4:      	cmp	w10, #0x3b
    45f8:      	b.hi	0x4bdc <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x644>
    45fc:      	nop
    4600:      	adr	x11, #-0x2caa
    4604:      	adr	x12, #0x10
    4608:      	ldrh	w13, [x11, x10, lsl #1]
    460c:      	add	x12, x12, x13, lsl #2
    4610:      	br	x12
    4614:      	bti	j
    4618:      	cbnz	w1, 0x4d08 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x770>
    461c:      	ldr	w8, [x0, #0x14]
    4620:      	ldr	w9, [x0, #0xc]
    4624:      	mov	w10, #0x4
    4628:      	ldr	x20, [x0]
    462c:      	lsl	w8, w8, #2
    4630:      	mul	w19, w8, w9
    4634:      	b	0x4a10 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x478>
    4638:      	mov	w8, #0x3859
    463c:      	movk	w8, #0x2020, lsl #16
    4640:      	cmp	w2, w8
    4644:      	b.eq	0x4918 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x380>
    4648:      	mov	w8, #0x3159
    464c:      	movk	w8, #0x2036, lsl #16
    4650:      	cmp	w2, w8
    4654:      	b.eq	0x46c8 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x130>
    4658:      	mov	w8, #0x5659
    465c:      	movk	w8, #0x3231, lsl #16
    4660:      	cmp	w2, w8
    4664:      	b.ne	0x4bdc <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x644>
    4668:      	ldr	w8, [x0, #0x8]
    466c:      	tbnz	w8, #0x0, 0x4a28 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x490>
    4670:      	ldr	w9, [x0, #0xc]
    4674:      	tbnz	w9, #0x0, 0x4a74 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x4dc>
    4678:      	cbz	w8, 0x4b80 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x5e8>
    467c:      	cbz	w9, 0x4bbc <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x624>
    4680:      	ldr	w8, [x0, #0x14]
    4684:      	tst	w8, #0xf
    4688:      	b.ne	0x4de8 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x850>
    468c:      	mul	w19, w8, w9
    4690:      	ldr	x20, [x0]
    4694:      	cbz	w1, 0x4c1c <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x684>
    4698:      	lsr	w8, w8, #1
    469c:      	add	x10, x20, w19, uxtw
    46a0:      	cmp	w1, #0x1
    46a4:      	add	w8, w8, #0x8
    46a8:      	and	w8, w8, #0xfffffff0
    46ac:      	mul	w9, w8, w9
    46b0:      	lsr	w9, w9, #1
    46b4:      	csel	w11, w9, wzr, eq
    46b8:      	mov	w19, w9
    46bc:      	add	x20, x10, x11
    46c0:      	mov	w10, #0x1
    46c4:      	b	0x4a10 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x478>
    46c8:      	bti	j
    46cc:      	cbnz	w1, 0x4d08 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x770>
    46d0:      	ldr	w8, [x0, #0x14]
    46d4:      	ldr	w9, [x0, #0xc]
    46d8:      	mov	w10, #0x2
    46dc:      	ldr	x20, [x0]
    46e0:      	lsl	w8, w8, #1
    46e4:      	mul	w19, w8, w9
    46e8:      	b	0x4a10 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x478>
    46ec:      	bti	j
    46f0:      	cbnz	w1, 0x4d08 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x770>
    46f4:      	ldr	w8, [x0, #0xc]
    46f8:      	cmp	w8, #0x1
    46fc:      	b.ne	0x4d6c <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x7d4>
    4700:      	ldr	x20, [x0]
    4704:      	ldr	w19, [x0, #0x8]
    4708:      	b	0x4a08 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x470>
    470c:      	bti	j
    4710:      	ldr	w9, [x0, #0xc]
    4714:      	tbnz	w9, #0x0, 0x4934 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x39c>
    4718:      	ldr	w10, [x0, #0x8]
    471c:      	cbz	w10, 0x4a90 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x4f8>
    4720:      	cbz	w9, 0x4b30 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x598>
    4724:      	ldr	x11, [x0, #0x50]
    4728:      	cbz	x11, 0x4ab8 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x520>
    472c:      	ldr	x12, [x0, #0x58]
    4730:      	cbz	x12, 0x4ab8 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x520>
    4734:      	cbz	w1, 0x4bfc <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x664>
    4738:      	lsr	w9, w9, #1
    473c:      	b	0x4854 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x2bc>
    4740:      	bti	j
    4744:      	cbnz	w1, 0x4d08 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x770>
    4748:      	ldr	w8, [x0, #0x8]
    474c:      	tst	w8, #0x3
    4750:      	b.ne	0x4d2c <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x794>
    4754:      	ldr	w9, [x0, #0xc]
    4758:      	tbnz	w9, #0x0, 0x4d4c <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x7b4>
    475c:      	add	w10, w8, w8, lsl #1
    4760:      	ldr	w8, [x0, #0x14]
    4764:      	ubfx	w10, w10, #1, #29
    4768:      	cmp	w8, w10
    476c:      	b.hs	0x4908 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x370>
    4770:      	adrp	x0, 0x1000
    4774:      	add	x0, x0, #0x92b
    4778:      	b	0x4d94 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x7fc>
    477c:      	bti	j
    4780:      	ldr	w9, [x0, #0x8]
    4784:      	tbnz	w9, #0x0, 0x4948 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x3b0>
    4788:      	ldr	w10, [x0, #0xc]
    478c:      	tbnz	w10, #0x0, 0x4a44 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x4ac>
    4790:      	cbz	w9, 0x4b58 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x5c0>
    4794:      	cbz	w10, 0x4b94 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x5fc>
    4798:      	cbz	w1, 0x4c24 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x68c>
    479c:      	cmp	w1, #0x1
    47a0:      	b.ne	0x4c34 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x69c>
    47a4:      	mov	w11, #0x50
    47a8:      	b	0x4c38 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x6a0>
    47ac:      	bti	j
    47b0:      	cbnz	w1, 0x4d08 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x770>
    47b4:      	ldr	w9, [x0, #0xc]
    47b8:      	cbz	w8, 0x4984 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x3ec>
    47bc:      	ldr	w8, [x0, #0x8]
    47c0:      	cmp	w9, w8
    47c4:      	b.ne	0x4db0 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x818>
    47c8:      	ldr	w8, [x0, #0x14]
    47cc:      	sub	w10, w9, #0x1
    47d0:      	madd	w8, w8, w10, w9
    47d4:      	lsl	w19, w8, #2
    47d8:      	b	0x4990 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x3f8>
    47dc:      	bti	j
    47e0:      	ldr	w8, [x0, #0x8]
    47e4:      	tbnz	w8, #0x0, 0x495c <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x3c4>
    47e8:      	ldr	w9, [x0, #0xc]
    47ec:      	tbnz	w9, #0x0, 0x4a60 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x4c8>
    47f0:      	cbz	w8, 0x4b6c <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x5d4>
    47f4:      	cbz	w9, 0x4ba8 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x610>
    47f8:      	ldr	x20, [x0]
    47fc:      	cbz	w1, 0x4c18 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x680>
    4800:      	ldr	w10, [x0, #0x14]
    4804:      	lsr	w11, w9, #1
    4808:      	cmp	w1, #0x1
    480c:      	mul	w9, w10, w9
    4810:      	mov	w10, #-0x1
    4814:      	madd	w19, w11, w8, w10
    4818:      	mov	w10, #0x2
    481c:      	add	x9, x20, x9
    4820:      	cinc	x20, x9, eq
    4824:      	b	0x4a10 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x478>
    4828:      	bti	j
    482c:      	ldr	w9, [x0, #0xc]
    4830:      	tbnz	w9, #0x0, 0x4970 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x3d8>
    4834:      	ldr	w10, [x0, #0x8]
    4838:      	cbz	w10, 0x4aa4 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x50c>
    483c:      	cbz	w9, 0x4b44 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x5ac>
    4840:      	ldr	x11, [x0, #0x50]
    4844:      	cbz	x11, 0x4af8 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x560>
    4848:      	ldr	x12, [x0, #0x58]
    484c:      	cbz	x12, 0x4af8 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x560>
    4850:      	cbz	w1, 0x4bfc <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x664>
    4854:      	lsr	w13, w10, #1
    4858:      	sub	w9, w9, #0x1
    485c:      	cmp	w1, #0x1
    4860:      	ldp	w8, w10, [x0, #0x60]
    4864:      	csel	x20, x11, x12, eq
    4868:      	mul	w13, w10, w13
    486c:      	madd	w19, w8, w9, w13
    4870:      	b	0x4a10 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x478>
    4874:      	bti	j
    4878:      	cbnz	w1, 0x4d08 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x770>
    487c:      	ldr	w8, [x0, #0x14]
    4880:      	ldr	w9, [x0, #0xc]
    4884:      	mov	w10, #0x3
    4888:      	ldr	x20, [x0]
    488c:      	add	w8, w8, w8, lsl #1
    4890:      	mul	w19, w8, w9
    4894:      	b	0x4a10 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x478>
    4898:      	bti	j
    489c:      	cbnz	w1, 0x4d08 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x770>
    48a0:      	ldr	w8, [x0, #0x8]
    48a4:      	tst	w8, #0x3
    48a8:      	b.ne	0x4d2c <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x794>
    48ac:      	ldr	w9, [x0, #0xc]
    48b0:      	tbnz	w9, #0x0, 0x4d4c <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x7b4>
    48b4:      	lsl	w10, w8, #4
    48b8:      	sub	w10, w10, w8, lsl #1
    48bc:      	ldr	w8, [x0, #0x14]
    48c0:      	lsr	w10, w10, #3
    48c4:      	cmp	w8, w10
    48c8:      	b.hs	0x4908 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x370>
    48cc:      	adrp	x0, 0x1000
    48d0:      	add	x0, x0, #0x6c0
    48d4:      	b	0x4d94 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x7fc>
    48d8:      	bti	j
    48dc:      	cbnz	w1, 0x4d08 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x770>
    48e0:      	ldr	w8, [x0, #0x8]
    48e4:      	tst	w8, #0x3
    48e8:      	b.ne	0x4d2c <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x794>
    48ec:      	ldr	w9, [x0, #0xc]
    48f0:      	tbnz	w9, #0x0, 0x4d4c <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x7b4>
    48f4:      	add	w10, w8, w8, lsl #2
    48f8:      	ldr	w8, [x0, #0x14]
    48fc:      	ubfx	w10, w10, #2, #29
    4900:      	cmp	w8, w10
    4904:      	b.lo	0x4d8c <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x7f4>
    4908:      	ldr	x20, [x0]
    490c:      	mul	w19, w8, w9
    4910:      	mov	w10, wzr
    4914:      	b	0x4a10 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x478>
    4918:      	cbnz	w1, 0x4d08 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x770>
    491c:      	ldr	w8, [x0, #0x14]
    4920:      	ldr	w9, [x0, #0xc]
    4924:      	mul	w19, w9, w8
    4928:      	ldr	x20, [x0]
    492c:      	mov	w10, #0x1
    4930:      	b	0x4a10 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x478>
    4934:      	adrp	x1, 0x1000
    4938:      	add	x1, x1, #0x256
    493c:      	adrp	x2, 0x1000
    4940:      	add	x2, x2, #0x476
    4944:      	b	0x4a84 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x4ec>
    4948:      	adrp	x1, 0x1000
    494c:      	add	x1, x1, #0x256
    4950:      	adrp	x2, 0x1000
    4954:      	add	x2, x2, #0x33d
    4958:      	b	0x4a84 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x4ec>
    495c:      	adrp	x1, 0x1000
    4960:      	add	x1, x1, #0x256
    4964:      	adrp	x2, 0x1000
    4968:      	add	x2, x2, #0x278
    496c:      	b	0x4a38 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x4a0>
    4970:      	adrp	x1, 0x1000
    4974:      	add	x1, x1, #0x256
    4978:      	adrp	x2, 0x1000
    497c:      	add	x2, x2, #0x1f0
    4980:      	b	0x4a84 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x4ec>
    4984:      	cmp	w9, #0x1
    4988:      	b.ne	0x4dcc <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x834>
    498c:      	ldr	w19, [x0, #0x8]
    4990:      	ldr	x20, [x0]
    4994:      	add	x8, x20, w19, uxtw
    4998:      	ldur	x8, [x8, #-0x8]
    499c:      	lsr	x9, x8, #32
    49a0:      	cbz	x9, 0x49c0 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x428>
    49a4:      	sub	w8, w8, #0x100
    49a8:      	cmn	w8, #0x4
    49ac:      	b.ls	0x49c0 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x428>
    49b0:      	mov	w10, wzr
    49b4:      	mov	w8, wzr
    49b8:      	mov	w19, w9
    49bc:      	b	0x4a10 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x478>
    49c0:      	adrp	x8, 0x1000
    49c4:      	add	x8, x8, #0x32b
    49c8:      	adrp	x1, 0x1000
    49cc:      	add	x1, x1, #0x256
    49d0:      	adrp	x2, 0x1000
    49d4:      	add	x2, x2, #0x2d5
    49d8:      	mov	w0, #0x5
    49dc:      	mov	x21, x3
    49e0:      	mov	x3, x8
    49e4:      	mov	x22, x4
    49e8:      	mov	w4, w19
    49ec:      	mov	x23, x6
    49f0:      	mov	x24, x5
    49f4:      	bl	0x59c0 <__android_log_print@plt>
    49f8:      	mov	x3, x21
    49fc:      	mov	x4, x22
    4a00:      	mov	x5, x24
    4a04:      	mov	x6, x23
    4a08:      	mov	w10, wzr
    4a0c:      	mov	w8, wzr
    4a10:      	mov	w9, wzr
    4a14:      	str	x20, [x3]
    4a18:      	str	w19, [x4]
    4a1c:      	str	w10, [x5]
    4a20:      	str	w8, [x6]
    4a24:      	b	0x4bdc <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x644>
    4a28:      	adrp	x1, 0x1000
    4a2c:      	add	x1, x1, #0x256
    4a30:      	adrp	x2, 0x1000
    4a34:      	add	x2, x2, #0x371
    4a38:      	mov	w0, #0x6
    4a3c:      	mov	w3, w8
    4a40:      	b	0x4bd4 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x63c>
    4a44:      	adrp	x1, 0x1000
    4a48:      	add	x1, x1, #0x256
    4a4c:      	adrp	x2, 0x1000
    4a50:      	add	x2, x2, #0x63e
    4a54:      	mov	w0, #0x6
    4a58:      	mov	w3, w10
    4a5c:      	b	0x4bd4 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x63c>
    4a60:      	adrp	x1, 0x1000
    4a64:      	add	x1, x1, #0x256
    4a68:      	adrp	x2, 0x1000
    4a6c:      	add	x2, x2, #0x222
    4a70:      	b	0x4a84 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x4ec>
    4a74:      	adrp	x1, 0x1000
    4a78:      	add	x1, x1, #0x256
    4a7c:      	adrp	x2, 0x1000
    4a80:      	add	x2, x2, #0x4f9
    4a84:      	mov	w0, #0x6
    4a88:      	mov	w3, w9
    4a8c:      	b	0x4bd4 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x63c>
    4a90:      	adrp	x1, 0x1000
    4a94:      	add	x1, x1, #0x256
    4a98:      	adrp	x2, 0x1000
    4a9c:      	add	x2, x2, #0x4a8
    4aa0:      	b	0x4bcc <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x634>
    4aa4:      	adrp	x1, 0x1000
    4aa8:      	add	x1, x1, #0x256
    4aac:      	adrp	x2, 0x1000
    4ab0:      	add	x2, x2, #0x7bb
    4ab4:      	b	0x4bcc <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x634>
    4ab8:      	ldr	w8, [x0, #0x14]
    4abc:      	cmp	w1, #0x1
    4ac0:      	mov	w10, #0x2
    4ac4:      	ldr	x11, [x0]
    4ac8:      	csel	x12, xzr, x10, eq
    4acc:      	cmp	w1, #0x0
    4ad0:      	lsl	w8, w8, #1
    4ad4:      	cset	w13, ne
    4ad8:      	mov	w14, #0x4
    4adc:      	add	x12, x11, x12
    4ae0:      	csel	w10, w14, w10, ne
    4ae4:      	mul	w9, w8, w9
    4ae8:      	add	x12, x12, x9
    4aec:      	lsr	w19, w9, w13
    4af0:      	csel	x20, x12, x11, ne
    4af4:      	b	0x4a10 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x478>
    4af8:      	ldr	w8, [x0, #0x14]
    4afc:      	cmp	w1, #0x1
    4b00:      	ldr	x11, [x0]
    4b04:      	mov	w12, #0x4
    4b08:      	lsl	w8, w8, #1
    4b0c:      	mul	w19, w8, w9
    4b10:      	mov	w9, #0x2
    4b14:      	csel	x10, xzr, x9, eq
    4b18:      	cmp	w1, #0x0
    4b1c:      	add	x10, x11, x10
    4b20:      	add	x13, x10, x19
    4b24:      	csel	w10, w9, w12, eq
    4b28:      	csel	x20, x11, x13, eq
    4b2c:      	b	0x4a10 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x478>
    4b30:      	adrp	x1, 0x1000
    4b34:      	add	x1, x1, #0x256
    4b38:      	adrp	x2, 0x1000
    4b3c:      	add	x2, x2, #0x734
    4b40:      	b	0x4bcc <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x634>
    4b44:      	adrp	x1, 0x1000
    4b48:      	add	x1, x1, #0x256
    4b4c:      	adrp	x2, 0x1000
    4b50:      	add	x2, x2, #0x3b8
    4b54:      	b	0x4bcc <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x634>
    4b58:      	adrp	x1, 0x1000
    4b5c:      	add	x1, x1, #0x256
    4b60:      	adrp	x2, 0x1000
    4b64:      	add	x2, x2, #0x3df
    4b68:      	b	0x4bcc <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x634>
    4b6c:      	adrp	x1, 0x1000
    4b70:      	add	x1, x1, #0x256
    4b74:      	adrp	x2, 0x1000
    4b78:      	add	x2, x2, #0x6ea
    4b7c:      	b	0x4bcc <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x634>
    4b80:      	adrp	x1, 0x1000
    4b84:      	add	x1, x1, #0x256
    4b88:      	adrp	x2, 0x1000
    4b8c:      	add	x2, x2, #0x713
    4b90:      	b	0x4bcc <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x634>
    4b94:      	adrp	x1, 0x1000
    4b98:      	add	x1, x1, #0x256
    4b9c:      	adrp	x2, 0x1000
    4ba0:      	add	x2, x2, #0x673
    4ba4:      	b	0x4bcc <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x634>
    4ba8:      	adrp	x1, 0x1000
    4bac:      	add	x1, x1, #0x256
    4bb0:      	adrp	x2, 0x1000
    4bb4:      	add	x2, x2, #0x2ab
    4bb8:      	b	0x4bcc <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x634>
    4bbc:      	adrp	x1, 0x1000
    4bc0:      	add	x1, x1, #0x256
    4bc4:      	adrp	x2, 0x1000
    4bc8:      	add	x2, x2, #0x69e
    4bcc:      	mov	w0, #0x6
    4bd0:      	mov	w3, wzr
    4bd4:      	bl	0x59c0 <__android_log_print@plt>
    4bd8:      	mov	w9, #-0x16
    4bdc:      	bti	j
    4be0:      	mov	w0, w9
    4be4:      	ldp	x20, x19, [sp, #0x30]
    4be8:      	ldp	x22, x21, [sp, #0x20]
    4bec:      	ldp	x24, x23, [sp, #0x10]
    4bf0:      	ldp	x29, x30, [sp], #0x40
    4bf4:      	autiasp
    4bf8:      	ret
    4bfc:      	ldr	w8, [x0, #0x14]
    4c00:      	sub	w9, w9, #0x1
    4c04:      	ldr	x20, [x0]
    4c08:      	mul	w9, w8, w9
    4c0c:      	add	w19, w9, w10, lsl #1
    4c10:      	mov	w10, #0x2
    4c14:      	b	0x4a10 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x478>
    4c18:      	mul	w19, w9, w8
    4c1c:      	mov	w10, #0x1
    4c20:      	b	0x4a10 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x478>
    4c24:      	ldr	w8, [x0, #0x14]
    4c28:      	sub	w10, w10, #0x1
    4c2c:      	madd	w19, w8, w10, w9
    4c30:      	b	0x4928 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x390>
    4c34:      	mov	w11, #0x58
    4c38:      	lsr	w12, w10, #1
    4c3c:      	lsr	w9, w9, #1
    4c40:      	ldr	x20, [x0, x11]
    4c44:      	ldp	w8, w10, [x0, #0x60]
    4c48:      	sub	w12, w12, #0x1
    4c4c:      	sub	w9, w9, #0x1
    4c50:      	mul	w12, w8, w12
    4c54:      	madd	w9, w10, w9, w12
    4c58:      	add	w19, w9, #0x1
    4c5c:      	b	0x4a10 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x478>
    4c60:      	nop
    4c64:      	adr	x0, #-0x34b8
    4c68:      	adrp	x1, 0x1000
    4c6c:      	add	x1, x1, #0x256
    4c70:      	adrp	x2, 0x1000
    4c74:      	add	x2, x2, #0x313
    4c78:      	bl	0x59a8 <__android_log_assert@plt>
    4c7c:      	adrp	x0, 0x1000
    4c80:      	add	x0, x0, #0x8df
    4c84:      	adrp	x1, 0x1000
    4c88:      	add	x1, x1, #0x256
    4c8c:      	adrp	x2, 0x1000
    4c90:      	add	x2, x2, #0x5dc
    4c94:      	bl	0x59a8 <__android_log_assert@plt>
    4c98:      	adrp	x0, 0x1000
    4c9c:      	add	x0, x0, #0x84d
    4ca0:      	adrp	x1, 0x1000
    4ca4:      	add	x1, x1, #0x256
    4ca8:      	adrp	x2, 0x1000
    4cac:      	add	x2, x2, #0x466
    4cb0:      	bl	0x59a8 <__android_log_assert@plt>
    4cb4:      	adrp	x0, 0x1000
    4cb8:      	add	x0, x0, #0x7e2
    4cbc:      	adrp	x1, 0x1000
    4cc0:      	add	x1, x1, #0x256
    4cc4:      	adrp	x2, 0x1000
    4cc8:      	add	x2, x2, #0x7f6
    4ccc:      	bl	0x59a8 <__android_log_assert@plt>
    4cd0:      	adrp	x0, 0x1000
    4cd4:      	add	x0, x0, #0x80d
    4cd8:      	adrp	x1, 0x1000
    4cdc:      	add	x1, x1, #0x256
    4ce0:      	adrp	x2, 0x1000
    4ce4:      	add	x2, x2, #0x85a
    4ce8:      	bl	0x59a8 <__android_log_assert@plt>
    4cec:      	adrp	x0, 0x1000
    4cf0:      	add	x0, x0, #0x8ec
    4cf4:      	adrp	x8, 0x1000
    4cf8:      	add	x8, x8, #0x256
    4cfc:      	adrp	x2, 0x1000
    4d00:      	add	x2, x2, #0x539
    4d04:      	b	0x4d20 <_ZN7android18getLockedImageInfoEPNS_11CpuConsumer12LockedBufferEiiPPhPjPiS6_+0x788>
    4d08:      	adrp	x0, 0x1000
    4d0c:      	add	x0, x0, #0x86f
    4d10:      	adrp	x8, 0x1000
    4d14:      	add	x8, x8, #0x256
    4d18:      	adrp	x2, 0x1000
    4d1c:      	add	x2, x2, #0x268
    4d20:      	mov	w3, w1
    4d24:      	mov	x1, x8
    4d28:      	bl	0x59a8 <__android_log_assert@plt>
    4d2c:      	adrp	x0, 0x1000
    4d30:      	add	x0, x0, #0x436
    4d34:      	adrp	x1, 0x1000
    4d38:      	add	x1, x1, #0x256
    4d3c:      	adrp	x2, 0x1000
    4d40:      	add	x2, x2, #0x448
    4d44:      	mov	w3, w8
    4d48:      	bl	0x59a8 <__android_log_assert@plt>
    4d4c:      	adrp	x0, 0x1000
    4d50:      	add	x0, x0, #0x8cc
    4d54:      	adrp	x1, 0x1000
    4d58:      	add	x1, x1, #0x256
    4d5c:      	adrp	x2, 0x1000
    4d60:      	add	x2, x2, #0x770
    4d64:      	mov	w3, w9
    4d68:      	bl	0x59a8 <__android_log_assert@plt>
    4d6c:      	adrp	x0, 0x1000
    4d70:      	add	x0, x0, #0x917
    4d74:      	adrp	x1, 0x1000
    4d78:      	add	x1, x1, #0x256
    4d7c:      	adrp	x2, 0x1000
    4d80:      	add	x2, x2, #0x54d
    4d84:      	mov	w3, w8
    4d88:      	bl	0x59a8 <__android_log_assert@plt>
    4d8c:      	adrp	x0, 0x1000
    4d90:      	add	x0, x0, #0x4cf
    4d94:      	adrp	x1, 0x1000
    4d98:      	add	x1, x1, #0x256
    4d9c:      	adrp	x2, 0x1000
    4da0:      	add	x2, x2, #0x61c
    4da4:      	mov	w3, w8
    4da8:      	mov	w4, w10
    4dac:      	bl	0x59a8 <__android_log_assert@plt>
    4db0:      	adrp	x0, 0x1000
    4db4:      	add	x0, x0, #0x878
    4db8:      	adrp	x1, 0x1000
    4dbc:      	add	x1, x1, #0x256
    4dc0:      	adrp	x2, 0x1000
    4dc4:      	add	x2, x2, #0x580
    4dc8:      	bl	0x59a8 <__android_log_assert@plt>
    4dcc:      	adrp	x0, 0x1000
    4dd0:      	add	x0, x0, #0x917
    4dd4:      	adrp	x1, 0x1000
    4dd8:      	add	x1, x1, #0x256
    4ddc:      	adrp	x2, 0x1000
    4de0:      	add	x2, x2, #0x81f
    4de4:      	bl	0x59a8 <__android_log_assert@plt>
    4de8:      	adrp	x0, 0x1000
    4dec:      	add	x0, x0, #0x39c
    4df0:      	adrp	x1, 0x1000
    4df4:      	add	x1, x1, #0x256
    4df8:      	adrp	x2, 0x1000
    4dfc:      	add	x2, x2, #0x409
    4e00:      	mov	w3, w8
    4e04:      	bl	0x59a8 <__android_log_assert@plt>

0000000000004e08 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE>:
    4e08:      	paciasp
    4e0c:      	sub	sp, sp, #0xd0
    4e10:      	stp	x29, x30, [sp, #0x80]
    4e14:      	stp	x26, x25, [sp, #0x90]
    4e18:      	stp	x24, x23, [sp, #0xa0]
    4e1c:      	stp	x22, x21, [sp, #0xb0]
    4e20:      	stp	x20, x19, [sp, #0xc0]
    4e24:      	add	x29, sp, #0x80
    4e28:      	mrs	x21, TPIDR_EL0
    4e2c:      	ldr	x9, [x21, #0x28]
    4e30:      	stur	x9, [x29, #-0x8]
    4e34:      	cbz	x4, 0x4e64 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x5c>
    4e38:      	mov	x8, x0
    4e3c:      	ldr	x0, [x0]
    4e40:      	cbz	x0, 0x4e64 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x5c>
    4e44:      	ldr	w19, [x0, #0x54]
    4e48:      	cmp	w19, #0x22
    4e4c:      	b.ne	0x4eb0 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0xa8>
    4e50:      	adrp	x1, 0x1000
    4e54:      	add	x1, x1, #0x256
    4e58:      	adrp	x2, 0x1000
    4e5c:      	add	x2, x2, #0x786
    4e60:      	b	0x4e74 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x6c>
    4e64:      	adrp	x1, 0x1000
    4e68:      	add	x1, x1, #0x256
    4e6c:      	adrp	x2, 0x1000
    4e70:      	add	x2, x2, #0x5ec
    4e74:      	mov	w0, #0x6
    4e78:      	bl	0x59c0 <__android_log_print@plt>
    4e7c:      	mov	w0, #-0x16
    4e80:      	ldr	x8, [x21, #0x28]
    4e84:      	ldur	x9, [x29, #-0x8]
    4e88:      	cmp	x8, x9
    4e8c:      	b.ne	0x50bc <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x2b4>
    4e90:      	ldp	x20, x19, [sp, #0xc0]
    4e94:      	ldp	x22, x21, [sp, #0xb0]
    4e98:      	ldp	x24, x23, [sp, #0xa0]
    4e9c:      	ldp	x26, x25, [sp, #0x90]
    4ea0:      	ldp	x29, x30, [sp, #0x80]
    4ea4:      	add	sp, sp, #0xd0
    4ea8:      	autiasp
    4eac:      	ret
    4eb0:      	movi	v0.2d, #0000000000000000
    4eb4:      	cmp	w19, #0x3c
    4eb8:      	mov	x23, x4
    4ebc:      	mov	x22, x8
    4ec0:      	str	xzr, [sp, #0x18]
    4ec4:      	stp	q0, q0, [sp, #0x30]
    4ec8:      	stp	q0, q0, [sp, #0x50]
    4ecc:      	str	q0, [sp, #0x20]
    4ed0:      	b.hi	0x4f88 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x180>
    4ed4:      	mov	x8, #0x3e
    4ed8:      	movk	x8, #0x1873, lsl #32
    4edc:      	movk	x8, #0x1040, lsl #48
    4ee0:      	lsr	x8, x8, x19
    4ee4:      	tbz	w8, #0x0, 0x4f88 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x180>
    4ee8:      	mov	w20, w3
    4eec:      	mov	w24, w19
    4ef0:      	add	x3, sp, #0x18
    4ef4:      	mov	w4, w20
    4ef8:      	mov	x5, xzr
    4efc:      	mov	x6, xzr
    4f00:      	bl	0x59f0 <_ZN7android13GraphicBuffer9lockAsyncEjRKNS_4RectEPPviPiS6_@plt>
    4f04:      	cbz	w0, 0x4f2c <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x124>
    4f08:      	adrp	x1, 0x1000
    4f0c:      	add	x1, x1, #0x256
    4f10:      	adrp	x2, 0x1000
    4f14:      	add	x2, x2, #0x75c
    4f18:      	mov	w19, w0
    4f1c:      	mov	w0, #0x6
    4f20:      	bl	0x59c0 <__android_log_print@plt>
    4f24:      	mov	w0, w19
    4f28:      	b	0x4e80 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x78>
    4f2c:      	mov	w0, w19
    4f30:      	bl	0x5978 <_ZN7android18isPossibly10BitYUVEi@plt>
    4f34:      	tbz	w0, #0x0, 0x4ff4 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x1ec>
    4f38:      	cmp	w19, #0x3c
    4f3c:      	mov	x2, x23
    4f40:      	mov	x8, x22
    4f44:      	b.eq	0x5000 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x1f8>
    4f48:      	cmp	w19, #0x36
    4f4c:      	b.ne	0x5048 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x240>
    4f50:      	ldr	x0, [x8]
    4f54:      	str	x0, [sp, #0x10]
    4f58:      	cbz	x0, 0x4f68 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x160>
    4f5c:      	add	x1, sp, #0x10
    4f60:      	bl	0x5af8 <_ZNK7android7RefBase9incStrongEPKv@plt>
    4f64:      	mov	x2, x23
    4f68:      	ldr	x1, [sp, #0x18]
    4f6c:      	add	x0, sp, #0x10
    4f70:      	bl	0x50c0 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x2b8>
    4f74:      	ldr	x8, [sp, #0x10]
    4f78:      	mov	w20, w0
    4f7c:      	cbz	x8, 0x503c <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x234>
    4f80:      	add	x1, sp, #0x10
    4f84:      	b	0x5034 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x22c>
    4f88:      	mov	w8, #0x3859
    4f8c:      	movk	w8, #0x2020, lsl #16
    4f90:      	cmp	w19, w8
    4f94:      	b.eq	0x4ee8 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0xe0>
    4f98:      	mov	w8, #0x3159
    4f9c:      	mov	w20, w3
    4fa0:      	movk	w8, #0x2036, lsl #16
    4fa4:      	cmp	w19, w8
    4fa8:      	b.eq	0x4eec <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0xe4>
    4fac:      	add	x3, sp, #0x20
    4fb0:      	mov	w4, w20
    4fb4:      	mov	w25, w1
    4fb8:      	mov	x26, x2
    4fbc:      	bl	0x59d8 <_ZN7android13GraphicBuffer14lockAsyncYCbCrEjRKNS_4RectEP13android_ycbcri@plt>
    4fc0:      	cbz	w0, 0x4fe4 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x1dc>
    4fc4:      	mov	w3, w0
    4fc8:      	adrp	x1, 0x1000
    4fcc:      	add	x1, x1, #0x256
    4fd0:      	adrp	x2, 0x1000
    4fd4:      	add	x2, x2, #0x898
    4fd8:      	mov	w0, #0x5
    4fdc:      	mov	w4, w19
    4fe0:      	bl	0x59c0 <__android_log_print@plt>
    4fe4:      	ldr	x8, [sp, #0x20]
    4fe8:      	str	x8, [sp, #0x18]
    4fec:      	cbz	x8, 0x50a8 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x2a0>
    4ff0:      	mov	w24, #0x23
    4ff4:      	mov	x2, x23
    4ff8:      	mov	x8, x22
    4ffc:      	b	0x5048 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x240>
    5000:      	ldr	x0, [x8]
    5004:      	str	x0, [sp, #0x8]
    5008:      	cbz	x0, 0x5018 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x210>
    500c:      	add	x1, sp, #0x8
    5010:      	bl	0x5af8 <_ZNK7android7RefBase9incStrongEPKv@plt>
    5014:      	mov	x2, x23
    5018:      	ldr	x1, [sp, #0x18]
    501c:      	add	x0, sp, #0x8
    5020:      	bl	0x52e4 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x4dc>
    5024:      	ldr	x8, [sp, #0x8]
    5028:      	mov	w20, w0
    502c:      	cbz	x8, 0x503c <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x234>
    5030:      	add	x1, sp, #0x8
    5034:      	mov	x0, x8
    5038:      	bl	0x5ae0 <_ZNK7android7RefBase9decStrongEPKv@plt>
    503c:      	mov	x2, x23
    5040:      	mov	x8, x22
    5044:      	cbz	w20, 0x50a0 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x298>
    5048:      	ldp	x9, x10, [sp, #0x18]
    504c:      	str	x9, [x2]
    5050:      	ldr	x9, [x8]
    5054:      	ldr	w9, [x9, #0x48]
    5058:      	str	w9, [x2, #0x8]
    505c:      	ldr	x9, [x8]
    5060:      	ldr	w9, [x9, #0x4c]
    5064:      	str	w24, [x2, #0x48]
    5068:      	stp	w9, w19, [x2, #0xc]
    506c:      	cbz	x10, 0x5078 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x270>
    5070:      	ldr	w8, [sp, #0x38]
    5074:      	b	0x5080 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x278>
    5078:      	ldr	x8, [x8]
    507c:      	ldr	w8, [x8, #0x50]
    5080:      	ldr	q0, [sp, #0x40]
    5084:      	ldur	q1, [sp, #0x28]
    5088:      	mov	w0, wzr
    508c:      	str	w8, [x2, #0x14]
    5090:      	xtn	v0.2s, v0.2d
    5094:      	str	q1, [x2, #0x50]
    5098:      	str	d0, [x2, #0x60]
    509c:      	b	0x4e80 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x78>
    50a0:      	mov	w0, wzr
    50a4:      	b	0x4e80 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x78>
    50a8:      	ldr	x0, [x22]
    50ac:      	mov	w24, #0x23
    50b0:      	mov	x2, x26
    50b4:      	mov	w1, w25
    50b8:      	b	0x4ef0 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0xe8>
    50bc:      	bl	0x5b58 <__stack_chk_fail@plt>
    50c0:      	paciasp
    50c4:      	sub	sp, sp, #0x70
    50c8:      	stp	x29, x30, [sp, #0x30]
    50cc:      	stp	x24, x23, [sp, #0x40]
    50d0:      	stp	x22, x21, [sp, #0x50]
    50d4:      	stp	x20, x19, [sp, #0x60]
    50d8:      	add	x29, sp, #0x30
    50dc:      	mrs	x23, TPIDR_EL0
    50e0:      	mov	x20, x0
    50e4:      	adrp	x0, 0x8000
    50e8:      	ldr	x8, [x23, #0x28]
    50ec:      	mov	x19, x2
    50f0:      	mov	x21, x1
    50f4:      	stur	x8, [x29, #-0x8]
    50f8:      	ldr	x0, [x0, #0x248]
    50fc:      	bl	0x5a98 <pthread_mutex_lock@plt>
    5100:      	adrp	x24, 0x8000
    5104:      	ldr	x24, [x24, #0x250]
    5108:      	ldr	x22, [x24]
    510c:      	cbnz	x22, 0x5124 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x31c>
    5110:      	mov	w0, #0x10
    5114:      	bl	0x5a68 <_Znwm@plt>
    5118:      	mov	x22, x0
    511c:      	bl	0x5a80 <_ZN7android19GraphicBufferMapperC1Ev@plt>
    5120:      	str	x22, [x24]
    5124:      	adrp	x0, 0x8000
    5128:      	ldr	x0, [x0, #0x248]
    512c:      	bl	0x5ab0 <pthread_mutex_unlock@plt>
    5130:      	ldr	x8, [x20]
    5134:      	add	x2, sp, #0x8
    5138:      	mov	x0, x22
    513c:      	stp	xzr, xzr, [sp, #0x8]
    5140:      	add	x24, sp, #0x8
    5144:      	ldr	x1, [x8, #0x70]
    5148:      	str	xzr, [sp, #0x18]
    514c:      	bl	0x5a50 <_ZN7android19GraphicBufferMapper15getPlaneLayoutsEPK13native_handlePNSt3__16vectorIN4aidl7android8hardware8graphics6common11PlaneLayoutENS4_9allocatorISB_EEEE@plt>
    5150:      	mov	w22, w0
    5154:      	cbnz	w0, 0x52a4 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x49c>
    5158:      	ldp	x8, x9, [sp, #0x8]
    515c:      	cmp	x8, x9
    5160:      	b.eq	0x5258 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x450>
    5164:      	mov	x11, xzr
    5168:      	mov	w12, wzr
    516c:      	mov	w10, wzr
    5170:      	mov	x14, xzr
    5174:      	mov	x13, xzr
    5178:      	ldp	x15, x16, [x8]
    517c:      	cmp	x15, x16
    5180:      	b.eq	0x5250 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x448>
    5184:      	mov	x17, xzr
    5188:      	mov	x0, x15
    518c:      	ldr	x1, [x0, #0x28]
    5190:      	cmp	x1, #0xa
    5194:      	b.ne	0x5250 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x448>
    5198:      	ldr	x1, [x0, #0x18]
    519c:      	add	x0, x0, #0x30
    51a0:      	cmp	x0, x16
    51a4:      	orr	x17, x1, x17
    51a8:      	b.ne	0x518c <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x384>
    51ac:      	cmp	x17, #0x6
    51b0:      	b.eq	0x51e4 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x3dc>
    51b4:      	cmp	x17, #0x1
    51b8:      	b.ne	0x5250 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x448>
    51bc:      	ldr	x10, [x8, #0x20]
    51c0:      	cmp	x10, #0x10
    51c4:      	b.ne	0x5250 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x448>
    51c8:      	ldr	x10, [x15, #0x20]
    51cc:      	cmp	x10, #0x6
    51d0:      	b.ne	0x5250 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x448>
    51d4:      	ldr	x11, [x8, #0x18]
    51d8:      	ldr	w10, [x8, #0x28]
    51dc:      	add	x11, x21, x11
    51e0:      	b	0x5240 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x438>
    51e4:      	ldr	x12, [x8, #0x20]
    51e8:      	cmp	x12, #0x20
    51ec:      	b.eq	0x520c <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x404>
    51f0:      	b	0x5250 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x448>
    51f4:      	ldr	x12, [x15, #0x20]
    51f8:      	cmp	x12, #0x16
    51fc:      	b.ne	0x5250 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x448>
    5200:      	add	x15, x15, #0x30
    5204:      	cmp	x15, x16
    5208:      	b.eq	0x5230 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x428>
    520c:      	ldr	x12, [x15, #0x18]
    5210:      	cmp	x12, #0x4
    5214:      	b.eq	0x51f4 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x3ec>
    5218:      	cmp	x12, #0x2
    521c:      	b.ne	0x5200 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x3f8>
    5220:      	ldr	x12, [x15, #0x20]
    5224:      	cmp	x12, #0x6
    5228:      	b.eq	0x5200 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x3f8>
    522c:      	b	0x5250 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x448>
    5230:      	ldr	x12, [x8, #0x18]
    5234:      	add	x13, x21, x12
    5238:      	ldr	w12, [x8, #0x28]
    523c:      	add	x14, x13, #0x2
    5240:      	add	x8, x8, #0x58
    5244:      	cmp	x8, x9
    5248:      	b.ne	0x5178 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x370>
    524c:      	b	0x526c <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x464>
    5250:      	mov	w22, #-0x16
    5254:      	b	0x52a4 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x49c>
    5258:      	mov	x13, xzr
    525c:      	mov	x14, xzr
    5260:      	mov	w10, wzr
    5264:      	mov	w12, wzr
    5268:      	mov	x11, xzr
    526c:      	str	x11, [x19]
    5270:      	mov	w22, wzr
    5274:      	mov	w9, #0x36
    5278:      	ldr	x8, [x20]
    527c:      	ldr	w8, [x8, #0x48]
    5280:      	str	w8, [x19, #0x8]
    5284:      	ldr	x8, [x20]
    5288:      	ldr	w8, [x8, #0x4c]
    528c:      	str	w9, [x19, #0x48]
    5290:      	stp	x13, x14, [x19, #0x50]
    5294:      	str	w8, [x19, #0xc]
    5298:      	mov	w8, #0x4
    529c:      	stp	w9, w10, [x19, #0x10]
    52a0:      	stp	w12, w8, [x19, #0x60]
    52a4:      	sub	x0, x29, #0x10
    52a8:      	stur	x24, [x29, #-0x10]
    52ac:      	bl	0x5844 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x184>
    52b0:      	ldr	x8, [x23, #0x28]
    52b4:      	ldur	x9, [x29, #-0x8]
    52b8:      	cmp	x8, x9
    52bc:      	b.ne	0x52e0 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x4d8>
    52c0:      	mov	w0, w22
    52c4:      	ldp	x20, x19, [sp, #0x60]
    52c8:      	ldp	x22, x21, [sp, #0x50]
    52cc:      	ldp	x24, x23, [sp, #0x40]
    52d0:      	ldp	x29, x30, [sp, #0x30]
    52d4:      	add	sp, sp, #0x70
    52d8:      	autiasp
    52dc:      	ret
    52e0:      	bl	0x5b58 <__stack_chk_fail@plt>
    52e4:      	paciasp
    52e8:      	sub	sp, sp, #0x70
    52ec:      	stp	x29, x30, [sp, #0x30]
    52f0:      	stp	x24, x23, [sp, #0x40]
    52f4:      	stp	x22, x21, [sp, #0x50]
    52f8:      	stp	x20, x19, [sp, #0x60]
    52fc:      	add	x29, sp, #0x30
    5300:      	mrs	x23, TPIDR_EL0
    5304:      	mov	x20, x0
    5308:      	adrp	x0, 0x8000
    530c:      	ldr	x8, [x23, #0x28]
    5310:      	mov	x19, x2
    5314:      	mov	x21, x1
    5318:      	stur	x8, [x29, #-0x8]
    531c:      	ldr	x0, [x0, #0x248]
    5320:      	bl	0x5a98 <pthread_mutex_lock@plt>
    5324:      	adrp	x24, 0x8000
    5328:      	ldr	x24, [x24, #0x250]
    532c:      	ldr	x22, [x24]
    5330:      	cbnz	x22, 0x5348 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x540>
    5334:      	mov	w0, #0x10
    5338:      	bl	0x5a68 <_Znwm@plt>
    533c:      	mov	x22, x0
    5340:      	bl	0x5a80 <_ZN7android19GraphicBufferMapperC1Ev@plt>
    5344:      	str	x22, [x24]
    5348:      	adrp	x0, 0x8000
    534c:      	ldr	x0, [x0, #0x248]
    5350:      	bl	0x5ab0 <pthread_mutex_unlock@plt>
    5354:      	ldr	x8, [x20]
    5358:      	add	x2, sp, #0x8
    535c:      	mov	x0, x22
    5360:      	stp	xzr, xzr, [sp, #0x8]
    5364:      	add	x24, sp, #0x8
    5368:      	ldr	x1, [x8, #0x70]
    536c:      	str	xzr, [sp, #0x18]
    5370:      	bl	0x5a50 <_ZN7android19GraphicBufferMapper15getPlaneLayoutsEPK13native_handlePNSt3__16vectorIN4aidl7android8hardware8graphics6common11PlaneLayoutENS4_9allocatorISB_EEEE@plt>
    5374:      	mov	w22, w0
    5378:      	cbnz	w0, 0x54c8 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x6c0>
    537c:      	ldp	x8, x9, [sp, #0x8]
    5380:      	cmp	x8, x9
    5384:      	b.eq	0x547c <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x674>
    5388:      	mov	x11, xzr
    538c:      	mov	w12, wzr
    5390:      	mov	w10, wzr
    5394:      	mov	x14, xzr
    5398:      	mov	x13, xzr
    539c:      	ldp	x15, x16, [x8]
    53a0:      	cmp	x15, x16
    53a4:      	b.eq	0x5474 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x66c>
    53a8:      	mov	x17, xzr
    53ac:      	mov	x0, x15
    53b0:      	ldr	x1, [x0, #0x28]
    53b4:      	cmp	x1, #0xa
    53b8:      	b.ne	0x5474 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x66c>
    53bc:      	ldr	x1, [x0, #0x18]
    53c0:      	add	x0, x0, #0x30
    53c4:      	cmp	x0, x16
    53c8:      	orr	x17, x1, x17
    53cc:      	b.ne	0x53b0 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x5a8>
    53d0:      	cmp	x17, #0x6
    53d4:      	b.eq	0x5408 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x600>
    53d8:      	cmp	x17, #0x1
    53dc:      	b.ne	0x5474 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x66c>
    53e0:      	ldr	x10, [x8, #0x20]
    53e4:      	cmp	x10, #0x10
    53e8:      	b.ne	0x5474 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x66c>
    53ec:      	ldr	x10, [x15, #0x20]
    53f0:      	cmp	x10, #0x6
    53f4:      	b.ne	0x5474 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x66c>
    53f8:      	ldr	x11, [x8, #0x18]
    53fc:      	ldr	w10, [x8, #0x28]
    5400:      	add	x11, x21, x11
    5404:      	b	0x5464 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x65c>
    5408:      	ldr	x12, [x8, #0x20]
    540c:      	cmp	x12, #0x20
    5410:      	b.eq	0x5430 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x628>
    5414:      	b	0x5474 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x66c>
    5418:      	ldr	x12, [x15, #0x20]
    541c:      	cmp	x12, #0x16
    5420:      	b.ne	0x5474 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x66c>
    5424:      	add	x15, x15, #0x30
    5428:      	cmp	x15, x16
    542c:      	b.eq	0x5454 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x64c>
    5430:      	ldr	x12, [x15, #0x18]
    5434:      	cmp	x12, #0x4
    5438:      	b.eq	0x5418 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x610>
    543c:      	cmp	x12, #0x2
    5440:      	b.ne	0x5424 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x61c>
    5444:      	ldr	x12, [x15, #0x20]
    5448:      	cmp	x12, #0x6
    544c:      	b.eq	0x5424 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x61c>
    5450:      	b	0x5474 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x66c>
    5454:      	ldr	x12, [x8, #0x18]
    5458:      	add	x13, x21, x12
    545c:      	ldr	w12, [x8, #0x28]
    5460:      	add	x14, x13, #0x2
    5464:      	add	x8, x8, #0x58
    5468:      	cmp	x8, x9
    546c:      	b.ne	0x539c <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x594>
    5470:      	b	0x5490 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x688>
    5474:      	mov	w22, #-0x16
    5478:      	b	0x54c8 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x6c0>
    547c:      	mov	x13, xzr
    5480:      	mov	x14, xzr
    5484:      	mov	w10, wzr
    5488:      	mov	w12, wzr
    548c:      	mov	x11, xzr
    5490:      	str	x11, [x19]
    5494:      	mov	w22, wzr
    5498:      	mov	w9, #0x3c
    549c:      	ldr	x8, [x20]
    54a0:      	ldr	w8, [x8, #0x48]
    54a4:      	str	w8, [x19, #0x8]
    54a8:      	ldr	x8, [x20]
    54ac:      	ldr	w8, [x8, #0x4c]
    54b0:      	str	w9, [x19, #0x48]
    54b4:      	stp	x13, x14, [x19, #0x50]
    54b8:      	str	w8, [x19, #0xc]
    54bc:      	mov	w8, #0x4
    54c0:      	stp	w9, w10, [x19, #0x10]
    54c4:      	stp	w12, w8, [x19, #0x60]
    54c8:      	sub	x0, x29, #0x10
    54cc:      	stur	x24, [x29, #-0x10]
    54d0:      	bl	0x5844 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x184>
    54d4:      	ldr	x8, [x23, #0x28]
    54d8:      	ldur	x9, [x29, #-0x8]
    54dc:      	cmp	x8, x9
    54e0:      	b.ne	0x5504 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x6fc>
    54e4:      	mov	w0, w22
    54e8:      	ldp	x20, x19, [sp, #0x60]
    54ec:      	ldp	x22, x21, [sp, #0x50]
    54f0:      	ldp	x24, x23, [sp, #0x40]
    54f4:      	ldp	x29, x30, [sp, #0x30]
    54f8:      	add	sp, sp, #0x70
    54fc:      	autiasp
    5500:      	ret
    5504:      	bl	0x5b58 <__stack_chk_fail@plt>

0000000000005508 <_ZN7android19lockImageFromBufferEPNS_10BufferItemEjiPNS_11CpuConsumer12LockedBufferE>:
    5508:      	paciasp
    550c:      	sub	sp, sp, #0x50
    5510:      	stp	x29, x30, [sp, #0x10]
    5514:      	str	x23, [sp, #0x20]
    5518:      	stp	x22, x21, [sp, #0x30]
    551c:      	stp	x20, x19, [sp, #0x40]
    5520:      	add	x29, sp, #0x10
    5524:      	mrs	x22, TPIDR_EL0
    5528:      	ldr	x8, [x22, #0x28]
    552c:      	str	x8, [sp, #0x8]
    5530:      	cbz	x0, 0x55b4 <_ZN7android19lockImageFromBufferEPNS_10BufferItemEjiPNS_11CpuConsumer12LockedBufferE+0xac>
    5534:      	mov	x19, x3
    5538:      	cbz	x3, 0x55b4 <_ZN7android19lockImageFromBufferEPNS_10BufferItemEjiPNS_11CpuConsumer12LockedBufferE+0xac>
    553c:      	mov	x20, x0
    5540:      	ldr	x0, [x0]
    5544:      	mov	w21, w2
    5548:      	str	x0, [sp]
    554c:      	cbz	x0, 0x5560 <_ZN7android19lockImageFromBufferEPNS_10BufferItemEjiPNS_11CpuConsumer12LockedBufferE+0x58>
    5550:      	mov	w23, w1
    5554:      	mov	x1, sp
    5558:      	bl	0x5af8 <_ZNK7android7RefBase9incStrongEPKv@plt>
    555c:      	mov	w1, w23
    5560:      	mov	x0, sp
    5564:      	add	x2, x20, #0x20
    5568:      	mov	w3, w21
    556c:      	mov	x4, x19
    5570:      	bl	0x5990 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE@plt>
    5574:      	ldr	x8, [sp]
    5578:      	mov	w21, w0
    557c:      	cbz	x8, 0x558c <_ZN7android19lockImageFromBufferEPNS_10BufferItemEjiPNS_11CpuConsumer12LockedBufferE+0x84>
    5580:      	mov	x1, sp
    5584:      	mov	x0, x8
    5588:      	bl	0x5ae0 <_ZNK7android7RefBase9decStrongEPKv@plt>
    558c:      	cbz	w21, 0x55d4 <_ZN7android19lockImageFromBufferEPNS_10BufferItemEjiPNS_11CpuConsumer12LockedBufferE+0xcc>
    5590:      	adrp	x1, 0x1000
    5594:      	add	x1, x1, #0x256
    5598:      	adrp	x2, 0x1000
    559c:      	add	x2, x2, #0x5bd
    55a0:      	adrp	x3, 0x1000
    55a4:      	add	x3, x3, #0x525
    55a8:      	mov	w0, #0x6
    55ac:      	bl	0x59c0 <__android_log_print@plt>
    55b0:      	b	0x5604 <_ZN7android19lockImageFromBufferEPNS_10BufferItemEjiPNS_11CpuConsumer12LockedBufferE+0xfc>
    55b4:      	adrp	x1, 0x1000
    55b8:      	add	x1, x1, #0x256
    55bc:      	adrp	x2, 0x1000
    55c0:      	add	x2, x2, #0x5ec
    55c4:      	mov	w0, #0x6
    55c8:      	bl	0x59c0 <__android_log_print@plt>
    55cc:      	mov	w21, #-0x16
    55d0:      	b	0x5604 <_ZN7android19lockImageFromBufferEPNS_10BufferItemEjiPNS_11CpuConsumer12LockedBufferE+0xfc>
    55d4:      	ldur	q0, [x20, #0x20]
    55d8:      	stur	q0, [x19, #0x18]
    55dc:      	ldr	w8, [x20, #0x30]
    55e0:      	str	w8, [x19, #0x28]
    55e4:      	ldr	w8, [x20, #0x34]
    55e8:      	str	w8, [x19, #0x2c]
    55ec:      	ldr	x8, [x20, #0x38]
    55f0:      	str	x8, [x19, #0x30]
    55f4:      	ldr	w8, [x20, #0x44]
    55f8:      	str	w8, [x19, #0x38]
    55fc:      	ldr	x8, [x20, #0xa8]
    5600:      	str	x8, [x19, #0x40]
    5604:      	ldr	x8, [x22, #0x28]
    5608:      	ldr	x9, [sp, #0x8]
    560c:      	cmp	x8, x9
    5610:      	b.ne	0x5634 <_ZN7android19lockImageFromBufferEPNS_10BufferItemEjiPNS_11CpuConsumer12LockedBufferE+0x12c>
    5614:      	mov	w0, w21
    5618:      	ldp	x20, x19, [sp, #0x40]
    561c:      	ldr	x23, [sp, #0x20]
    5620:      	ldp	x22, x21, [sp, #0x30]
    5624:      	ldp	x29, x30, [sp, #0x10]
    5628:      	add	sp, sp, #0x50
    562c:      	autiasp
    5630:      	ret
    5634:      	bl	0x5b58 <__stack_chk_fail@plt>

0000000000005638 <_ZN7android14getBufferWidthEPNS_10BufferItemE>:
    5638:      	bti	c
    563c:      	cbz	x0, 0x5668 <_ZN7android14getBufferWidthEPNS_10BufferItemE+0x30>
    5640:      	ldr	w9, [x0, #0x28]
    5644:      	ldr	w10, [x0, #0x20]
    5648:      	mov	x8, x0
    564c:      	subs	w0, w9, w10
    5650:      	b.le	0x5670 <_ZN7android14getBufferWidthEPNS_10BufferItemE+0x38>
    5654:      	ldr	w9, [x8, #0x2c]
    5658:      	ldr	w10, [x8, #0x24]
    565c:      	cmp	w9, w10
    5660:      	b.le	0x5670 <_ZN7android14getBufferWidthEPNS_10BufferItemE+0x38>
    5664:      	ret
    5668:      	mov	w0, #-0x1
    566c:      	ret
    5670:      	ldr	x8, [x8]
    5674:      	ldr	w0, [x8, #0x48]
    5678:      	ret

000000000000567c <_ZN7android15getBufferHeightEPNS_10BufferItemE>:
    567c:      	bti	c
    5680:      	cbz	x0, 0x56ac <_ZN7android15getBufferHeightEPNS_10BufferItemE+0x30>
    5684:      	ldr	w9, [x0, #0x28]
    5688:      	ldr	w10, [x0, #0x20]
    568c:      	mov	x8, x0
    5690:      	cmp	w9, w10
    5694:      	b.le	0x56b4 <_ZN7android15getBufferHeightEPNS_10BufferItemE+0x38>
    5698:      	ldr	w9, [x8, #0x2c]
    569c:      	ldr	w10, [x8, #0x24]
    56a0:      	subs	w0, w9, w10
    56a4:      	b.le	0x56b4 <_ZN7android15getBufferHeightEPNS_10BufferItemE+0x38>
    56a8:      	ret
    56ac:      	mov	w0, #-0x1
    56b0:      	ret
    56b4:      	ldr	x8, [x8]
    56b8:      	ldr	w0, [x8, #0x4c]
    56bc:      	ret

00000000000056c0 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE>:
    56c0:      	paciasp
    56c4:      	sub	sp, sp, #0x50
    56c8:      	stp	x29, x30, [sp, #0x20]
    56cc:      	stp	x22, x21, [sp, #0x30]
    56d0:      	stp	x20, x19, [sp, #0x40]
    56d4:      	add	x29, sp, #0x20
    56d8:      	mrs	x21, TPIDR_EL0
    56dc:      	ldr	x8, [x21, #0x28]
    56e0:      	stur	x8, [x29, #-0x8]
    56e4:      	cbz	x0, 0x5818 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x158>
    56e8:      	ldr	x8, [x0]
    56ec:      	cbz	x8, 0x5818 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x158>
    56f0:      	ldr	w9, [x8, #0x54]
    56f4:      	cmp	w9, #0x21
    56f8:      	b.ne	0x5818 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x158>
    56fc:      	ldr	w9, [x0, #0x44]
    5700:      	mov	w10, #0x1004
    5704:      	cmp	w9, w10
    5708:      	b.ne	0x5818 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x158>
    570c:      	mov	x20, x0
    5710:      	ldr	x0, [x1]
    5714:      	mov	x22, x1
    5718:      	str	xzr, [sp, #0x10]
    571c:      	cbz	x0, 0x5730 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x70>
    5720:      	bl	0x5a08 <_ZNK7android5Fence3dupEv@plt>
    5724:      	ldr	x8, [x20]
    5728:      	mov	w19, w0
    572c:      	b	0x5734 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x74>
    5730:      	mov	w19, #-0x1
    5734:      	ldr	x9, [x8, #0x48]
    5738:      	mov	x2, sp
    573c:      	add	x3, sp, #0x10
    5740:      	mov	x0, x8
    5744:      	mov	w1, #0x30
    5748:      	mov	w4, w19
    574c:      	mov	x5, xzr
    5750:      	mov	x6, xzr
    5754:      	stp	xzr, x9, [sp]
    5758:      	bl	0x59f0 <_ZN7android13GraphicBuffer9lockAsyncEjRKNS_4RectEPPviPiS6_@plt>
    575c:      	cbz	w0, 0x5770 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0xb0>
    5760:      	tbnz	w19, #0x1f, 0x5818 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x158>
    5764:      	mov	w0, w19
    5768:      	bl	0x5a38 <close@plt>
    576c:      	b	0x5818 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x158>
    5770:      	ldr	x0, [x20]
    5774:      	ldr	x9, [sp, #0x10]
    5778:      	ldr	w8, [x0, #0x48]
    577c:      	add	x8, x9, x8
    5780:      	ldur	w9, [x8, #-0x8]
    5784:      	cmp	w9, #0xfd
    5788:      	b.ne	0x5794 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0xd4>
    578c:      	stur	xzr, [x8, #-0x8]
    5790:      	ldr	x0, [x20]
    5794:      	mov	w8, #-0x1
    5798:      	mov	x1, sp
    579c:      	str	w8, [sp]
    57a0:      	bl	0x5a20 <_ZN7android13GraphicBuffer11unlockAsyncEPi@plt>
    57a4:      	mov	w0, #0x10
    57a8:      	bl	0x5a68 <_Znwm@plt>
    57ac:      	ldr	w1, [sp]
    57b0:      	mov	x19, x0
    57b4:      	bl	0x5b10 <_ZN7android5FenceC1Ei@plt>
    57b8:      	add	x1, x19, #0x8
    57bc:      	mov	w0, #0x1
    57c0:      	bl	0x4020 <.text+0x20>
    57c4:      	ldr	x20, [x22]
    57c8:      	mov	x8, x22
    57cc:      	cbz	x20, 0x5800 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x140>
    57d0:      	add	x1, x20, #0x8
    57d4:      	mov	w0, #-0x1
    57d8:      	bl	0x43c0 <.text+0x3c0>
    57dc:      	mov	x8, x22
    57e0:      	cmp	w0, #0x1
    57e4:      	b.ne	0x5800 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x140>
    57e8:      	dmb	ishld
    57ec:      	mov	x0, x20
    57f0:      	ldr	x8, [x20]
    57f4:      	ldr	x8, [x8, #0x18]
    57f8:      	blr	x8
    57fc:      	mov	x8, x22
    5800:      	ldr	x9, [x8]
    5804:      	cmp	x20, x9
    5808:      	b.eq	0x5814 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x154>
    580c:      	bl	0x5b28 <_ZN7android14sp_report_raceEv@plt>
    5810:      	mov	x8, x22
    5814:      	str	x19, [x8]
    5818:      	ldr	x8, [x21, #0x28]
    581c:      	ldur	x9, [x29, #-0x8]
    5820:      	cmp	x8, x9
    5824:      	b.ne	0x5840 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x180>
    5828:      	ldp	x20, x19, [sp, #0x40]
    582c:      	ldp	x22, x21, [sp, #0x30]
    5830:      	ldp	x29, x30, [sp, #0x20]
    5834:      	add	sp, sp, #0x50
    5838:      	autiasp
    583c:      	ret
    5840:      	bl	0x5b58 <__stack_chk_fail@plt>
    5844:      	paciasp
    5848:      	stp	x29, x30, [sp, #-0x50]!
    584c:      	str	x25, [sp, #0x10]
    5850:      	stp	x24, x23, [sp, #0x20]
    5854:      	stp	x22, x21, [sp, #0x30]
    5858:      	stp	x20, x19, [sp, #0x40]
    585c:      	mov	x29, sp
    5860:      	ldr	x20, [x0]
    5864:      	ldr	x21, [x20]
    5868:      	cbz	x21, 0x591c <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x25c>
    586c:      	ldr	x23, [x20, #0x8]
    5870:      	mov	x19, x0
    5874:      	cmp	x21, x23
    5878:      	b.eq	0x58ec <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x22c>
    587c:      	mov	x22, x23
    5880:      	b	0x58a4 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x1e4>
    5884:      	ldr	x0, [x22]
    5888:      	ldur	x8, [x23, #-0x48]
    588c:      	stur	x24, [x23, #-0x50]
    5890:      	sub	x1, x8, x0
    5894:      	bl	0x5ac8 <_ZdlPvm@plt>
    5898:      	cmp	x21, x22
    589c:      	mov	x23, x22
    58a0:      	b.eq	0x58ec <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x22c>
    58a4:      	ldr	x24, [x22, #-0x58]!
    58a8:      	cbz	x24, 0x5898 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x1d8>
    58ac:      	ldur	x8, [x23, #-0x50]
    58b0:      	mov	x0, x24
    58b4:      	cmp	x24, x8
    58b8:      	b.eq	0x5888 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x1c8>
    58bc:      	mov	x25, x8
    58c0:      	b	0x58d0 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x210>
    58c4:      	cmp	x25, x24
    58c8:      	mov	x8, x25
    58cc:      	b.eq	0x5884 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x1c4>
    58d0:      	ldrb	w9, [x25, #-0x30]!
    58d4:      	tbz	w9, #0x0, 0x58c4 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x204>
    58d8:      	ldur	x0, [x8, #-0x20]
    58dc:      	ldur	x8, [x8, #-0x30]
    58e0:      	and	x1, x8, #0xfffffffffffffffe
    58e4:      	bl	0x5ac8 <_ZdlPvm@plt>
    58e8:      	b	0x58c4 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x204>
    58ec:      	str	x21, [x20, #0x8]
    58f0:      	ldr	x8, [x19]
    58f4:      	ldr	x0, [x8]
    58f8:      	ldr	x8, [x8, #0x10]
    58fc:      	sub	x1, x8, x0
    5900:      	ldp	x20, x19, [sp, #0x40]
    5904:      	ldr	x25, [sp, #0x10]
    5908:      	ldp	x22, x21, [sp, #0x30]
    590c:      	ldp	x24, x23, [sp, #0x20]
    5910:      	ldp	x29, x30, [sp], #0x50
    5914:      	autiasp
    5918:      	b	0x5ac8 <_ZdlPvm@plt>
    591c:      	ldp	x20, x19, [sp, #0x40]
    5920:      	ldr	x25, [sp, #0x10]
    5924:      	ldp	x22, x21, [sp, #0x30]
    5928:      	ldp	x24, x23, [sp, #0x20]
    592c:      	ldp	x29, x30, [sp], #0x50
    5930:      	autiasp
    5934:      	ret
