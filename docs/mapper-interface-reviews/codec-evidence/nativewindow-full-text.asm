
retained-evidence/provider-callers-43776923589/legacy_graphics/abi-consumers/b196e0a8e32fd3b10208dda16d1def366efeaedf756e47eb08ecd91c3c4157d3.elf:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000008000 <.text>:
    8000:      	bti	c
    8004:      	nop
    8008:      	adr	x0, #0x3ff8
    800c:      	b	0xa900 <__cxa_finalize@plt>
    8010:      	bti	c
    8014:      	ret
    8018:      	bti	c
    801c:      	b	0x8010 <.text+0x10>

0000000000008020 <AHardwareBuffer_allocate>:
    8020:      	paciasp
    8024:      	sub	sp, sp, #0xe0
    8028:      	stp	x29, x30, [sp, #0x80]
    802c:      	stp	x28, x27, [sp, #0x90]
    8030:      	stp	x26, x25, [sp, #0xa0]
    8034:      	stp	x24, x23, [sp, #0xb0]
    8038:      	stp	x22, x21, [sp, #0xc0]
    803c:      	stp	x20, x19, [sp, #0xd0]
    8040:      	add	x29, sp, #0x80
    8044:      	mrs	x26, TPIDR_EL0
    8048:      	mov	x19, x0
    804c:      	mov	w0, #-0x16
    8050:      	ldr	x8, [x26, #0x28]
    8054:      	stur	x8, [x29, #-0x8]
    8058:      	cbz	x19, 0x828c <AHardwareBuffer_allocate+0x26c>
    805c:      	cbz	x1, 0x828c <AHardwareBuffer_allocate+0x26c>
    8060:      	mov	x27, x1
    8064:      	mov	x0, x19
    8068:      	mov	w1, #0x1
    806c:      	bl	0x82c4 <AHardwareBuffer_allocate+0x2a4>
    8070:      	tbz	w0, #0x0, 0x81cc <AHardwareBuffer_allocate+0x1ac>
    8074:      	ldr	w22, [x19, #0xc]
    8078:      	ldr	x21, [x19, #0x10]
    807c:      	mov	w0, #0xd30
    8080:      	bl	0xa918 <_Znwm@plt>
    8084:      	mov	w8, #0x2a
    8088:      	nop
    808c:      	adr	x9, #-0x523c
    8090:      	ldr	q0, [x9]
    8094:      	strb	w8, [sp, #0x18]
    8098:      	ldur	x8, [x9, #0xd]
    809c:      	ldp	w24, w25, [x19]
    80a0:      	ldr	w23, [x19, #0x8]
    80a4:      	mov	x20, x0
    80a8:      	stur	q0, [sp, #0x19]
    80ac:      	stur	x8, [sp, #0x26]
    80b0:      	strb	wzr, [sp, #0x2e]
    80b4:      	bl	0xa948 <getpid@plt>
    80b8:      	mov	x8, sp
    80bc:      	mov	x28, sp
    80c0:      	bl	0xa930 <_ZNSt3__19to_stringEi@plt>
    80c4:      	ldrb	w8, [sp]
    80c8:      	ldp	x10, x9, [sp, #0x8]
    80cc:      	add	x0, sp, #0x18
    80d0:      	lsr	x11, x8, #1
    80d4:      	tst	w8, #0x1
    80d8:      	csinc	x1, x9, x28, ne
    80dc:      	csel	x2, x10, x11, ne
    80e0:      	bl	0xac00 <_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6appendEPKcm@plt>
    80e4:      	ldr	q0, [x0]
    80e8:      	ldr	x8, [x0, #0x10]
    80ec:      	adrp	x1, 0x2000
    80f0:      	add	x1, x1, #0xefb
    80f4:      	mov	w2, #0x1
    80f8:      	str	q0, [sp, #0x30]
    80fc:      	str	x8, [sp, #0x40]
    8100:      	stp	xzr, xzr, [x0, #0x8]
    8104:      	str	xzr, [x0]
    8108:      	add	x0, sp, #0x30
    810c:      	bl	0xac00 <_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6appendEPKcm@plt>
    8110:      	ldr	q0, [x0]
    8114:      	ldr	x8, [x0, #0x10]
    8118:      	sub	x6, x29, #0x30
    811c:      	mov	w1, w24
    8120:      	mov	w2, w25
    8124:      	mov	w3, w22
    8128:      	stur	q0, [x29, #-0x30]
    812c:      	mov	w4, w23
    8130:      	mov	x5, x21
    8134:      	stur	x8, [x29, #-0x20]
    8138:      	stp	xzr, xzr, [x0, #0x8]
    813c:      	str	xzr, [x0]
    8140:      	mov	x0, x20
    8144:      	bl	0xa960 <_ZN7android13GraphicBufferC1EjjijmNSt3__112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE@plt>
    8148:      	sub	x1, x29, #0x10
    814c:      	mov	x0, x20
    8150:      	stur	x20, [x29, #-0x10]
    8154:      	bl	0xacc0 <_ZNK7android7RefBase9incStrongEPKv@plt>
    8158:      	ldurb	w8, [x29, #-0x30]
    815c:      	tbnz	w8, #0x0, 0x81d4 <AHardwareBuffer_allocate+0x1b4>
    8160:      	ldrb	w8, [sp, #0x30]
    8164:      	tbnz	w8, #0x0, 0x81ec <AHardwareBuffer_allocate+0x1cc>
    8168:      	ldrb	w8, [sp]
    816c:      	tbnz	w8, #0x0, 0x8204 <AHardwareBuffer_allocate+0x1e4>
    8170:      	ldrb	w8, [sp, #0x18]
    8174:      	tbz	w8, #0x0, 0x8188 <AHardwareBuffer_allocate+0x168>
    8178:      	ldr	x8, [sp, #0x18]
    817c:      	ldr	x0, [sp, #0x28]
    8180:      	and	x1, x8, #0xfffffffffffffffe
    8184:      	bl	0xac30 <_ZdlPvm@plt>
    8188:      	ldur	x0, [x29, #-0x10]
    818c:      	bl	0xa978 <_ZNK7android13GraphicBuffer9initCheckEv@plt>
    8190:      	mov	w20, w0
    8194:      	cmn	w0, #0xc
    8198:      	b.eq	0x8220 <AHardwareBuffer_allocate+0x200>
    819c:      	cbnz	w20, 0x8224 <AHardwareBuffer_allocate+0x204>
    81a0:      	ldur	x0, [x29, #-0x10]
    81a4:      	ldr	x8, [x0, #0x70]
    81a8:      	cbz	x8, 0x8224 <AHardwareBuffer_allocate+0x204>
    81ac:      	bl	0xabe8 <_ZN7android13GraphicBuffer17toAHardwareBufferEv@plt>
    81b0:      	str	x0, [x27]
    81b4:      	bl	0xabb8 <_ZN7android13GraphicBuffer19fromAHardwareBufferEP15AHardwareBuffer@plt>
    81b8:      	adrp	x1, 0xc000
    81bc:      	ldr	x1, [x1, #0x2a8]
    81c0:      	bl	0xacc0 <_ZNK7android7RefBase9incStrongEPKv@plt>
    81c4:      	mov	w0, wzr
    81c8:      	b	0x8270 <AHardwareBuffer_allocate+0x250>
    81cc:      	mov	w0, #-0x16
    81d0:      	b	0x828c <AHardwareBuffer_allocate+0x26c>
    81d4:      	ldur	x8, [x29, #-0x30]
    81d8:      	ldur	x0, [x29, #-0x20]
    81dc:      	and	x1, x8, #0xfffffffffffffffe
    81e0:      	bl	0xac30 <_ZdlPvm@plt>
    81e4:      	ldrb	w8, [sp, #0x30]
    81e8:      	tbz	w8, #0x0, 0x8168 <AHardwareBuffer_allocate+0x148>
    81ec:      	ldr	x8, [sp, #0x30]
    81f0:      	ldr	x0, [sp, #0x40]
    81f4:      	and	x1, x8, #0xfffffffffffffffe
    81f8:      	bl	0xac30 <_ZdlPvm@plt>
    81fc:      	ldrb	w8, [sp]
    8200:      	tbz	w8, #0x0, 0x8170 <AHardwareBuffer_allocate+0x150>
    8204:      	ldr	x8, [sp]
    8208:      	ldr	x0, [sp, #0x10]
    820c:      	and	x1, x8, #0xfffffffffffffffe
    8210:      	bl	0xac30 <_ZdlPvm@plt>
    8214:      	ldrb	w8, [sp, #0x18]
    8218:      	tbnz	w8, #0x0, 0x8178 <AHardwareBuffer_allocate+0x158>
    821c:      	b	0x8188 <AHardwareBuffer_allocate+0x168>
    8220:      	bl	0xa990 <_ZN7android13GraphicBuffer26dumpAllocationsToSystemLogEv@plt>
    8224:      	ldp	w21, w22, [x19]
    8228:      	ldr	w19, [x19, #0x8]
    822c:      	neg	w0, w20
    8230:      	bl	0xa9c0 <strerror@plt>
    8234:      	ldur	x8, [x29, #-0x10]
    8238:      	mov	x6, x0
    823c:      	adrp	x1, 0x3000
    8240:      	add	x1, x1, #0xac
    8244:      	adrp	x2, 0x2000
    8248:      	add	x2, x2, #0xe18
    824c:      	ldr	x7, [x8, #0x70]
    8250:      	mov	w0, #0x6
    8254:      	mov	w3, w21
    8258:      	mov	w4, w22
    825c:      	mov	w5, w19
    8260:      	bl	0xa9a8 <__android_log_print@plt>
    8264:      	cmp	w20, #0x0
    8268:      	mov	w8, #-0x80000000
    826c:      	csel	w0, w8, w20, eq
    8270:      	ldur	x8, [x29, #-0x10]
    8274:      	cbz	x8, 0x828c <AHardwareBuffer_allocate+0x26c>
    8278:      	sub	x1, x29, #0x10
    827c:      	mov	w19, w0
    8280:      	mov	x0, x8
    8284:      	bl	0xacd8 <_ZNK7android7RefBase9decStrongEPKv@plt>
    8288:      	mov	w0, w19
    828c:      	ldr	x8, [x26, #0x28]
    8290:      	ldur	x9, [x29, #-0x8]
    8294:      	cmp	x8, x9
    8298:      	b.ne	0x82c0 <AHardwareBuffer_allocate+0x2a0>
    829c:      	ldp	x20, x19, [sp, #0xd0]
    82a0:      	ldp	x22, x21, [sp, #0xc0]
    82a4:      	ldp	x24, x23, [sp, #0xb0]
    82a8:      	ldp	x26, x25, [sp, #0xa0]
    82ac:      	ldp	x28, x27, [sp, #0x90]
    82b0:      	ldp	x29, x30, [sp, #0x80]
    82b4:      	add	sp, sp, #0xe0
    82b8:      	autiasp
    82bc:      	ret
    82c0:      	bl	0xadb0 <__stack_chk_fail@plt>
    82c4:      	paciasp
    82c8:      	stp	x29, x30, [sp, #-0x40]!
    82cc:      	str	x23, [sp, #0x10]
    82d0:      	stp	x22, x21, [sp, #0x20]
    82d4:      	stp	x20, x19, [sp, #0x30]
    82d8:      	mov	x29, sp
    82dc:      	ldr	w19, [x0]
    82e0:      	cbz	w19, 0x8314 <AHardwareBuffer_allocate+0x2f4>
    82e4:      	ldr	w21, [x0, #0x4]
    82e8:      	cbz	w21, 0x8314 <AHardwareBuffer_allocate+0x2f4>
    82ec:      	ldr	w20, [x0, #0x8]
    82f0:      	cbz	w20, 0x8314 <AHardwareBuffer_allocate+0x2f4>
    82f4:      	ldr	w8, [x0, #0x1c]
    82f8:      	cbnz	w8, 0x8304 <AHardwareBuffer_allocate+0x2e4>
    82fc:      	ldr	x8, [x0, #0x20]
    8300:      	cbz	x8, 0x8334 <AHardwareBuffer_allocate+0x314>
    8304:      	tbz	w1, #0x0, 0x8318 <AHardwareBuffer_allocate+0x2f8>
    8308:      	adrp	x2, 0x2000
    830c:      	add	x2, x2, #0xe66
    8310:      	b	0x846c <AHardwareBuffer_allocate+0x44c>
    8314:      	tbnz	w1, #0x0, 0x8464 <AHardwareBuffer_allocate+0x444>
    8318:      	mov	w0, wzr
    831c:      	ldp	x20, x19, [sp, #0x30]
    8320:      	ldr	x23, [sp, #0x10]
    8324:      	ldp	x22, x21, [sp, #0x20]
    8328:      	ldp	x29, x30, [sp], #0x40
    832c:      	autiasp
    8330:      	ret
    8334:      	ldr	w8, [x0, #0xc]
    8338:      	cmp	w8, #0x21
    833c:      	b.ne	0x8370 <AHardwareBuffer_allocate+0x350>
    8340:      	cmp	w21, #0x1
    8344:      	b.ne	0x83a8 <AHardwareBuffer_allocate+0x388>
    8348:      	cmp	w20, #0x1
    834c:      	b.ne	0x83a8 <AHardwareBuffer_allocate+0x388>
    8350:      	ldr	x8, [x0, #0x10]
    8354:      	and	x9, x8, #0x7ffff00
    8358:      	tst	x9, #0xfffffffffe0003ff
    835c:      	b.eq	0x83e4 <AHardwareBuffer_allocate+0x3c4>
    8360:      	tbz	w1, #0x0, 0x8318 <AHardwareBuffer_allocate+0x2f8>
    8364:      	adrp	x2, 0x2000
    8368:      	add	x2, x2, #0xf58
    836c:      	b	0x846c <AHardwareBuffer_allocate+0x44c>
    8370:      	mov	x23, x0
    8374:      	mov	w0, w8
    8378:      	mov	w22, w1
    837c:      	bl	0x8a00 <AHardwareBuffer_lockPlanes+0x204>
    8380:      	tbz	w0, #0x0, 0x83b8 <AHardwareBuffer_allocate+0x398>
    8384:      	cmp	w20, #0x1
    8388:      	mov	w1, w22
    838c:      	b.ne	0x83d4 <AHardwareBuffer_allocate+0x3b4>
    8390:      	ldr	x8, [x23, #0x10]
    8394:      	and	x9, x8, #0x6000000
    8398:      	tbz	w1, #0x0, 0x83a0 <AHardwareBuffer_allocate+0x380>
    839c:      	cbnz	x9, 0x8480 <AHardwareBuffer_allocate+0x460>
    83a0:      	cbnz	x9, 0x8318 <AHardwareBuffer_allocate+0x2f8>
    83a4:      	b	0x83f0 <AHardwareBuffer_allocate+0x3d0>
    83a8:      	tbz	w1, #0x0, 0x8318 <AHardwareBuffer_allocate+0x2f8>
    83ac:      	adrp	x2, 0x3000
    83b0:      	add	x2, x2, #0xe9
    83b4:      	b	0x846c <AHardwareBuffer_allocate+0x44c>
    83b8:      	ldr	x8, [x23, #0x10]
    83bc:      	mov	w1, w22
    83c0:      	tbz	w8, #0x17, 0x83f0 <AHardwareBuffer_allocate+0x3d0>
    83c4:      	tbz	w1, #0x0, 0x8318 <AHardwareBuffer_allocate+0x2f8>
    83c8:      	adrp	x2, 0x2000
    83cc:      	add	x2, x2, #0xda6
    83d0:      	b	0x846c <AHardwareBuffer_allocate+0x44c>
    83d4:      	tbz	w1, #0x0, 0x8318 <AHardwareBuffer_allocate+0x2f8>
    83d8:      	adrp	x2, 0x3000
    83dc:      	add	x2, x2, #0x303
    83e0:      	b	0x846c <AHardwareBuffer_allocate+0x44c>
    83e4:      	tbz	w1, #0x0, 0x83ec <AHardwareBuffer_allocate+0x3cc>
    83e8:      	tbnz	w8, #0x10, 0x848c <AHardwareBuffer_allocate+0x46c>
    83ec:      	tbnz	w8, #0x10, 0x8318 <AHardwareBuffer_allocate+0x2f8>
    83f0:      	tst	x8, #0xff
    83f4:      	b.eq	0x840c <AHardwareBuffer_allocate+0x3ec>
    83f8:      	tbz	w8, #0xe, 0x840c <AHardwareBuffer_allocate+0x3ec>
    83fc:      	tbz	w1, #0x0, 0x8318 <AHardwareBuffer_allocate+0x2f8>
    8400:      	adrp	x2, 0x2000
    8404:      	add	x2, x2, #0xc33
    8408:      	b	0x846c <AHardwareBuffer_allocate+0x44c>
    840c:      	tbnz	w8, #0x19, 0x8418 <AHardwareBuffer_allocate+0x3f8>
    8410:      	mov	w0, #0x1
    8414:      	b	0x831c <AHardwareBuffer_allocate+0x2fc>
    8418:      	cmp	w19, w21
    841c:      	b.ne	0x8454 <AHardwareBuffer_allocate+0x434>
    8420:      	mov	w8, #0xaaab
    8424:      	mov	w9, #0x6
    8428:      	movk	w8, #0xaaaa, lsl #16
    842c:      	umull	x8, w20, w8
    8430:      	lsr	x8, x8, #34
    8434:      	msub	w8, w8, w9, w20
    8438:      	cmp	w8, #0x0
    843c:      	cset	w0, eq
    8440:      	cbz	w8, 0x831c <AHardwareBuffer_allocate+0x2fc>
    8444:      	tbz	w1, #0x0, 0x831c <AHardwareBuffer_allocate+0x2fc>
    8448:      	adrp	x2, 0x2000
    844c:      	add	x2, x2, #0xed3
    8450:      	b	0x846c <AHardwareBuffer_allocate+0x44c>
    8454:      	tbz	w1, #0x0, 0x8318 <AHardwareBuffer_allocate+0x2f8>
    8458:      	adrp	x2, 0x2000
    845c:      	add	x2, x2, #0xc1a
    8460:      	b	0x846c <AHardwareBuffer_allocate+0x44c>
    8464:      	adrp	x2, 0x3000
    8468:      	add	x2, x2, #0xbc
    846c:      	adrp	x1, 0x3000
    8470:      	add	x1, x1, #0xac
    8474:      	mov	w0, #0x6
    8478:      	bl	0xa9a8 <__android_log_print@plt>
    847c:      	b	0x8318 <AHardwareBuffer_allocate+0x2f8>
    8480:      	adrp	x2, 0x3000
    8484:      	add	x2, x2, #0x19d
    8488:      	b	0x846c <AHardwareBuffer_allocate+0x44c>
    848c:      	adrp	x2, 0x3000
    8490:      	add	x2, x2, #0x325
    8494:      	b	0x846c <AHardwareBuffer_allocate+0x44c>

0000000000008498 <_ZN7android36AHardwareBuffer_convertToPixelFormatEj>:
    8498:      	bti	c
    849c:      	ret

00000000000084a0 <_ZN7android41AHardwareBuffer_convertToGrallocUsageBitsEm>:
    84a0:      	bti	c
    84a4:      	ret

00000000000084a8 <_ZN7android34AHardwareBuffer_from_GraphicBufferEPNS_13GraphicBufferE>:
    84a8:      	bti	c
    84ac:      	b	0xabe8 <_ZN7android13GraphicBuffer17toAHardwareBufferEv@plt>

00000000000084b0 <AHardwareBuffer_acquire>:
    84b0:      	paciasp
    84b4:      	stp	x29, x30, [sp, #-0x10]!
    84b8:      	mov	x29, sp
    84bc:      	bl	0xabb8 <_ZN7android13GraphicBuffer19fromAHardwareBufferEP15AHardwareBuffer@plt>
    84c0:      	adrp	x1, 0xc000
    84c4:      	ldr	x1, [x1, #0x2a8]
    84c8:      	ldp	x29, x30, [sp], #0x10
    84cc:      	autiasp
    84d0:      	b	0xacc0 <_ZNK7android7RefBase9incStrongEPKv@plt>

00000000000084d4 <_ZN7android32AHardwareBuffer_to_GraphicBufferEP15AHardwareBuffer>:
    84d4:      	bti	c
    84d8:      	b	0xabb8 <_ZN7android13GraphicBuffer19fromAHardwareBufferEP15AHardwareBuffer@plt>

00000000000084dc <AHardwareBuffer_release>:
    84dc:      	paciasp
    84e0:      	stp	x29, x30, [sp, #-0x10]!
    84e4:      	mov	x29, sp
    84e8:      	bl	0xabb8 <_ZN7android13GraphicBuffer19fromAHardwareBufferEP15AHardwareBuffer@plt>
    84ec:      	adrp	x1, 0xc000
    84f0:      	ldr	x1, [x1, #0x2a8]
    84f4:      	ldp	x29, x30, [sp], #0x10
    84f8:      	autiasp
    84fc:      	b	0xacd8 <_ZNK7android7RefBase9decStrongEPKv@plt>

0000000000008500 <AHardwareBuffer_describe>:
    8500:      	bti	c
    8504:      	cbz	x0, 0x8564 <AHardwareBuffer_describe+0x64>
    8508:      	paciasp
    850c:      	stp	x29, x30, [sp, #-0x20]!
    8510:      	str	x19, [sp, #0x10]
    8514:      	mov	x29, sp
    8518:      	mov	x19, x1
    851c:      	cbz	x1, 0x8558 <AHardwareBuffer_describe+0x58>
    8520:      	bl	0xaba0 <_ZN7android13GraphicBuffer19fromAHardwareBufferEPK15AHardwareBuffer@plt>
    8524:      	ldr	w8, [x0, #0x48]
    8528:      	str	w8, [x19]
    852c:      	ldr	w8, [x0, #0x4c]
    8530:      	str	w8, [x19, #0x4]
    8534:      	ldr	x8, [x0, #0x60]
    8538:      	str	w8, [x19, #0x8]
    853c:      	ldr	w8, [x0, #0x54]
    8540:      	str	w8, [x19, #0xc]
    8544:      	ldr	x8, [x0, #0x78]
    8548:      	str	x8, [x19, #0x10]
    854c:      	ldr	w8, [x0, #0x50]
    8550:      	str	xzr, [x19, #0x20]
    8554:      	stp	w8, wzr, [x19, #0x18]
    8558:      	ldr	x19, [sp, #0x10]
    855c:      	ldp	x29, x30, [sp], #0x20
    8560:      	autiasp
    8564:      	ret

0000000000008568 <_ZN7android32AHardwareBuffer_to_GraphicBufferEPK15AHardwareBuffer>:
    8568:      	bti	c
    856c:      	b	0xaba0 <_ZN7android13GraphicBuffer19fromAHardwareBufferEPK15AHardwareBuffer@plt>

0000000000008570 <_ZN7android38AHardwareBuffer_convertFromPixelFormatEj>:
    8570:      	bti	c
    8574:      	ret

0000000000008578 <_ZN7android43AHardwareBuffer_convertFromGrallocUsageBitsEm>:
    8578:      	bti	c
    857c:      	ret

0000000000008580 <AHardwareBuffer_lockAndGetInfo>:
    8580:      	paciasp
    8584:      	sub	sp, sp, #0x80
    8588:      	stp	x29, x30, [sp, #0x30]
    858c:      	str	x25, [sp, #0x40]
    8590:      	stp	x24, x23, [sp, #0x50]
    8594:      	stp	x22, x21, [sp, #0x60]
    8598:      	stp	x20, x19, [sp, #0x70]
    859c:      	add	x29, sp, #0x30
    85a0:      	mrs	x21, TPIDR_EL0
    85a4:      	ldr	x8, [x21, #0x28]
    85a8:      	stur	x8, [x29, #-0x8]
    85ac:      	cbz	x5, 0x85b8 <AHardwareBuffer_lockAndGetInfo+0x38>
    85b0:      	mov	w8, #-0x1
    85b4:      	str	w8, [x5]
    85b8:      	cbz	x6, 0x85c4 <AHardwareBuffer_lockAndGetInfo+0x44>
    85bc:      	mov	w8, #-0x1
    85c0:      	str	w8, [x6]
    85c4:      	cbz	x0, 0x85ec <AHardwareBuffer_lockAndGetInfo+0x6c>
    85c8:      	sub	x8, x1, #0x100
    85cc:      	cmn	x8, #0x100
    85d0:      	b.hi	0x85f4 <AHardwareBuffer_lockAndGetInfo+0x74>
    85d4:      	adrp	x1, 0x3000
    85d8:      	add	x1, x1, #0xac
    85dc:      	adrp	x2, 0x3000
    85e0:      	add	x2, x2, #0x234
    85e4:      	mov	w0, #0x6
    85e8:      	bl	0xa9a8 <__android_log_print@plt>
    85ec:      	mov	w0, #-0x16
    85f0:      	b	0x86bc <AHardwareBuffer_lockAndGetInfo+0x13c>
    85f4:      	mov	x25, x3
    85f8:      	mov	x20, x1
    85fc:      	mov	w19, w2
    8600:      	mov	x24, x4
    8604:      	mov	x23, x5
    8608:      	mov	x22, x6
    860c:      	bl	0xabb8 <_ZN7android13GraphicBuffer19fromAHardwareBufferEP15AHardwareBuffer@plt>
    8610:      	ldr	w8, [x0, #0x60]
    8614:      	tst	w8, #0xfffffffe
    8618:      	b.eq	0x8638 <AHardwareBuffer_lockAndGetInfo+0xb8>
    861c:      	adrp	x1, 0x3000
    8620:      	add	x1, x1, #0xac
    8624:      	adrp	x2, 0x2000
    8628:      	add	x2, x2, #0xcf9
    862c:      	mov	w0, #0x6
    8630:      	bl	0xa9a8 <__android_log_print@plt>
    8634:      	b	0x86b8 <AHardwareBuffer_lockAndGetInfo+0x138>
    8638:      	cbz	x25, 0x8644 <AHardwareBuffer_lockAndGetInfo+0xc4>
    863c:      	ldr	q0, [x25]
    8640:      	b	0x8658 <AHardwareBuffer_lockAndGetInfo+0xd8>
    8644:      	mvni	v1.2s, #0x80, lsl #24
    8648:      	ldr	d2, [x0, #0x48]
    864c:      	movi	v0.2d, #0000000000000000
    8650:      	umin	v1.2s, v2.2s, v1.2s
    8654:      	mov	v0.d[1], v1.d[0]
    8658:      	mov	x1, x20
    865c:      	mov	x4, x24
    8660:      	add	x3, sp, #0x10
    8664:      	add	x6, sp, #0xc
    8668:      	add	x7, sp, #0x8
    866c:      	mov	x2, x1
    8670:      	mov	w5, w19
    8674:      	str	q0, [sp, #0x10]
    8678:      	mov	x20, x0
    867c:      	str	xzr, [sp, #0x8]
    8680:      	bl	0xa9d8 <_ZN7android13GraphicBuffer9lockAsyncEmmRKNS_4RectEPPviPiS6_@plt>
    8684:      	ldr	w8, [sp, #0xc]
    8688:      	cmn	w8, #0x1
    868c:      	b.eq	0x86b0 <AHardwareBuffer_lockAndGetInfo+0x130>
    8690:      	ldr	w9, [sp, #0x8]
    8694:      	cmn	w9, #0x1
    8698:      	b.eq	0x86b0 <AHardwareBuffer_lockAndGetInfo+0x130>
    869c:      	cbz	x23, 0x86a4 <AHardwareBuffer_lockAndGetInfo+0x124>
    86a0:      	str	w8, [x23]
    86a4:      	cbz	x22, 0x86bc <AHardwareBuffer_lockAndGetInfo+0x13c>
    86a8:      	str	w9, [x22]
    86ac:      	b	0x86bc <AHardwareBuffer_lockAndGetInfo+0x13c>
    86b0:      	mov	x0, x20
    86b4:      	bl	0xa9f0 <_ZN7android13GraphicBuffer6unlockEv@plt>
    86b8:      	mov	w0, #-0x26
    86bc:      	ldr	x8, [x21, #0x28]
    86c0:      	ldur	x9, [x29, #-0x8]
    86c4:      	cmp	x8, x9
    86c8:      	b.ne	0x86ec <AHardwareBuffer_lockAndGetInfo+0x16c>
    86cc:      	ldp	x20, x19, [sp, #0x70]
    86d0:      	ldr	x25, [sp, #0x40]
    86d4:      	ldp	x22, x21, [sp, #0x60]
    86d8:      	ldp	x24, x23, [sp, #0x50]
    86dc:      	ldp	x29, x30, [sp, #0x30]
    86e0:      	add	sp, sp, #0x80
    86e4:      	autiasp
    86e8:      	ret
    86ec:      	bl	0xadb0 <__stack_chk_fail@plt>

00000000000086f0 <AHardwareBuffer_lock>:
    86f0:      	paciasp
    86f4:      	sub	sp, sp, #0x60
    86f8:      	stp	x29, x30, [sp, #0x20]
    86fc:      	str	x23, [sp, #0x30]
    8700:      	stp	x22, x21, [sp, #0x40]
    8704:      	stp	x20, x19, [sp, #0x50]
    8708:      	add	x29, sp, #0x20
    870c:      	mrs	x20, TPIDR_EL0
    8710:      	ldr	x8, [x20, #0x28]
    8714:      	stur	x8, [x29, #-0x8]
    8718:      	cbz	x0, 0x8740 <AHardwareBuffer_lock+0x50>
    871c:      	sub	x8, x1, #0x100
    8720:      	cmn	x8, #0x100
    8724:      	b.hi	0x8748 <AHardwareBuffer_lock+0x58>
    8728:      	adrp	x1, 0x3000
    872c:      	add	x1, x1, #0xac
    8730:      	adrp	x2, 0x3000
    8734:      	add	x2, x2, #0x234
    8738:      	mov	w0, #0x6
    873c:      	bl	0xa9a8 <__android_log_print@plt>
    8740:      	mov	w0, #-0x16
    8744:      	b	0x87cc <AHardwareBuffer_lock+0xdc>
    8748:      	mov	x22, x3
    874c:      	mov	x21, x1
    8750:      	mov	w19, w2
    8754:      	mov	x23, x4
    8758:      	bl	0xabb8 <_ZN7android13GraphicBuffer19fromAHardwareBufferEP15AHardwareBuffer@plt>
    875c:      	ldr	w8, [x0, #0x60]
    8760:      	tst	w8, #0xfffffffe
    8764:      	b.eq	0x8788 <AHardwareBuffer_lock+0x98>
    8768:      	adrp	x1, 0x3000
    876c:      	add	x1, x1, #0xac
    8770:      	adrp	x2, 0x2000
    8774:      	add	x2, x2, #0xcf9
    8778:      	mov	w0, #0x6
    877c:      	bl	0xa9a8 <__android_log_print@plt>
    8780:      	mov	w0, #-0x26
    8784:      	b	0x87cc <AHardwareBuffer_lock+0xdc>
    8788:      	mov	x4, x23
    878c:      	cbz	x22, 0x8798 <AHardwareBuffer_lock+0xa8>
    8790:      	ldr	q0, [x22]
    8794:      	b	0x87ac <AHardwareBuffer_lock+0xbc>
    8798:      	mvni	v1.2s, #0x80, lsl #24
    879c:      	ldr	d2, [x0, #0x48]
    87a0:      	movi	v0.2d, #0000000000000000
    87a4:      	umin	v1.2s, v2.2s, v1.2s
    87a8:      	mov	v0.d[1], v1.d[0]
    87ac:      	mov	x3, sp
    87b0:      	mov	x1, x21
    87b4:      	mov	x2, x21
    87b8:      	mov	w5, w19
    87bc:      	mov	x6, xzr
    87c0:      	mov	x7, xzr
    87c4:      	str	q0, [sp]
    87c8:      	bl	0xa9d8 <_ZN7android13GraphicBuffer9lockAsyncEmmRKNS_4RectEPPviPiS6_@plt>
    87cc:      	ldr	x8, [x20, #0x28]
    87d0:      	ldur	x9, [x29, #-0x8]
    87d4:      	cmp	x8, x9
    87d8:      	b.ne	0x87f8 <AHardwareBuffer_lock+0x108>
    87dc:      	ldp	x20, x19, [sp, #0x50]
    87e0:      	ldr	x23, [sp, #0x30]
    87e4:      	ldp	x22, x21, [sp, #0x40]
    87e8:      	ldp	x29, x30, [sp, #0x20]
    87ec:      	add	sp, sp, #0x60
    87f0:      	autiasp
    87f4:      	ret
    87f8:      	bl	0xadb0 <__stack_chk_fail@plt>

00000000000087fc <AHardwareBuffer_lockPlanes>:
    87fc:      	paciasp
    8800:      	sub	sp, sp, #0xc0
    8804:      	stp	x29, x30, [sp, #0x80]
    8808:      	str	x23, [sp, #0x90]
    880c:      	stp	x22, x21, [sp, #0xa0]
    8810:      	stp	x20, x19, [sp, #0xb0]
    8814:      	add	x29, sp, #0x80
    8818:      	mrs	x21, TPIDR_EL0
    881c:      	mov	x8, x0
    8820:      	mov	w0, #-0x16
    8824:      	ldr	x9, [x21, #0x28]
    8828:      	stur	x9, [x29, #-0x8]
    882c:      	cbz	x8, 0x89d0 <AHardwareBuffer_lockPlanes+0x1d4>
    8830:      	mov	x19, x4
    8834:      	cbz	x4, 0x89d0 <AHardwareBuffer_lockPlanes+0x1d4>
    8838:      	sub	x9, x1, #0x100
    883c:      	cmn	x9, #0x100
    8840:      	b.hi	0x8864 <AHardwareBuffer_lockPlanes+0x68>
    8844:      	adrp	x1, 0x3000
    8848:      	add	x1, x1, #0xac
    884c:      	adrp	x2, 0x3000
    8850:      	add	x2, x2, #0x29b
    8854:      	mov	w0, #0x6
    8858:      	bl	0xa9a8 <__android_log_print@plt>
    885c:      	mov	w0, #-0x16
    8860:      	b	0x89d0 <AHardwareBuffer_lockPlanes+0x1d4>
    8864:      	mov	x0, x8
    8868:      	mov	x23, x1
    886c:      	mov	w20, w2
    8870:      	mov	x22, x3
    8874:      	bl	0xabb8 <_ZN7android13GraphicBuffer19fromAHardwareBufferEP15AHardwareBuffer@plt>
    8878:      	cbz	x22, 0x8884 <AHardwareBuffer_lockPlanes+0x88>
    887c:      	ldr	q0, [x22]
    8880:      	b	0x8898 <AHardwareBuffer_lockPlanes+0x9c>
    8884:      	mvni	v1.2s, #0x80, lsl #24
    8888:      	ldr	d2, [x0, #0x48]
    888c:      	movi	v0.2d, #0000000000000000
    8890:      	umin	v1.2s, v2.2s, v1.2s
    8894:      	mov	v0.d[1], v1.d[0]
    8898:      	movi	v1.2d, #0000000000000000
    889c:      	ldr	w22, [x0, #0x54]
    88a0:      	mov	w8, #0x3858
    88a4:      	movk	w8, #0x2020, lsl #16
    88a8:      	mov	x4, x19
    88ac:      	mov	x1, x23
    88b0:      	cmp	w22, w8
    88b4:      	str	q0, [sp, #0x10]
    88b8:      	str	q1, [x4, #0x8]!
    88bc:      	stp	q1, q1, [x4, #0x10]
    88c0:      	str	q1, [x4, #0x30]
    88c4:      	b.gt	0x8910 <AHardwareBuffer_lockPlanes+0x114>
    88c8:      	cmp	w22, #0x3c
    88cc:      	b.hi	0x8940 <AHardwareBuffer_lockPlanes+0x144>
    88d0:      	mov	x8, #0x130000
    88d4:      	movk	x8, #0x8, lsl #32
    88d8:      	movk	x8, #0x1040, lsl #48
    88dc:      	lsr	x8, x8, x22
    88e0:      	tbz	w8, #0x0, 0x8940 <AHardwareBuffer_lockPlanes+0x144>
    88e4:      	movi	v0.2d, #0000000000000000
    88e8:      	add	x2, sp, #0x10
    88ec:      	add	x3, sp, #0x20
    88f0:      	mov	w4, w20
    88f4:      	stp	q0, q0, [sp, #0x30]
    88f8:      	stp	q0, q0, [sp, #0x50]
    88fc:      	str	q0, [sp, #0x20]
    8900:      	bl	0xaa08 <_ZN7android13GraphicBuffer14lockAsyncYCbCrEjRKNS_4RectEP13android_ycbcri@plt>
    8904:      	cbz	w0, 0x8978 <AHardwareBuffer_lockPlanes+0x17c>
    8908:      	str	wzr, [x19]
    890c:      	b	0x89d0 <AHardwareBuffer_lockPlanes+0x1d4>
    8910:      	mov	w8, #0x3859
    8914:      	movk	w8, #0x2020, lsl #16
    8918:      	cmp	w22, w8
    891c:      	b.eq	0x88e4 <AHardwareBuffer_lockPlanes+0xe8>
    8920:      	mov	w8, #0x5659
    8924:      	movk	w8, #0x3231, lsl #16
    8928:      	cmp	w22, w8
    892c:      	b.eq	0x88e4 <AHardwareBuffer_lockPlanes+0xe8>
    8930:      	mov	w8, #0x3159
    8934:      	movk	w8, #0x2036, lsl #16
    8938:      	cmp	w22, w8
    893c:      	b.eq	0x88e4 <AHardwareBuffer_lockPlanes+0xe8>
    8940:      	add	x3, sp, #0x10
    8944:      	add	x6, sp, #0x20
    8948:      	add	x7, sp, #0xc
    894c:      	mov	x2, x1
    8950:      	mov	w5, w20
    8954:      	str	wzr, [sp, #0x20]
    8958:      	str	wzr, [sp, #0xc]
    895c:      	bl	0xa9d8 <_ZN7android13GraphicBuffer9lockAsyncEmmRKNS_4RectEPPviPiS6_@plt>
    8960:      	ldr	w9, [sp, #0x20]
    8964:      	ldr	w10, [sp, #0xc]
    8968:      	mov	w8, #0x1
    896c:      	str	w8, [x19]
    8970:      	stp	w9, w10, [x19, #0x10]
    8974:      	b	0x89d0 <AHardwareBuffer_lockPlanes+0x1d4>
    8978:      	ldr	x9, [sp, #0x20]
    897c:      	mov	w8, #0x3
    8980:      	cmp	w22, #0x3c
    8984:      	str	w8, [x19]
    8988:      	str	x9, [x19, #0x8]
    898c:      	b.hi	0x89a8 <AHardwareBuffer_lockPlanes+0x1ac>
    8990:      	mov	x8, #0x100000
    8994:      	movk	x8, #0x1040, lsl #48
    8998:      	lsr	x8, x8, x22
    899c:      	tbz	w8, #0x0, 0x89a8 <AHardwareBuffer_lockPlanes+0x1ac>
    89a0:      	mov	w8, #0x2
    89a4:      	b	0x89ac <AHardwareBuffer_lockPlanes+0x1b0>
    89a8:      	mov	w8, #0x1
    89ac:      	ldp	x9, x11, [sp, #0x30]
    89b0:      	ldr	w10, [sp, #0x48]
    89b4:      	stp	w8, w11, [x19, #0x10]
    89b8:      	ldr	x8, [sp, #0x28]
    89bc:      	str	x9, [x19, #0x28]
    89c0:      	str	x8, [x19, #0x18]
    89c4:      	ldr	w8, [sp, #0x40]
    89c8:      	stp	w10, w8, [x19, #0x20]
    89cc:      	stp	w10, w8, [x19, #0x30]
    89d0:      	ldr	x8, [x21, #0x28]
    89d4:      	ldur	x9, [x29, #-0x8]
    89d8:      	cmp	x8, x9
    89dc:      	b.ne	0x89fc <AHardwareBuffer_lockPlanes+0x200>
    89e0:      	ldp	x20, x19, [sp, #0xb0]
    89e4:      	ldr	x23, [sp, #0x90]
    89e8:      	ldp	x22, x21, [sp, #0xa0]
    89ec:      	ldp	x29, x30, [sp, #0x80]
    89f0:      	add	sp, sp, #0xc0
    89f4:      	autiasp
    89f8:      	ret
    89fc:      	bl	0xadb0 <__stack_chk_fail@plt>
    8a00:      	mov	w9, #0x3858
    8a04:      	mov	w8, w0
    8a08:      	movk	w9, #0x2020, lsl #16
    8a0c:      	cmp	w0, w9
    8a10:      	mov	w0, #0x1
    8a14:      	b.gt	0x8a3c <AHardwareBuffer_lockPlanes+0x240>
    8a18:      	cmp	w8, #0x3c
    8a1c:      	b.hi	0x8a6c <AHardwareBuffer_lockPlanes+0x270>
    8a20:      	mov	x9, #0x130000
    8a24:      	mov	w8, w8
    8a28:      	movk	x9, #0x8, lsl #32
    8a2c:      	movk	x9, #0x1040, lsl #48
    8a30:      	lsr	x8, x9, x8
    8a34:      	tbz	w8, #0x0, 0x8a6c <AHardwareBuffer_lockPlanes+0x270>
    8a38:      	ret
    8a3c:      	mov	w9, #0x3859
    8a40:      	movk	w9, #0x2020, lsl #16
    8a44:      	cmp	w8, w9
    8a48:      	b.eq	0x8a38 <AHardwareBuffer_lockPlanes+0x23c>
    8a4c:      	mov	w9, #0x3159
    8a50:      	movk	w9, #0x2036, lsl #16
    8a54:      	cmp	w8, w9
    8a58:      	b.eq	0x8a38 <AHardwareBuffer_lockPlanes+0x23c>
    8a5c:      	mov	w9, #0x5659
    8a60:      	movk	w9, #0x3231, lsl #16
    8a64:      	cmp	w8, w9
    8a68:      	b.eq	0x8a38 <AHardwareBuffer_lockPlanes+0x23c>
    8a6c:      	mov	w0, wzr
    8a70:      	ret

0000000000008a74 <AHardwareBuffer_unlock>:
    8a74:      	paciasp
    8a78:      	stp	x29, x30, [sp, #-0x20]!
    8a7c:      	str	x19, [sp, #0x10]
    8a80:      	mov	x29, sp
    8a84:      	cbz	x0, 0x8aa8 <AHardwareBuffer_unlock+0x34>
    8a88:      	mov	x19, x1
    8a8c:      	bl	0xabb8 <_ZN7android13GraphicBuffer19fromAHardwareBufferEP15AHardwareBuffer@plt>
    8a90:      	cbz	x19, 0x8abc <AHardwareBuffer_unlock+0x48>
    8a94:      	mov	x1, x19
    8a98:      	ldr	x19, [sp, #0x10]
    8a9c:      	ldp	x29, x30, [sp], #0x20
    8aa0:      	autiasp
    8aa4:      	b	0xaa20 <_ZN7android13GraphicBuffer11unlockAsyncEPi@plt>
    8aa8:      	mov	w0, #-0x16
    8aac:      	ldr	x19, [sp, #0x10]
    8ab0:      	ldp	x29, x30, [sp], #0x20
    8ab4:      	autiasp
    8ab8:      	ret
    8abc:      	ldr	x19, [sp, #0x10]
    8ac0:      	ldp	x29, x30, [sp], #0x20
    8ac4:      	autiasp
    8ac8:      	b	0xa9f0 <_ZN7android13GraphicBuffer6unlockEv@plt>

0000000000008acc <AHardwareBuffer_sendHandleToUnixSocket>:
    8acc:      	paciasp
    8ad0:      	stp	x29, x30, [sp, #-0x60]!
    8ad4:      	str	x28, [sp, #0x10]
    8ad8:      	stp	x26, x25, [sp, #0x20]
    8adc:      	stp	x24, x23, [sp, #0x30]
    8ae0:      	stp	x22, x21, [sp, #0x40]
    8ae4:      	stp	x20, x19, [sp, #0x50]
    8ae8:      	mov	x29, sp
    8aec:      	sub	sp, sp, #0x280
    8af0:      	mrs	x26, TPIDR_EL0
    8af4:      	ldr	x8, [x26, #0x28]
    8af8:      	stur	x8, [x29, #-0x8]
    8afc:      	cbz	x0, 0x8c5c <AHardwareBuffer_sendHandleToUnixSocket+0x190>
    8b00:      	mov	w20, w1
    8b04:      	bl	0xaba0 <_ZN7android13GraphicBuffer19fromAHardwareBufferEPK15AHardwareBuffer@plt>
    8b08:      	mov	x24, x0
    8b0c:      	bl	0xaa38 <_ZNK7android13GraphicBuffer16getFlattenedSizeEv@plt>
    8b10:      	mov	x23, x0
    8b14:      	mov	x0, x24
    8b18:      	bl	0xaa50 <_ZNK7android13GraphicBuffer10getFdCountEv@plt>
    8b1c:      	mov	x25, x0
    8b20:      	mov	x0, x23
    8b24:      	bl	0xaa68 <_Znam@plt>
    8b28:      	lsr	x8, x25, #62
    8b2c:      	lsl	x22, x25, #2
    8b30:      	mov	x19, x0
    8b34:      	cmp	x8, #0x0
    8b38:      	csinv	x0, x22, xzr, eq
    8b3c:      	bl	0xaa68 <_Znam@plt>
    8b40:      	mov	x21, x0
    8b44:      	stp	x0, x19, [sp, #0x38]
    8b48:      	add	x1, sp, #0x40
    8b4c:      	add	x2, sp, #0x50
    8b50:      	add	x3, sp, #0x38
    8b54:      	add	x4, sp, #0x48
    8b58:      	mov	x0, x24
    8b5c:      	stp	x25, x23, [sp, #0x48]
    8b60:      	bl	0xaa80 <_ZNK7android13GraphicBuffer7flattenERPvRmRPiS3_@plt>
    8b64:      	mov	w24, w0
    8b68:      	cbnz	w0, 0x8c68 <AHardwareBuffer_sendHandleToUnixSocket+0x19c>
    8b6c:      	movi	v0.2d, #0000000000000000
    8b70:      	add	x8, sp, #0x58
    8b74:      	mov	w9, #0x1
    8b78:      	stp	x19, x23, [x29, #-0x18]
    8b7c:      	add	x23, x22, #0x10
    8b80:      	mov	x1, x21
    8b84:      	mov	x2, x22
    8b88:      	mov	w3, #0x200
    8b8c:      	str	xzr, [sp, #0x30]
    8b90:      	str	x23, [sp, #0x58]
    8b94:      	stp	q0, q0, [x8, #0x30]
    8b98:      	stp	q0, q0, [x8, #0x50]
    8b9c:      	stp	q0, q0, [x8, #0x70]
    8ba0:      	stp	q0, q0, [x8, #0x90]
    8ba4:      	stp	q0, q0, [x8, #0xb0]
    8ba8:      	stp	q0, q0, [x8, #0xd0]
    8bac:      	stp	q0, q0, [x8, #0xf0]
    8bb0:      	stp	q0, q0, [x8, #0x110]
    8bb4:      	stp	q0, q0, [x8, #0x130]
    8bb8:      	stp	q0, q0, [x8, #0x150]
    8bbc:      	stp	q0, q0, [x8, #0x170]
    8bc0:      	stp	q0, q0, [x8, #0x190]
    8bc4:      	stp	q0, q0, [x8, #0x1b0]
    8bc8:      	stp	q0, q0, [x8, #0x1d0]
    8bcc:      	stp	q0, q0, [x8, #0x1f0]
    8bd0:      	sub	x8, x29, #0x18
    8bd4:      	stur	q0, [sp, #0x78]
    8bd8:      	stur	q0, [sp, #0x68]
    8bdc:      	stp	q0, q0, [sp, #0x10]
    8be0:      	str	q0, [sp]
    8be4:      	movi	v0.2s, #0x1
    8be8:      	stp	x8, x9, [sp, #0x10]
    8bec:      	add	x8, sp, #0x58
    8bf0:      	add	x0, x8, #0x10
    8bf4:      	str	x8, [sp, #0x20]
    8bf8:      	str	d0, [sp, #0x60]
    8bfc:      	bl	0xac48 <__memcpy_chk@plt>
    8c00:      	str	x23, [sp, #0x28]
    8c04:      	mov	x1, sp
    8c08:      	mov	w0, w20
    8c0c:      	mov	w2, wzr
    8c10:      	bl	0xaa98 <sendmsg@plt>
    8c14:      	cmn	w0, #0x1
    8c18:      	b.ne	0x8c64 <AHardwareBuffer_sendHandleToUnixSocket+0x198>
    8c1c:      	bl	0xaab0 <__errno@plt>
    8c20:      	ldr	w22, [x0]
    8c24:      	cmp	w22, #0x4
    8c28:      	b.eq	0x8c04 <AHardwareBuffer_sendHandleToUnixSocket+0x138>
    8c2c:      	mov	w0, w22
    8c30:      	bl	0xa9c0 <strerror@plt>
    8c34:      	mov	x4, x0
    8c38:      	adrp	x1, 0x3000
    8c3c:      	add	x1, x1, #0xac
    8c40:      	adrp	x2, 0x2000
    8c44:      	add	x2, x2, #0xe9b
    8c48:      	mov	w0, #0x6
    8c4c:      	mov	w3, w22
    8c50:      	bl	0xa9a8 <__android_log_print@plt>
    8c54:      	neg	w24, w22
    8c58:      	b	0x8c68 <AHardwareBuffer_sendHandleToUnixSocket+0x19c>
    8c5c:      	mov	w24, #-0x16
    8c60:      	b	0x8c78 <AHardwareBuffer_sendHandleToUnixSocket+0x1ac>
    8c64:      	mov	w24, wzr
    8c68:      	mov	x0, x21
    8c6c:      	bl	0xac60 <_ZdaPv@plt>
    8c70:      	mov	x0, x19
    8c74:      	bl	0xac60 <_ZdaPv@plt>
    8c78:      	ldr	x8, [x26, #0x28]
    8c7c:      	ldur	x9, [x29, #-0x8]
    8c80:      	cmp	x8, x9
    8c84:      	b.ne	0x8cb0 <AHardwareBuffer_sendHandleToUnixSocket+0x1e4>
    8c88:      	mov	w0, w24
    8c8c:      	add	sp, sp, #0x280
    8c90:      	ldp	x20, x19, [sp, #0x50]
    8c94:      	ldr	x28, [sp, #0x10]
    8c98:      	ldp	x22, x21, [sp, #0x40]
    8c9c:      	ldp	x24, x23, [sp, #0x30]
    8ca0:      	ldp	x26, x25, [sp, #0x20]
    8ca4:      	ldp	x29, x30, [sp], #0x60
    8ca8:      	autiasp
    8cac:      	ret
    8cb0:      	bl	0xadb0 <__stack_chk_fail@plt>

0000000000008cb4 <AHardwareBuffer_recvHandleFromUnixSocket>:
    8cb4:      	paciasp
    8cb8:      	stp	x29, x30, [sp, #-0x50]!
    8cbc:      	stp	x28, x25, [sp, #0x10]
    8cc0:      	stp	x24, x23, [sp, #0x20]
    8cc4:      	stp	x22, x21, [sp, #0x30]
    8cc8:      	stp	x20, x19, [sp, #0x40]
    8ccc:      	mov	x29, sp
    8cd0:      	sub	sp, sp, #0x290
    8cd4:      	mrs	x22, TPIDR_EL0
    8cd8:      	ldr	x8, [x22, #0x28]
    8cdc:      	stur	x8, [x29, #-0x8]
    8ce0:      	cbz	x1, 0x8d90 <AHardwareBuffer_recvHandleFromUnixSocket+0xdc>
    8ce4:      	mov	w20, w0
    8ce8:      	mov	w0, #0x4000
    8cec:      	mov	x23, x1
    8cf0:      	mov	w21, #0x4000
    8cf4:      	bl	0xaa68 <_Znam@plt>
    8cf8:      	mov	x19, x0
    8cfc:      	mov	w1, wzr
    8d00:      	add	x0, sp, #0x78
    8d04:      	mov	w2, #0x210
    8d08:      	mov	w24, #0x210
    8d0c:      	add	x25, sp, #0x78
    8d10:      	bl	0xadc8 <memset@plt>
    8d14:      	movi	v0.2d, #0000000000000000
    8d18:      	add	x8, sp, #0x68
    8d1c:      	mov	w9, #0x1
    8d20:      	stp	x19, x21, [sp, #0x68]
    8d24:      	stp	q0, q0, [sp, #0x40]
    8d28:      	str	q0, [sp, #0x30]
    8d2c:      	stp	x8, x9, [sp, #0x40]
    8d30:      	str	x25, [sp, #0x50]
    8d34:      	stp	x24, xzr, [sp, #0x58]
    8d38:      	add	x1, sp, #0x30
    8d3c:      	mov	w0, w20
    8d40:      	mov	w2, wzr
    8d44:      	bl	0xaac8 <recvmsg@plt>
    8d48:      	cmn	w0, #0x1
    8d4c:      	b.ne	0x8d98 <AHardwareBuffer_recvHandleFromUnixSocket+0xe4>
    8d50:      	bl	0xaab0 <__errno@plt>
    8d54:      	ldr	w21, [x0]
    8d58:      	cmp	w21, #0x4
    8d5c:      	b.eq	0x8d38 <AHardwareBuffer_recvHandleFromUnixSocket+0x84>
    8d60:      	mov	w0, w21
    8d64:      	bl	0xa9c0 <strerror@plt>
    8d68:      	mov	x4, x0
    8d6c:      	adrp	x1, 0x3000
    8d70:      	add	x1, x1, #0xac
    8d74:      	adrp	x2, 0x3000
    8d78:      	add	x2, x2, #0x52
    8d7c:      	mov	w0, #0x6
    8d80:      	mov	w3, w21
    8d84:      	bl	0xa9a8 <__android_log_print@plt>
    8d88:      	neg	w20, w21
    8d8c:      	b	0x8de0 <AHardwareBuffer_recvHandleFromUnixSocket+0x12c>
    8d90:      	mov	w20, #-0x16
    8d94:      	b	0x8de8 <AHardwareBuffer_recvHandleFromUnixSocket+0x134>
    8d98:      	ldr	x8, [sp, #0x48]
    8d9c:      	cmp	x8, #0x1
    8da0:      	b.ne	0x8dc4 <AHardwareBuffer_recvHandleFromUnixSocket+0x110>
    8da4:      	ldr	x8, [sp, #0x58]
    8da8:      	tst	x8, #0x3
    8dac:      	b.eq	0x8e1c <AHardwareBuffer_recvHandleFromUnixSocket+0x168>
    8db0:      	adrp	x1, 0x3000
    8db4:      	add	x1, x1, #0xac
    8db8:      	adrp	x2, 0x2000
    8dbc:      	add	x2, x2, #0xb88
    8dc0:      	b	0x8dd4 <AHardwareBuffer_recvHandleFromUnixSocket+0x120>
    8dc4:      	adrp	x1, 0x3000
    8dc8:      	add	x1, x1, #0xac
    8dcc:      	adrp	x2, 0x3000
    8dd0:      	add	x2, x2, #0x1f9
    8dd4:      	mov	w0, #0x6
    8dd8:      	bl	0xa9a8 <__android_log_print@plt>
    8ddc:      	mov	w20, #-0x26
    8de0:      	mov	x0, x19
    8de4:      	bl	0xac60 <_ZdaPv@plt>
    8de8:      	ldr	x8, [x22, #0x28]
    8dec:      	ldur	x9, [x29, #-0x8]
    8df0:      	cmp	x8, x9
    8df4:      	b.ne	0x8ee8 <AHardwareBuffer_recvHandleFromUnixSocket+0x234>
    8df8:      	mov	w0, w20
    8dfc:      	add	sp, sp, #0x290
    8e00:      	ldp	x20, x19, [sp, #0x40]
    8e04:      	ldp	x22, x21, [sp, #0x30]
    8e08:      	ldp	x24, x23, [sp, #0x20]
    8e0c:      	ldp	x28, x25, [sp, #0x10]
    8e10:      	ldp	x29, x30, [sp], #0x50
    8e14:      	autiasp
    8e18:      	ret
    8e1c:      	ldr	x9, [sp, #0x40]
    8e20:      	ldr	x10, [x9, #0x8]
    8e24:      	str	x10, [sp, #0x28]
    8e28:      	ldr	x9, [x9]
    8e2c:      	str	x9, [sp, #0x20]
    8e30:      	cbz	x9, 0x8ec0 <AHardwareBuffer_recvHandleFromUnixSocket+0x20c>
    8e34:      	cmp	x8, #0x10
    8e38:      	b.lo	0x8ed4 <AHardwareBuffer_recvHandleFromUnixSocket+0x220>
    8e3c:      	ldr	x9, [sp, #0x50]
    8e40:      	cbz	x9, 0x8ed4 <AHardwareBuffer_recvHandleFromUnixSocket+0x220>
    8e44:      	lsr	x8, x8, #2
    8e48:      	add	x9, x9, #0x10
    8e4c:      	mov	w0, #0xd30
    8e50:      	stp	x9, x8, [sp, #0x10]
    8e54:      	bl	0xa918 <_Znwm@plt>
    8e58:      	mov	x20, x0
    8e5c:      	bl	0xaae0 <_ZN7android13GraphicBufferC1Ev@plt>
    8e60:      	add	x1, sp, #0x8
    8e64:      	mov	x0, x20
    8e68:      	str	x20, [sp, #0x8]
    8e6c:      	bl	0xacc0 <_ZNK7android7RefBase9incStrongEPKv@plt>
    8e70:      	ldr	x0, [sp, #0x8]
    8e74:      	add	x1, sp, #0x20
    8e78:      	add	x2, sp, #0x28
    8e7c:      	add	x3, sp, #0x10
    8e80:      	add	x4, sp, #0x18
    8e84:      	bl	0xaaf8 <_ZN7android13GraphicBuffer9unflattenERPKvRmRPKiS4_@plt>
    8e88:      	mov	w20, w0
    8e8c:      	cbnz	w0, 0x8eac <AHardwareBuffer_recvHandleFromUnixSocket+0x1f8>
    8e90:      	ldr	x0, [sp, #0x8]
    8e94:      	bl	0xabe8 <_ZN7android13GraphicBuffer17toAHardwareBufferEv@plt>
    8e98:      	str	x0, [x23]
    8e9c:      	bl	0xabb8 <_ZN7android13GraphicBuffer19fromAHardwareBufferEP15AHardwareBuffer@plt>
    8ea0:      	adrp	x1, 0xc000
    8ea4:      	ldr	x1, [x1, #0x2a8]
    8ea8:      	bl	0xacc0 <_ZNK7android7RefBase9incStrongEPKv@plt>
    8eac:      	ldr	x0, [sp, #0x8]
    8eb0:      	cbz	x0, 0x8de0 <AHardwareBuffer_recvHandleFromUnixSocket+0x12c>
    8eb4:      	add	x1, sp, #0x8
    8eb8:      	bl	0xacd8 <_ZNK7android7RefBase9decStrongEPKv@plt>
    8ebc:      	b	0x8de0 <AHardwareBuffer_recvHandleFromUnixSocket+0x12c>
    8ec0:      	adrp	x1, 0x3000
    8ec4:      	add	x1, x1, #0xac
    8ec8:      	adrp	x2, 0x3000
    8ecc:      	add	x2, x2, #0x12f
    8ed0:      	b	0x8dd4 <AHardwareBuffer_recvHandleFromUnixSocket+0x120>
    8ed4:      	adrp	x1, 0x3000
    8ed8:      	add	x1, x1, #0xac
    8edc:      	adrp	x2, 0x2000
    8ee0:      	add	x2, x2, #0xefd
    8ee4:      	b	0x8dd4 <AHardwareBuffer_recvHandleFromUnixSocket+0x120>
    8ee8:      	bl	0xadb0 <__stack_chk_fail@plt>

0000000000008eec <AHardwareBuffer_isSupported>:
    8eec:      	paciasp
    8ef0:      	sub	sp, sp, #0x50
    8ef4:      	stp	x29, x30, [sp, #0x20]
    8ef8:      	str	x21, [sp, #0x30]
    8efc:      	stp	x20, x19, [sp, #0x40]
    8f00:      	add	x29, sp, #0x20
    8f04:      	mrs	x21, TPIDR_EL0
    8f08:      	ldr	x8, [x21, #0x28]
    8f0c:      	stur	x8, [x29, #-0x8]
    8f10:      	cbz	x0, 0x8f90 <AHardwareBuffer_isSupported+0xa4>
    8f14:      	mov	w1, wzr
    8f18:      	mov	x19, x0
    8f1c:      	bl	0x82c4 <AHardwareBuffer_allocate+0x2a4>
    8f20:      	tbz	w0, #0x0, 0x8f8c <AHardwareBuffer_isSupported+0xa0>
    8f24:      	mov	w0, #0xd30
    8f28:      	sturb	wzr, [x29, #-0xc]
    8f2c:      	bl	0xa918 <_Znwm@plt>
    8f30:      	mov	x20, x0
    8f34:      	bl	0xaae0 <_ZN7android13GraphicBufferC1Ev@plt>
    8f38:      	add	x1, sp, #0x8
    8f3c:      	mov	x0, x20
    8f40:      	str	x20, [sp, #0x8]
    8f44:      	bl	0xacc0 <_ZNK7android7RefBase9incStrongEPKv@plt>
    8f48:      	ldp	w1, w2, [x19]
    8f4c:      	ldp	w4, w3, [x19, #0x8]
    8f50:      	ldr	x0, [sp, #0x8]
    8f54:      	ldr	x5, [x19, #0x10]
    8f58:      	sub	x6, x29, #0xc
    8f5c:      	bl	0xab10 <_ZNK7android13GraphicBuffer11isSupportedEjjijmPb@plt>
    8f60:      	ldurb	w9, [x29, #-0xc]
    8f64:      	ldr	x8, [sp, #0x8]
    8f68:      	cmp	w0, #0x0
    8f6c:      	csel	w0, w9, wzr, eq
    8f70:      	cbz	x8, 0x8f90 <AHardwareBuffer_isSupported+0xa4>
    8f74:      	add	x1, sp, #0x8
    8f78:      	mov	w19, w0
    8f7c:      	mov	x0, x8
    8f80:      	bl	0xacd8 <_ZNK7android7RefBase9decStrongEPKv@plt>
    8f84:      	mov	w0, w19
    8f88:      	b	0x8f90 <AHardwareBuffer_isSupported+0xa4>
    8f8c:      	mov	w0, wzr
    8f90:      	ldr	x8, [x21, #0x28]
    8f94:      	ldur	x9, [x29, #-0x8]
    8f98:      	cmp	x8, x9
    8f9c:      	b.ne	0x8fb8 <AHardwareBuffer_isSupported+0xcc>
    8fa0:      	ldp	x20, x19, [sp, #0x40]
    8fa4:      	ldr	x21, [sp, #0x30]
    8fa8:      	ldp	x29, x30, [sp, #0x20]
    8fac:      	add	sp, sp, #0x50
    8fb0:      	autiasp
    8fb4:      	ret
    8fb8:      	bl	0xadb0 <__stack_chk_fail@plt>

0000000000008fbc <AHardwareBuffer_getId>:
    8fbc:      	bti	c
    8fc0:      	mov	x8, x0
    8fc4:      	mov	w0, #-0x16
    8fc8:      	cbz	x8, 0x9014 <AHardwareBuffer_getId+0x58>
    8fcc:      	paciasp
    8fd0:      	stp	x29, x30, [sp, #-0x20]!
    8fd4:      	str	x19, [sp, #0x10]
    8fd8:      	mov	x29, sp
    8fdc:      	mov	x19, x1
    8fe0:      	cbz	x1, 0x9008 <AHardwareBuffer_getId+0x4c>
    8fe4:      	mov	x0, x8
    8fe8:      	bl	0xaba0 <_ZN7android13GraphicBuffer19fromAHardwareBufferEPK15AHardwareBuffer@plt>
    8fec:      	cbz	x0, 0x9004 <AHardwareBuffer_getId+0x48>
    8ff0:      	mov	x8, x0
    8ff4:      	mov	w0, wzr
    8ff8:      	ldr	x8, [x8, #0xd8]
    8ffc:      	str	x8, [x19]
    9000:      	b	0x9008 <AHardwareBuffer_getId+0x4c>
    9004:      	mov	w0, #-0x16
    9008:      	ldr	x19, [sp, #0x10]
    900c:      	ldp	x29, x30, [sp], #0x20
    9010:      	autiasp
    9014:      	ret

0000000000009018 <AHardwareBuffer_readFromParcel>:
    9018:      	paciasp
    901c:      	sub	sp, sp, #0x50
    9020:      	stp	x29, x30, [sp, #0x20]
    9024:      	stp	x22, x21, [sp, #0x30]
    9028:      	stp	x20, x19, [sp, #0x40]
    902c:      	add	x29, sp, #0x20
    9030:      	mrs	x21, TPIDR_EL0
    9034:      	mov	x20, x0
    9038:      	mov	w0, #-0x16
    903c:      	ldr	x9, [x21, #0x28]
    9040:      	stur	x9, [x29, #-0x8]
    9044:      	cbz	x20, 0x90c4 <AHardwareBuffer_readFromParcel+0xac>
    9048:      	cbz	x1, 0x90c4 <AHardwareBuffer_readFromParcel+0xac>
    904c:      	mov	w0, #0xd30
    9050:      	mov	x22, x1
    9054:      	bl	0xa918 <_Znwm@plt>
    9058:      	mov	x19, x0
    905c:      	bl	0xaae0 <_ZN7android13GraphicBufferC1Ev@plt>
    9060:      	mov	x0, x19
    9064:      	mov	x1, x19
    9068:      	str	x19, [sp]
    906c:      	bl	0xacc0 <_ZNK7android7RefBase9incStrongEPKv@plt>
    9070:      	mov	x0, x20
    9074:      	bl	0xab28 <_Z26AParcel_viewPlatformParcelPK7AParcel@plt>
    9078:      	adrp	x8, 0xc000
    907c:      	add	x1, sp, #0x8
    9080:      	ldr	x8, [x8, #0x2b0]
    9084:      	add	x8, x8, #0x10
    9088:      	stp	x8, x19, [sp, #0x8]
    908c:      	bl	0xacf0 <_ZNK7android6Parcel4readERNS0_26FlattenableHelperInterfaceE@plt>
    9090:      	mov	w20, w0
    9094:      	cbnz	w0, 0x90b4 <AHardwareBuffer_readFromParcel+0x9c>
    9098:      	mov	x0, x19
    909c:      	bl	0xabe8 <_ZN7android13GraphicBuffer17toAHardwareBufferEv@plt>
    90a0:      	str	x0, [x22]
    90a4:      	bl	0xabb8 <_ZN7android13GraphicBuffer19fromAHardwareBufferEP15AHardwareBuffer@plt>
    90a8:      	adrp	x1, 0xc000
    90ac:      	ldr	x1, [x1, #0x2a8]
    90b0:      	bl	0xacc0 <_ZNK7android7RefBase9incStrongEPKv@plt>
    90b4:      	mov	x1, sp
    90b8:      	mov	x0, x19
    90bc:      	bl	0xacd8 <_ZNK7android7RefBase9decStrongEPKv@plt>
    90c0:      	mov	w0, w20
    90c4:      	ldr	x8, [x21, #0x28]
    90c8:      	ldur	x9, [x29, #-0x8]
    90cc:      	cmp	x8, x9
    90d0:      	b.ne	0x90ec <AHardwareBuffer_readFromParcel+0xd4>
    90d4:      	ldp	x20, x19, [sp, #0x40]
    90d8:      	ldp	x22, x21, [sp, #0x30]
    90dc:      	ldp	x29, x30, [sp, #0x20]
    90e0:      	add	sp, sp, #0x50
    90e4:      	autiasp
    90e8:      	ret
    90ec:      	bl	0xadb0 <__stack_chk_fail@plt>

00000000000090f0 <AHardwareBuffer_writeToParcel>:
    90f0:      	paciasp
    90f4:      	sub	sp, sp, #0x50
    90f8:      	stp	x29, x30, [sp, #0x20]
    90fc:      	str	x21, [sp, #0x30]
    9100:      	stp	x20, x19, [sp, #0x40]
    9104:      	add	x29, sp, #0x20
    9108:      	mrs	x21, TPIDR_EL0
    910c:      	mov	x19, x1
    9110:      	ldr	x8, [x21, #0x28]
    9114:      	stur	x8, [x29, #-0x8]
    9118:      	bl	0xaba0 <_ZN7android13GraphicBuffer19fromAHardwareBufferEPK15AHardwareBuffer@plt>
    911c:      	mov	x20, x0
    9120:      	mov	w0, #-0x16
    9124:      	cbz	x19, 0x914c <AHardwareBuffer_writeToParcel+0x5c>
    9128:      	cbz	x20, 0x914c <AHardwareBuffer_writeToParcel+0x5c>
    912c:      	mov	x0, x19
    9130:      	bl	0xab40 <_Z26AParcel_viewPlatformParcelP7AParcel@plt>
    9134:      	adrp	x8, 0xc000
    9138:      	add	x1, sp, #0x8
    913c:      	ldr	x8, [x8, #0x2b0]
    9140:      	add	x8, x8, #0x10
    9144:      	stp	x8, x20, [sp, #0x8]
    9148:      	bl	0xad08 <_ZN7android6Parcel5writeERKNS0_26FlattenableHelperInterfaceE@plt>
    914c:      	ldr	x8, [x21, #0x28]
    9150:      	ldur	x9, [x29, #-0x8]
    9154:      	cmp	x8, x9
    9158:      	b.ne	0x9174 <AHardwareBuffer_writeToParcel+0x84>
    915c:      	ldp	x20, x19, [sp, #0x40]
    9160:      	ldr	x21, [sp, #0x30]
    9164:      	ldp	x29, x30, [sp, #0x20]
    9168:      	add	sp, sp, #0x50
    916c:      	autiasp
    9170:      	ret
    9174:      	bl	0xadb0 <__stack_chk_fail@plt>

0000000000009178 <AHardwareBuffer_getDataSpace>:
    9178:      	paciasp
    917c:      	sub	sp, sp, #0x30
    9180:      	stp	x29, x30, [sp, #0x10]
    9184:      	str	x19, [sp, #0x20]
    9188:      	add	x29, sp, #0x10
    918c:      	mrs	x19, TPIDR_EL0
    9190:      	ldr	x8, [x19, #0x28]
    9194:      	str	x8, [sp, #0x8]
    9198:      	bl	0xaba0 <_ZN7android13GraphicBuffer19fromAHardwareBufferEPK15AHardwareBuffer@plt>
    919c:      	cbz	x0, 0x91b8 <AHardwareBuffer_getDataSpace+0x40>
    91a0:      	add	x1, sp, #0x4
    91a4:      	str	wzr, [sp, #0x4]
    91a8:      	bl	0xab58 <_ZNK7android13GraphicBuffer12getDataspaceEPNS_8hardware8graphics6common4V1_29DataspaceE@plt>
    91ac:      	ldr	w8, [sp, #0x4]
    91b0:      	cmp	w0, #0x0
    91b4:      	csel	w0, w8, wzr, eq
    91b8:      	ldr	x8, [x19, #0x28]
    91bc:      	ldr	x9, [sp, #0x8]
    91c0:      	cmp	x8, x9
    91c4:      	b.ne	0x91dc <AHardwareBuffer_getDataSpace+0x64>
    91c8:      	ldp	x29, x30, [sp, #0x10]
    91cc:      	ldr	x19, [sp, #0x20]
    91d0:      	add	sp, sp, #0x30
    91d4:      	autiasp
    91d8:      	ret
    91dc:      	bl	0xadb0 <__stack_chk_fail@plt>

00000000000091e0 <AHardwareBuffer_setDataSpace>:
    91e0:      	paciasp
    91e4:      	stp	x29, x30, [sp, #-0x30]!
    91e8:      	stp	x22, x21, [sp, #0x10]
    91ec:      	stp	x20, x19, [sp, #0x20]
    91f0:      	mov	x29, sp
    91f4:      	mov	w19, w1
    91f8:      	bl	0xabb8 <_ZN7android13GraphicBuffer19fromAHardwareBufferEP15AHardwareBuffer@plt>
    91fc:      	mov	x20, x0
    9200:      	adrp	x0, 0xc000
    9204:      	ldr	x0, [x0, #0x2b8]
    9208:      	bl	0xac90 <pthread_mutex_lock@plt>
    920c:      	adrp	x22, 0xc000
    9210:      	ldr	x22, [x22, #0x2c0]
    9214:      	ldr	x21, [x22]
    9218:      	cbnz	x21, 0x9230 <AHardwareBuffer_setDataSpace+0x50>
    921c:      	mov	w0, #0x10
    9220:      	bl	0xa918 <_Znwm@plt>
    9224:      	mov	x21, x0
    9228:      	bl	0xac78 <_ZN7android19GraphicBufferMapperC1Ev@plt>
    922c:      	str	x21, [x22]
    9230:      	adrp	x0, 0xc000
    9234:      	ldr	x0, [x0, #0x2b8]
    9238:      	bl	0xaca8 <pthread_mutex_unlock@plt>
    923c:      	ldr	x1, [x20, #0x70]
    9240:      	mov	x0, x21
    9244:      	mov	w2, w19
    9248:      	bl	0xab70 <_ZN7android19GraphicBufferMapper12setDataspaceEPK13native_handleNS_8hardware8graphics6common4V1_29DataspaceE@plt>
    924c:      	cmn	w0, #0x17
    9250:      	b.le	0x926c <AHardwareBuffer_setDataSpace+0x8c>
    9254:      	cmn	w0, #0x16
    9258:      	b.eq	0x9288 <AHardwareBuffer_setDataSpace+0xa8>
    925c:      	cmn	w0, #0xc
    9260:      	b.eq	0x9288 <AHardwareBuffer_setDataSpace+0xa8>
    9264:      	cbz	w0, 0x9288 <AHardwareBuffer_setDataSpace+0xa8>
    9268:      	b	0x9284 <AHardwareBuffer_setDataSpace+0xa4>
    926c:      	cmn	w0, #0x4a
    9270:      	b.eq	0x927c <AHardwareBuffer_setDataSpace+0x9c>
    9274:      	cmn	w0, #0x26
    9278:      	b.ne	0x9284 <AHardwareBuffer_setDataSpace+0xa4>
    927c:      	mov	w0, #-0x26
    9280:      	b	0x9288 <AHardwareBuffer_setDataSpace+0xa8>
    9284:      	mov	w0, #-0x80000000
    9288:      	ldp	x20, x19, [sp, #0x20]
    928c:      	ldp	x22, x21, [sp, #0x10]
    9290:      	ldp	x29, x30, [sp], #0x30
    9294:      	autiasp
    9298:      	ret

000000000000929c <AHardwareBuffer_getNativeHandle>:
    929c:      	bti	c
    92a0:      	cbz	x0, 0x92c0 <AHardwareBuffer_getNativeHandle+0x24>
    92a4:      	paciasp
    92a8:      	stp	x29, x30, [sp, #-0x10]!
    92ac:      	mov	x29, sp
    92b0:      	bl	0xaba0 <_ZN7android13GraphicBuffer19fromAHardwareBufferEPK15AHardwareBuffer@plt>
    92b4:      	ldr	x0, [x0, #0x70]
    92b8:      	ldp	x29, x30, [sp], #0x10
    92bc:      	autiasp
    92c0:      	ret

00000000000092c4 <AHardwareBuffer_createFromHandle>:
    92c4:      	paciasp
    92c8:      	sub	sp, sp, #0x70
    92cc:      	stp	x29, x30, [sp, #0x20]
    92d0:      	str	x25, [sp, #0x30]
    92d4:      	stp	x24, x23, [sp, #0x40]
    92d8:      	stp	x22, x21, [sp, #0x50]
    92dc:      	stp	x20, x19, [sp, #0x60]
    92e0:      	add	x29, sp, #0x20
    92e4:      	mrs	x24, TPIDR_EL0
    92e8:      	and	w9, w2, #0xfffffffe
    92ec:      	mov	x19, x0
    92f0:      	ldr	x8, [x24, #0x28]
    92f4:      	cmp	w9, #0x2
    92f8:      	mov	w0, #-0x16
    92fc:      	stur	x8, [x29, #-0x8]
    9300:      	b.ne	0x93e0 <AHardwareBuffer_createFromHandle+0x11c>
    9304:      	cbz	x19, 0x93e0 <AHardwareBuffer_createFromHandle+0x11c>
    9308:      	cbz	x1, 0x93e0 <AHardwareBuffer_createFromHandle+0x11c>
    930c:      	cbz	x3, 0x93e0 <AHardwareBuffer_createFromHandle+0x11c>
    9310:      	ldr	w8, [x19, #0x1c]
    9314:      	cbnz	w8, 0x93e0 <AHardwareBuffer_createFromHandle+0x11c>
    9318:      	ldr	x8, [x19, #0x20]
    931c:      	cbnz	x8, 0x93e0 <AHardwareBuffer_createFromHandle+0x11c>
    9320:      	ldr	w20, [x19, #0xc]
    9324:      	cmp	w20, #0x21
    9328:      	b.ne	0x9338 <AHardwareBuffer_createFromHandle+0x74>
    932c:      	ldr	w8, [x19, #0x4]
    9330:      	cmp	w8, #0x1
    9334:      	b.ne	0x93e0 <AHardwareBuffer_createFromHandle+0x11c>
    9338:      	ldr	x21, [x19, #0x10]
    933c:      	mov	w0, #0xd30
    9340:      	mov	x25, x3
    9344:      	mov	w22, w2
    9348:      	mov	x23, x1
    934c:      	bl	0xa918 <_Znwm@plt>
    9350:      	ldp	w3, w4, [x19]
    9354:      	ldr	w6, [x19, #0x8]
    9358:      	ldr	w8, [x19, #0x18]
    935c:      	mov	x1, x23
    9360:      	mov	w2, w22
    9364:      	mov	w5, w20
    9368:      	mov	x7, x21
    936c:      	mov	x19, x0
    9370:      	str	w8, [sp]
    9374:      	bl	0xab88 <_ZN7android13GraphicBufferC1EPK13native_handleNS0_16HandleWrapMethodEjjijmj@plt>
    9378:      	add	x1, sp, #0x10
    937c:      	mov	x0, x19
    9380:      	str	x19, [sp, #0x10]
    9384:      	bl	0xacc0 <_ZNK7android7RefBase9incStrongEPKv@plt>
    9388:      	ldr	x0, [sp, #0x10]
    938c:      	bl	0xa978 <_ZNK7android13GraphicBuffer9initCheckEv@plt>
    9390:      	cbnz	w0, 0x93c4 <AHardwareBuffer_createFromHandle+0x100>
    9394:      	ldr	x8, [sp, #0x10]
    9398:      	ldr	x9, [x8, #0x70]
    939c:      	cbz	x9, 0x93cc <AHardwareBuffer_createFromHandle+0x108>
    93a0:      	mov	w19, w0
    93a4:      	mov	x0, x8
    93a8:      	bl	0xabe8 <_ZN7android13GraphicBuffer17toAHardwareBufferEv@plt>
    93ac:      	str	x0, [x25]
    93b0:      	bl	0xabb8 <_ZN7android13GraphicBuffer19fromAHardwareBufferEP15AHardwareBuffer@plt>
    93b4:      	adrp	x1, 0xc000
    93b8:      	ldr	x1, [x1, #0x2a8]
    93bc:      	bl	0xacc0 <_ZNK7android7RefBase9incStrongEPKv@plt>
    93c0:      	mov	w0, w19
    93c4:      	ldr	x8, [sp, #0x10]
    93c8:      	cbz	x8, 0x93e0 <AHardwareBuffer_createFromHandle+0x11c>
    93cc:      	add	x1, sp, #0x10
    93d0:      	mov	w19, w0
    93d4:      	mov	x0, x8
    93d8:      	bl	0xacd8 <_ZNK7android7RefBase9decStrongEPKv@plt>
    93dc:      	mov	w0, w19
    93e0:      	ldr	x8, [x24, #0x28]
    93e4:      	ldur	x9, [x29, #-0x8]
    93e8:      	cmp	x8, x9
    93ec:      	b.ne	0x9410 <AHardwareBuffer_createFromHandle+0x14c>
    93f0:      	ldp	x20, x19, [sp, #0x60]
    93f4:      	ldr	x25, [sp, #0x30]
    93f8:      	ldp	x22, x21, [sp, #0x50]
    93fc:      	ldp	x24, x23, [sp, #0x40]
    9400:      	ldp	x29, x30, [sp, #0x20]
    9404:      	add	sp, sp, #0x70
    9408:      	autiasp
    940c:      	ret
    9410:      	bl	0xadb0 <__stack_chk_fail@plt>

0000000000009414 <AHardwareBuffer_allocateWithOptions>:
    9414:      	paciasp
    9418:      	sub	sp, sp, #0x140
    941c:      	stp	x29, x30, [sp, #0xe0]
    9420:      	stp	x28, x27, [sp, #0xf0]
    9424:      	stp	x26, x25, [sp, #0x100]
    9428:      	stp	x24, x23, [sp, #0x110]
    942c:      	stp	x22, x21, [sp, #0x120]
    9430:      	stp	x20, x19, [sp, #0x130]
    9434:      	add	x29, sp, #0xe0
    9438:      	mrs	x25, TPIDR_EL0
    943c:      	mov	w22, #-0x16
    9440:      	ldr	x8, [x25, #0x28]
    9444:      	stur	x8, [x29, #-0x10]
    9448:      	cbz	x0, 0x9770 <AHardwareBuffer_allocateWithOptions+0x35c>
    944c:      	cbz	x3, 0x9770 <AHardwareBuffer_allocateWithOptions+0x35c>
    9450:      	mov	x26, x1
    9454:      	mov	w1, #0x1
    9458:      	mov	x20, x2
    945c:      	mov	x19, x0
    9460:      	mov	x23, x3
    9464:      	bl	0x82c4 <AHardwareBuffer_allocate+0x2a4>
    9468:      	tbz	w0, #0x0, 0x9770 <AHardwareBuffer_allocateWithOptions+0x35c>
    946c:      	ldr	w24, [x19, #0xc]
    9470:      	ldr	x22, [x19, #0x10]
    9474:      	stp	xzr, xzr, [x29, #-0x30]
    9478:      	stur	xzr, [x29, #-0x20]
    947c:      	cbz	x20, 0x9508 <AHardwareBuffer_allocateWithOptions+0xf4>
    9480:      	lsr	x8, x20, #60
    9484:      	cbnz	x8, 0x97ac <AHardwareBuffer_allocateWithOptions+0x398>
    9488:      	lsl	x21, x20, #4
    948c:      	mov	x0, x21
    9490:      	bl	0xa918 <_Znwm@plt>
    9494:      	add	x26, x26, #0x8
    9498:      	add	x8, x0, x21
    949c:      	add	x21, sp, #0x28
    94a0:      	add	x27, sp, #0x40
    94a4:      	sub	x28, x29, #0x30
    94a8:      	stp	x0, x0, [x29, #-0x30]
    94ac:      	stur	x8, [x29, #-0x20]
    94b0:      	ldp	x8, x9, [x26, #-0x8]
    94b4:      	str	x0, [sp, #0x28]
    94b8:      	stp	x21, x27, [sp, #0x58]
    94bc:      	str	x28, [sp, #0x68]
    94c0:      	stp	x8, x9, [sp, #0x40]
    94c4:      	ldur	x8, [x29, #-0x20]
    94c8:      	cmp	x0, x8
    94cc:      	b.hs	0x94ec <AHardwareBuffer_allocateWithOptions+0xd8>
    94d0:      	ldr	q0, [sp, #0x40]
    94d4:      	str	q0, [x0], #0x10
    94d8:      	subs	x20, x20, #0x1
    94dc:      	add	x26, x26, #0x10
    94e0:      	stur	x0, [x29, #-0x28]
    94e4:      	b.ne	0x94b0 <AHardwareBuffer_allocateWithOptions+0x9c>
    94e8:      	b	0x94fc <AHardwareBuffer_allocateWithOptions+0xe8>
    94ec:      	add	x0, sp, #0x58
    94f0:      	bl	0x989c <_ZN7android38AHardwareBuffer_to_ANativeWindowBufferEP15AHardwareBuffer+0x68>
    94f4:      	ldr	x0, [sp, #0x28]
    94f8:      	b	0x94d8 <AHardwareBuffer_allocateWithOptions+0xc4>
    94fc:      	ldur	x8, [x29, #-0x30]
    9500:      	sub	x8, x0, x8
    9504:      	asr	x20, x8, #4
    9508:      	mov	w8, #0x1
    950c:      	ldr	d0, [x19]
    9510:      	nop
    9514:      	adr	x9, #-0x66c4
    9518:      	strb	w8, [sp, #0x58]
    951c:      	ldr	w8, [x19, #0x8]
    9520:      	stur	d0, [sp, #0x5c]
    9524:      	ldr	q0, [x9]
    9528:      	stp	w24, w8, [sp, #0x64]
    952c:      	mov	w8, #0x2a
    9530:      	strb	w8, [sp, #0x28]
    9534:      	ldur	x8, [x9, #0xd]
    9538:      	str	x22, [sp, #0x70]
    953c:      	stur	q0, [sp, #0x29]
    9540:      	stur	x8, [sp, #0x36]
    9544:      	strb	wzr, [sp, #0x3e]
    9548:      	bl	0xa948 <getpid@plt>
    954c:      	add	x8, sp, #0x10
    9550:      	add	x21, sp, #0x10
    9554:      	bl	0xa930 <_ZNSt3__19to_stringEi@plt>
    9558:      	ldrb	w8, [sp, #0x10]
    955c:      	ldp	x10, x9, [sp, #0x18]
    9560:      	add	x0, sp, #0x28
    9564:      	lsr	x11, x8, #1
    9568:      	tst	w8, #0x1
    956c:      	csinc	x1, x9, x21, ne
    9570:      	csel	x2, x10, x11, ne
    9574:      	bl	0xac00 <_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6appendEPKcm@plt>
    9578:      	ldr	q0, [x0]
    957c:      	ldr	x8, [x0, #0x10]
    9580:      	adrp	x1, 0x2000
    9584:      	add	x1, x1, #0xefb
    9588:      	mov	w2, #0x1
    958c:      	str	q0, [sp, #0x40]
    9590:      	str	x8, [sp, #0x50]
    9594:      	stp	xzr, xzr, [x0, #0x8]
    9598:      	str	xzr, [x0]
    959c:      	add	x0, sp, #0x40
    95a0:      	bl	0xac00 <_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6appendEPKcm@plt>
    95a4:      	ldr	q0, [x0]
    95a8:      	ldr	x8, [x0, #0x10]
    95ac:      	stur	q0, [sp, #0x78]
    95b0:      	str	x8, [sp, #0x88]
    95b4:      	stp	xzr, xzr, [x0, #0x8]
    95b8:      	str	xzr, [x0]
    95bc:      	mov	w0, #0xd30
    95c0:      	ldur	q0, [x29, #-0x30]
    95c4:      	ldur	x8, [x29, #-0x20]
    95c8:      	stp	xzr, xzr, [x29, #-0x28]
    95cc:      	stur	xzr, [x29, #-0x30]
    95d0:      	stur	q0, [sp, #0x90]
    95d4:      	str	x8, [sp, #0xa0]
    95d8:      	bl	0xa918 <_Znwm@plt>
    95dc:      	add	x1, sp, #0x58
    95e0:      	mov	x21, x0
    95e4:      	bl	0xad20 <_ZN7android13GraphicBufferC1ERKNS_22GraphicBufferAllocator17AllocationRequestE@plt>
    95e8:      	mov	x0, x21
    95ec:      	mov	x1, x21
    95f0:      	stur	x21, [x29, #-0x38]
    95f4:      	bl	0xacc0 <_ZNK7android7RefBase9incStrongEPKv@plt>
    95f8:      	ldr	x0, [sp, #0x90]
    95fc:      	cbz	x0, 0x9610 <AHardwareBuffer_allocateWithOptions+0x1fc>
    9600:      	ldr	x8, [sp, #0xa0]
    9604:      	str	x0, [sp, #0x98]
    9608:      	sub	x1, x8, x0
    960c:      	bl	0xac30 <_ZdlPvm@plt>
    9610:      	ldrb	w8, [sp, #0x78]
    9614:      	tbnz	w8, #0x0, 0x9684 <AHardwareBuffer_allocateWithOptions+0x270>
    9618:      	ldrb	w8, [sp, #0x40]
    961c:      	tbnz	w8, #0x0, 0x969c <AHardwareBuffer_allocateWithOptions+0x288>
    9620:      	ldrb	w8, [sp, #0x10]
    9624:      	tbnz	w8, #0x0, 0x96b4 <AHardwareBuffer_allocateWithOptions+0x2a0>
    9628:      	ldrb	w8, [sp, #0x28]
    962c:      	tbz	w8, #0x0, 0x9640 <AHardwareBuffer_allocateWithOptions+0x22c>
    9630:      	ldr	x8, [sp, #0x28]
    9634:      	ldr	x0, [sp, #0x38]
    9638:      	and	x1, x8, #0xfffffffffffffffe
    963c:      	bl	0xac30 <_ZdlPvm@plt>
    9640:      	mov	x0, x21
    9644:      	bl	0xa978 <_ZNK7android13GraphicBuffer9initCheckEv@plt>
    9648:      	mov	w22, w0
    964c:      	cmn	w0, #0xc
    9650:      	b.eq	0x96d0 <AHardwareBuffer_allocateWithOptions+0x2bc>
    9654:      	cbnz	w22, 0x96d4 <AHardwareBuffer_allocateWithOptions+0x2c0>
    9658:      	ldr	x8, [x21, #0x70]
    965c:      	cbz	x8, 0x96d4 <AHardwareBuffer_allocateWithOptions+0x2c0>
    9660:      	mov	x0, x21
    9664:      	bl	0xabe8 <_ZN7android13GraphicBuffer17toAHardwareBufferEv@plt>
    9668:      	str	x0, [x23]
    966c:      	bl	0xabb8 <_ZN7android13GraphicBuffer19fromAHardwareBufferEP15AHardwareBuffer@plt>
    9670:      	adrp	x1, 0xc000
    9674:      	ldr	x1, [x1, #0x2a8]
    9678:      	bl	0xacc0 <_ZNK7android7RefBase9incStrongEPKv@plt>
    967c:      	mov	w22, wzr
    9680:      	b	0x974c <AHardwareBuffer_allocateWithOptions+0x338>
    9684:      	ldr	x8, [sp, #0x78]
    9688:      	ldr	x0, [sp, #0x88]
    968c:      	and	x1, x8, #0xfffffffffffffffe
    9690:      	bl	0xac30 <_ZdlPvm@plt>
    9694:      	ldrb	w8, [sp, #0x40]
    9698:      	tbz	w8, #0x0, 0x9620 <AHardwareBuffer_allocateWithOptions+0x20c>
    969c:      	ldr	x8, [sp, #0x40]
    96a0:      	ldr	x0, [sp, #0x50]
    96a4:      	and	x1, x8, #0xfffffffffffffffe
    96a8:      	bl	0xac30 <_ZdlPvm@plt>
    96ac:      	ldrb	w8, [sp, #0x10]
    96b0:      	tbz	w8, #0x0, 0x9628 <AHardwareBuffer_allocateWithOptions+0x214>
    96b4:      	ldr	x8, [sp, #0x10]
    96b8:      	ldr	x0, [sp, #0x20]
    96bc:      	and	x1, x8, #0xfffffffffffffffe
    96c0:      	bl	0xac30 <_ZdlPvm@plt>
    96c4:      	ldrb	w8, [sp, #0x28]
    96c8:      	tbnz	w8, #0x0, 0x9630 <AHardwareBuffer_allocateWithOptions+0x21c>
    96cc:      	b	0x9640 <AHardwareBuffer_allocateWithOptions+0x22c>
    96d0:      	bl	0xa990 <_ZN7android13GraphicBuffer26dumpAllocationsToSystemLogEv@plt>
    96d4:      	ldp	w23, w24, [x19]
    96d8:      	ldr	w19, [x19, #0x8]
    96dc:      	neg	w0, w22
    96e0:      	bl	0xa9c0 <strerror@plt>
    96e4:      	ldr	x8, [x21, #0x70]
    96e8:      	mov	x7, x0
    96ec:      	adrp	x1, 0x3000
    96f0:      	add	x1, x1, #0xac
    96f4:      	adrp	x2, 0x2000
    96f8:      	add	x2, x2, #0xd5d
    96fc:      	mov	w0, #0x6
    9700:      	mov	w3, w23
    9704:      	mov	w4, w24
    9708:      	mov	w5, w19
    970c:      	mov	x6, x20
    9710:      	str	x8, [sp]
    9714:      	bl	0xa9a8 <__android_log_print@plt>
    9718:      	cmn	w22, #0x17
    971c:      	b.gt	0x9738 <AHardwareBuffer_allocateWithOptions+0x324>
    9720:      	cmn	w22, #0x4a
    9724:      	b.eq	0x9730 <AHardwareBuffer_allocateWithOptions+0x31c>
    9728:      	cmn	w22, #0x26
    972c:      	b.ne	0x9748 <AHardwareBuffer_allocateWithOptions+0x334>
    9730:      	mov	w22, #-0x26
    9734:      	b	0x974c <AHardwareBuffer_allocateWithOptions+0x338>
    9738:      	cmn	w22, #0x16
    973c:      	b.eq	0x974c <AHardwareBuffer_allocateWithOptions+0x338>
    9740:      	cmn	w22, #0xc
    9744:      	b.eq	0x974c <AHardwareBuffer_allocateWithOptions+0x338>
    9748:      	mov	w22, #-0x80000000
    974c:      	sub	x1, x29, #0x38
    9750:      	mov	x0, x21
    9754:      	bl	0xacd8 <_ZNK7android7RefBase9decStrongEPKv@plt>
    9758:      	ldur	x0, [x29, #-0x30]
    975c:      	cbz	x0, 0x9770 <AHardwareBuffer_allocateWithOptions+0x35c>
    9760:      	ldur	x8, [x29, #-0x20]
    9764:      	stur	x0, [x29, #-0x28]
    9768:      	sub	x1, x8, x0
    976c:      	bl	0xac30 <_ZdlPvm@plt>
    9770:      	ldr	x8, [x25, #0x28]
    9774:      	ldur	x9, [x29, #-0x10]
    9778:      	cmp	x8, x9
    977c:      	b.ne	0x97a8 <AHardwareBuffer_allocateWithOptions+0x394>
    9780:      	mov	w0, w22
    9784:      	ldp	x20, x19, [sp, #0x130]
    9788:      	ldp	x22, x21, [sp, #0x120]
    978c:      	ldp	x24, x23, [sp, #0x110]
    9790:      	ldp	x26, x25, [sp, #0x100]
    9794:      	ldp	x28, x27, [sp, #0xf0]
    9798:      	ldp	x29, x30, [sp, #0xe0]
    979c:      	add	sp, sp, #0x140
    97a0:      	autiasp
    97a4:      	ret
    97a8:      	bl	0xadb0 <__stack_chk_fail@plt>
    97ac:      	bl	0x9884 <_ZN7android38AHardwareBuffer_to_ANativeWindowBufferEP15AHardwareBuffer+0x50>

00000000000097b0 <_ZN7android28AHardwareBuffer_getDataSpaceEP15AHardwareBuffer>:
    97b0:      	paciasp
    97b4:      	sub	sp, sp, #0x30
    97b8:      	stp	x29, x30, [sp, #0x10]
    97bc:      	str	x19, [sp, #0x20]
    97c0:      	add	x29, sp, #0x10
    97c4:      	mrs	x19, TPIDR_EL0
    97c8:      	ldr	x8, [x19, #0x28]
    97cc:      	str	x8, [sp, #0x8]
    97d0:      	bl	0xaba0 <_ZN7android13GraphicBuffer19fromAHardwareBufferEPK15AHardwareBuffer@plt>
    97d4:      	cbz	x0, 0x97f0 <_ZN7android28AHardwareBuffer_getDataSpaceEP15AHardwareBuffer+0x40>
    97d8:      	add	x1, sp, #0x4
    97dc:      	str	wzr, [sp, #0x4]
    97e0:      	bl	0xab58 <_ZNK7android13GraphicBuffer12getDataspaceEPNS_8hardware8graphics6common4V1_29DataspaceE@plt>
    97e4:      	ldr	w8, [sp, #0x4]
    97e8:      	cmp	w0, #0x0
    97ec:      	csel	w0, w8, wzr, eq
    97f0:      	ldr	x8, [x19, #0x28]
    97f4:      	ldr	x9, [sp, #0x8]
    97f8:      	cmp	x8, x9
    97fc:      	b.ne	0x9814 <_ZN7android28AHardwareBuffer_getDataSpaceEP15AHardwareBuffer+0x64>
    9800:      	ldp	x29, x30, [sp, #0x10]
    9804:      	ldr	x19, [sp, #0x20]
    9808:      	add	sp, sp, #0x30
    980c:      	autiasp
    9810:      	ret
    9814:      	bl	0xadb0 <__stack_chk_fail@plt>

0000000000009818 <_ZN7android38AHardwareBuffer_to_ANativeWindowBufferEPK15AHardwareBuffer>:
    9818:      	paciasp
    981c:      	stp	x29, x30, [sp, #-0x10]!
    9820:      	mov	x29, sp
    9824:      	bl	0xaba0 <_ZN7android13GraphicBuffer19fromAHardwareBufferEPK15AHardwareBuffer@plt>
    9828:      	ldp	x29, x30, [sp], #0x10
    982c:      	autiasp
    9830:      	b	0xabd0 <_ZNK7android13GraphicBuffer15getNativeBufferEv@plt>

0000000000009834 <_ZN7android38AHardwareBuffer_to_ANativeWindowBufferEP15AHardwareBuffer>:
    9834:      	paciasp
    9838:      	stp	x29, x30, [sp, #-0x10]!
    983c:      	mov	x29, sp
    9840:      	bl	0xabb8 <_ZN7android13GraphicBuffer19fromAHardwareBufferEP15AHardwareBuffer@plt>
    9844:      	ldp	x29, x30, [sp], #0x10
    9848:      	autiasp
    984c:      	b	0xabd0 <_ZNK7android13GraphicBuffer15getNativeBufferEv@plt>
    9850:      	paciasp
    9854:      	stp	x29, x30, [sp, #-0x10]!
    9858:      	mov	x29, sp
    985c:      	adrp	x0, 0x3000
    9860:      	add	x0, x0, #0x35c
    9864:      	bl	0xac18 <_ZNSt3__122__libcpp_verbose_abortEPKcz@plt>
    9868:      	paciasp
    986c:      	stp	x29, x30, [sp, #-0x10]!
    9870:      	mov	x29, sp
    9874:      	mov	x1, x0
    9878:      	adrp	x0, 0x2000
    987c:      	add	x0, x0, #0xcb7
    9880:      	bl	0xac18 <_ZNSt3__122__libcpp_verbose_abortEPKcz@plt>
    9884:      	paciasp
    9888:      	stp	x29, x30, [sp, #-0x10]!
    988c:      	mov	x29, sp
    9890:      	adrp	x0, 0x3000
    9894:      	add	x0, x0, #0x8c
    9898:      	bl	0x9868 <_ZN7android38AHardwareBuffer_to_ANativeWindowBufferEP15AHardwareBuffer+0x34>
    989c:      	paciasp
    98a0:      	stp	x29, x30, [sp, #-0x50]!
    98a4:      	stp	x26, x25, [sp, #0x10]
    98a8:      	stp	x24, x23, [sp, #0x20]
    98ac:      	stp	x22, x21, [sp, #0x30]
    98b0:      	stp	x20, x19, [sp, #0x40]
    98b4:      	mov	x29, sp
    98b8:      	ldr	x25, [x0, #0x10]
    98bc:      	ldp	x20, x8, [x25]
    98c0:      	sub	x22, x8, x20
    98c4:      	asr	x24, x22, #4
    98c8:      	add	x8, x24, #0x1
    98cc:      	lsr	x9, x8, #60
    98d0:      	cbnz	x9, 0x9978 <_ZN7android38AHardwareBuffer_to_ANativeWindowBufferEP15AHardwareBuffer+0x144>
    98d4:      	ldr	x9, [x25, #0x10]
    98d8:      	mov	x10, #0x7ffffffffffffff0
    98dc:      	sub	x21, x9, x20
    98e0:      	asr	x9, x21, #3
    98e4:      	cmp	x9, x8
    98e8:      	csel	x8, x9, x8, hi
    98ec:      	cmp	x21, x10
    98f0:      	mov	x9, #0xfffffffffffffff
    98f4:      	csel	x8, x8, x9, lo
    98f8:      	lsr	x9, x8, #60
    98fc:      	cbnz	x9, 0x997c <_ZN7android38AHardwareBuffer_to_ANativeWindowBufferEP15AHardwareBuffer+0x148>
    9900:      	lsl	x23, x8, #4
    9904:      	mov	x19, x0
    9908:      	ldr	x26, [x0, #0x8]
    990c:      	mov	x0, x23
    9910:      	bl	0xa918 <_Znwm@plt>
    9914:      	add	x8, x0, x22
    9918:      	ldr	q0, [x26]
    991c:      	add	x26, x0, x23
    9920:      	sub	x24, x8, x24, lsl #4
    9924:      	mov	x1, x20
    9928:      	mov	x2, x22
    992c:      	str	q0, [x8]
    9930:      	add	x23, x8, #0x10
    9934:      	mov	x0, x24
    9938:      	bl	0xade0 <memcpy@plt>
    993c:      	stp	x24, x23, [x25]
    9940:      	str	x26, [x25, #0x10]
    9944:      	cbz	x20, 0x9954 <_ZN7android38AHardwareBuffer_to_ANativeWindowBufferEP15AHardwareBuffer+0x120>
    9948:      	mov	x0, x20
    994c:      	mov	x1, x21
    9950:      	bl	0xac30 <_ZdlPvm@plt>
    9954:      	ldr	x8, [x19]
    9958:      	str	x23, [x8]
    995c:      	ldp	x20, x19, [sp, #0x40]
    9960:      	ldp	x22, x21, [sp, #0x30]
    9964:      	ldp	x24, x23, [sp, #0x20]
    9968:      	ldp	x26, x25, [sp, #0x10]
    996c:      	ldp	x29, x30, [sp], #0x50
    9970:      	autiasp
    9974:      	ret
    9978:      	bl	0x9884 <_ZN7android38AHardwareBuffer_to_ANativeWindowBufferEP15AHardwareBuffer+0x50>
    997c:      	bl	0x9850 <_ZN7android38AHardwareBuffer_to_ANativeWindowBufferEP15AHardwareBuffer+0x1c>
    9980:      	bti	c
    9984:      	ldr	x0, [x0, #0x8]
    9988:      	b	0xaa38 <_ZNK7android13GraphicBuffer16getFlattenedSizeEv@plt>
    998c:      	bti	c
    9990:      	ldr	x0, [x0, #0x8]
    9994:      	b	0xaa50 <_ZNK7android13GraphicBuffer10getFdCountEv@plt>
    9998:      	paciasp
    999c:      	sub	sp, sp, #0x50
    99a0:      	stp	x29, x30, [sp, #0x30]
    99a4:      	str	x19, [sp, #0x40]
    99a8:      	add	x29, sp, #0x30
    99ac:      	mrs	x19, TPIDR_EL0
    99b0:      	ldr	x8, [x19, #0x28]
    99b4:      	stur	x8, [x29, #-0x8]
    99b8:      	ldr	x0, [x0, #0x8]
    99bc:      	stur	x1, [x29, #-0x10]
    99c0:      	sub	x1, x29, #0x10
    99c4:      	stp	x3, x2, [sp, #0x10]
    99c8:      	add	x2, sp, #0x18
    99cc:      	add	x3, sp, #0x10
    99d0:      	str	x4, [sp, #0x8]
    99d4:      	add	x4, sp, #0x8
    99d8:      	bl	0xaa80 <_ZNK7android13GraphicBuffer7flattenERPvRmRPiS3_@plt>
    99dc:      	ldr	x8, [x19, #0x28]
    99e0:      	ldur	x9, [x29, #-0x8]
    99e4:      	cmp	x8, x9
    99e8:      	b.ne	0x9a00 <_ZN7android38AHardwareBuffer_to_ANativeWindowBufferEP15AHardwareBuffer+0x1cc>
    99ec:      	ldp	x29, x30, [sp, #0x30]
    99f0:      	ldr	x19, [sp, #0x40]
    99f4:      	add	sp, sp, #0x50
    99f8:      	autiasp
    99fc:      	ret
    9a00:      	bl	0xadb0 <__stack_chk_fail@plt>
    9a04:      	paciasp
    9a08:      	sub	sp, sp, #0x50
    9a0c:      	stp	x29, x30, [sp, #0x30]
    9a10:      	str	x19, [sp, #0x40]
    9a14:      	add	x29, sp, #0x30
    9a18:      	mrs	x19, TPIDR_EL0
    9a1c:      	ldr	x8, [x19, #0x28]
    9a20:      	stur	x8, [x29, #-0x8]
    9a24:      	ldr	x0, [x0, #0x8]
    9a28:      	stur	x1, [x29, #-0x10]
    9a2c:      	sub	x1, x29, #0x10
    9a30:      	stp	x3, x2, [sp, #0x10]
    9a34:      	add	x2, sp, #0x18
    9a38:      	add	x3, sp, #0x10
    9a3c:      	str	x4, [sp, #0x8]
    9a40:      	add	x4, sp, #0x8
    9a44:      	bl	0xaaf8 <_ZN7android13GraphicBuffer9unflattenERPKvRmRPKiS4_@plt>
    9a48:      	ldr	x8, [x19, #0x28]
    9a4c:      	ldur	x9, [x29, #-0x8]
    9a50:      	cmp	x8, x9
    9a54:      	b.ne	0x9a6c <_ZN7android38AHardwareBuffer_to_ANativeWindowBufferEP15AHardwareBuffer+0x238>
    9a58:      	ldp	x29, x30, [sp, #0x30]
    9a5c:      	ldr	x19, [sp, #0x40]
    9a60:      	add	sp, sp, #0x50
    9a64:      	autiasp
    9a68:      	ret
    9a6c:      	bl	0xadb0 <__stack_chk_fail@plt>
    9a70:      	paciasp
    9a74:      	stp	x29, x30, [sp, #-0x20]!
    9a78:      	stp	x20, x19, [sp, #0x10]
    9a7c:      	mov	x29, sp
    9a80:      	adrp	x0, 0x3000
    9a84:      	add	x0, x0, #0x125
    9a88:      	mov	w1, #0x2
    9a8c:      	bl	0xad68 <dlopen@plt>
    9a90:      	cbz	x0, 0x9ad8 <_ZN7android38AHardwareBuffer_to_ANativeWindowBufferEP15AHardwareBuffer+0x2a4>
    9a94:      	adrp	x1, 0x2000
    9a98:      	add	x1, x1, #0xf35
    9a9c:      	mov	x19, x0
    9aa0:      	bl	0xad98 <dlsym@plt>
    9aa4:      	cbz	x0, 0x9af4 <_ZN7android38AHardwareBuffer_to_ANativeWindowBufferEP15AHardwareBuffer+0x2c0>
    9aa8:      	mov	x20, x0
    9aac:      	adrp	x1, 0x2000
    9ab0:      	add	x1, x1, #0xdf4
    9ab4:      	mov	x0, x19
    9ab8:      	bl	0xad98 <dlsym@plt>
    9abc:      	cbz	x0, 0x9b10 <_ZN7android38AHardwareBuffer_to_ANativeWindowBufferEP15AHardwareBuffer+0x2dc>
    9ac0:      	mov	x1, x0
    9ac4:      	mov	x0, x20
    9ac8:      	ldp	x20, x19, [sp, #0x10]
    9acc:      	ldp	x29, x30, [sp], #0x20
    9ad0:      	autiasp
    9ad4:      	ret
    9ad8:      	adrp	x0, 0x2000
    9adc:      	add	x0, x0, #0xcb3
    9ae0:      	nop
    9ae4:      	adr	x1, #-0x6f23
    9ae8:      	adrp	x2, 0x3000
    9aec:      	add	x2, x2, #0x93
    9af0:      	bl	0xad80 <__android_log_assert@plt>
    9af4:      	adrp	x0, 0x2000
    9af8:      	add	x0, x0, #0xfc6
    9afc:      	nop
    9b00:      	adr	x1, #-0x6f3f
    9b04:      	adrp	x2, 0x2000
    9b08:      	add	x2, x2, #0xbcf
    9b0c:      	bl	0xad80 <__android_log_assert@plt>
    9b10:      	adrp	x0, 0x2000
    9b14:      	add	x0, x0, #0xe91
    9b18:      	nop
    9b1c:      	adr	x1, #-0x6f5b
    9b20:      	adrp	x2, 0x3000
    9b24:      	add	x2, x2, #0x6
    9b28:      	bl	0xad80 <__android_log_assert@plt>

0000000000009b2c <ANativeWindow_acquire>:
    9b2c:      	bti	c
    9b30:      	ldr	x16, [x0, #0x28]
    9b34:      	br	x16

0000000000009b38 <ANativeWindow_release>:
    9b38:      	bti	c
    9b3c:      	ldr	x16, [x0, #0x30]
    9b40:      	br	x16

0000000000009b44 <ANativeWindow_getWidth>:
    9b44:      	paciasp
    9b48:      	sub	sp, sp, #0x30
    9b4c:      	stp	x29, x30, [sp, #0x10]
    9b50:      	str	x19, [sp, #0x20]
    9b54:      	add	x29, sp, #0x10
    9b58:      	mrs	x19, TPIDR_EL0
    9b5c:      	add	x2, sp, #0x4
    9b60:      	mov	w1, wzr
    9b64:      	ldr	x8, [x19, #0x28]
    9b68:      	str	x8, [sp, #0x8]
    9b6c:      	ldr	x8, [x0, #0x90]
    9b70:      	str	wzr, [sp, #0x4]
    9b74:      	blr	x8
    9b78:      	ldr	w8, [sp, #0x4]
    9b7c:      	ldr	x9, [x19, #0x28]
    9b80:      	cmp	w0, #0x0
    9b84:      	ldr	x10, [sp, #0x8]
    9b88:      	csel	w0, w0, w8, mi
    9b8c:      	cmp	x9, x10
    9b90:      	b.ne	0x9ba8 <ANativeWindow_getWidth+0x64>
    9b94:      	ldp	x29, x30, [sp, #0x10]
    9b98:      	ldr	x19, [sp, #0x20]
    9b9c:      	add	sp, sp, #0x30
    9ba0:      	autiasp
    9ba4:      	ret
    9ba8:      	bl	0xadb0 <__stack_chk_fail@plt>

0000000000009bac <ANativeWindow_getHeight>:
    9bac:      	paciasp
    9bb0:      	sub	sp, sp, #0x30
    9bb4:      	stp	x29, x30, [sp, #0x10]
    9bb8:      	str	x19, [sp, #0x20]
    9bbc:      	add	x29, sp, #0x10
    9bc0:      	mrs	x19, TPIDR_EL0
    9bc4:      	add	x2, sp, #0x4
    9bc8:      	mov	w1, #0x1
    9bcc:      	ldr	x8, [x19, #0x28]
    9bd0:      	str	x8, [sp, #0x8]
    9bd4:      	ldr	x8, [x0, #0x90]
    9bd8:      	str	wzr, [sp, #0x4]
    9bdc:      	blr	x8
    9be0:      	ldr	w8, [sp, #0x4]
    9be4:      	ldr	x9, [x19, #0x28]
    9be8:      	cmp	w0, #0x0
    9bec:      	ldr	x10, [sp, #0x8]
    9bf0:      	csel	w0, w0, w8, mi
    9bf4:      	cmp	x9, x10
    9bf8:      	b.ne	0x9c10 <ANativeWindow_getHeight+0x64>
    9bfc:      	ldp	x29, x30, [sp, #0x10]
    9c00:      	ldr	x19, [sp, #0x20]
    9c04:      	add	sp, sp, #0x30
    9c08:      	autiasp
    9c0c:      	ret
    9c10:      	bl	0xadb0 <__stack_chk_fail@plt>

0000000000009c14 <ANativeWindow_getFormat>:
    9c14:      	paciasp
    9c18:      	sub	sp, sp, #0x30
    9c1c:      	stp	x29, x30, [sp, #0x10]
    9c20:      	str	x19, [sp, #0x20]
    9c24:      	add	x29, sp, #0x10
    9c28:      	mrs	x19, TPIDR_EL0
    9c2c:      	add	x2, sp, #0x4
    9c30:      	mov	w1, #0x2
    9c34:      	ldr	x8, [x19, #0x28]
    9c38:      	str	x8, [sp, #0x8]
    9c3c:      	ldr	x8, [x0, #0x90]
    9c40:      	str	wzr, [sp, #0x4]
    9c44:      	blr	x8
    9c48:      	ldr	w8, [sp, #0x4]
    9c4c:      	ldr	x9, [x19, #0x28]
    9c50:      	cmp	w0, #0x0
    9c54:      	ldr	x10, [sp, #0x8]
    9c58:      	csel	w0, w0, w8, mi
    9c5c:      	cmp	x9, x10
    9c60:      	b.ne	0x9c78 <ANativeWindow_getFormat+0x64>
    9c64:      	ldp	x29, x30, [sp, #0x10]
    9c68:      	ldr	x19, [sp, #0x20]
    9c6c:      	add	sp, sp, #0x30
    9c70:      	autiasp
    9c74:      	ret
    9c78:      	bl	0xadb0 <__stack_chk_fail@plt>

0000000000009c7c <ANativeWindow_setBuffersGeometry>:
    9c7c:      	paciasp
    9c80:      	stp	x29, x30, [sp, #-0x30]!
    9c84:      	str	x21, [sp, #0x10]
    9c88:      	stp	x20, x19, [sp, #0x20]
    9c8c:      	mov	x29, sp
    9c90:      	ldr	x8, [x0, #0x98]
    9c94:      	mov	w20, w2
    9c98:      	mov	w21, w1
    9c9c:      	mov	w1, #0x9
    9ca0:      	mov	w2, w3
    9ca4:      	mov	x19, x0
    9ca8:      	blr	x8
    9cac:      	cbnz	w0, 0x9ccc <ANativeWindow_setBuffersGeometry+0x50>
    9cb0:      	ldr	x8, [x19, #0x98]
    9cb4:      	mov	x0, x19
    9cb8:      	mov	w1, #0xf
    9cbc:      	mov	w2, w21
    9cc0:      	mov	w3, w20
    9cc4:      	blr	x8
    9cc8:      	cbz	w0, 0x9ce0 <ANativeWindow_setBuffersGeometry+0x64>
    9ccc:      	ldp	x20, x19, [sp, #0x20]
    9cd0:      	ldr	x21, [sp, #0x10]
    9cd4:      	ldp	x29, x30, [sp], #0x30
    9cd8:      	autiasp
    9cdc:      	ret
    9ce0:      	cmp	w21, #0x0
    9ce4:      	ldr	x16, [x19, #0x98]
    9ce8:      	mov	x0, x19
    9cec:      	ccmp	w20, #0x0, #0x4, ne
    9cf0:      	cset	w2, ne
    9cf4:      	mov	w1, #0xa
    9cf8:      	ldp	x20, x19, [sp, #0x20]
    9cfc:      	ldr	x21, [sp, #0x10]
    9d00:      	ldp	x29, x30, [sp], #0x30
    9d04:      	autiasp
    9d08:      	br	x16

0000000000009d0c <ANativeWindow_lock>:
    9d0c:      	bti	c
    9d10:      	ldr	x16, [x0, #0x98]
    9d14:      	mov	x3, x2
    9d18:      	mov	x2, x1
    9d1c:      	mov	w1, #0xb
    9d20:      	br	x16

0000000000009d24 <ANativeWindow_unlockAndPost>:
    9d24:      	bti	c
    9d28:      	ldr	x16, [x0, #0x98]
    9d2c:      	mov	w1, #0xc
    9d30:      	br	x16

0000000000009d34 <ANativeWindow_setBuffersTransform>:
    9d34:      	paciasp
    9d38:      	sub	sp, sp, #0x40
    9d3c:      	stp	x29, x30, [sp, #0x10]
    9d40:      	str	x21, [sp, #0x20]
    9d44:      	stp	x20, x19, [sp, #0x30]
    9d48:      	add	x29, sp, #0x10
    9d4c:      	mrs	x20, TPIDR_EL0
    9d50:      	ldr	x8, [x20, #0x28]
    9d54:      	str	x8, [sp, #0x8]
    9d58:      	cbz	x0, 0x9db0 <ANativeWindow_setBuffersTransform+0x7c>
    9d5c:      	ldr	x8, [x0, #0x90]
    9d60:      	mov	w19, w1
    9d64:      	add	x2, sp, #0x4
    9d68:      	mov	w1, #0x11
    9d6c:      	str	wzr, [sp, #0x4]
    9d70:      	mov	x21, x0
    9d74:      	blr	x8
    9d78:      	ldr	w8, [sp, #0x4]
    9d7c:      	cmp	w0, #0x0
    9d80:      	mov	w0, #-0x16
    9d84:      	ccmp	w8, #0x0, #0x0, pl
    9d88:      	cset	w8, ne
    9d8c:      	cmp	w19, #0xf
    9d90:      	b.hi	0x9db4 <ANativeWindow_setBuffersTransform+0x80>
    9d94:      	cbz	w8, 0x9db4 <ANativeWindow_setBuffersTransform+0x80>
    9d98:      	ldr	x8, [x21, #0x98]
    9d9c:      	mov	x0, x21
    9da0:      	mov	w1, #0x6
    9da4:      	mov	w2, w19
    9da8:      	blr	x8
    9dac:      	b	0x9db4 <ANativeWindow_setBuffersTransform+0x80>
    9db0:      	mov	w0, #-0x16
    9db4:      	ldr	x8, [x20, #0x28]
    9db8:      	ldr	x9, [sp, #0x8]
    9dbc:      	cmp	x8, x9
    9dc0:      	b.ne	0x9ddc <ANativeWindow_setBuffersTransform+0xa8>
    9dc4:      	ldp	x20, x19, [sp, #0x30]
    9dc8:      	ldr	x21, [sp, #0x20]
    9dcc:      	ldp	x29, x30, [sp, #0x10]
    9dd0:      	add	sp, sp, #0x40
    9dd4:      	autiasp
    9dd8:      	ret
    9ddc:      	bl	0xadb0 <__stack_chk_fail@plt>

0000000000009de0 <ANativeWindow_setBuffersDataSpace>:
    9de0:      	paciasp
    9de4:      	sub	sp, sp, #0x40
    9de8:      	stp	x29, x30, [sp, #0x10]
    9dec:      	str	x21, [sp, #0x20]
    9df0:      	stp	x20, x19, [sp, #0x30]
    9df4:      	add	x29, sp, #0x10
    9df8:      	mrs	x20, TPIDR_EL0
    9dfc:      	ldr	x8, [x20, #0x28]
    9e00:      	str	x8, [sp, #0x8]
    9e04:      	cbz	x0, 0x9e30 <ANativeWindow_setBuffersDataSpace+0x50>
    9e08:      	ldr	x8, [x0, #0x90]
    9e0c:      	mov	w19, w1
    9e10:      	add	x2, sp, #0x4
    9e14:      	mov	w1, #0x11
    9e18:      	str	wzr, [sp, #0x4]
    9e1c:      	mov	x21, x0
    9e20:      	blr	x8
    9e24:      	tbnz	w0, #0x1f, 0x9e38 <ANativeWindow_setBuffersDataSpace+0x58>
    9e28:      	ldr	w8, [sp, #0x4]
    9e2c:      	cbnz	w8, 0x9e38 <ANativeWindow_setBuffersDataSpace+0x58>
    9e30:      	mov	w0, #-0x16
    9e34:      	b	0x9e4c <ANativeWindow_setBuffersDataSpace+0x6c>
    9e38:      	ldr	x8, [x21, #0x98]
    9e3c:      	mov	x0, x21
    9e40:      	mov	w1, #0x13
    9e44:      	mov	w2, w19
    9e48:      	blr	x8
    9e4c:      	ldr	x8, [x20, #0x28]
    9e50:      	ldr	x9, [sp, #0x8]
    9e54:      	cmp	x8, x9
    9e58:      	b.ne	0x9e74 <ANativeWindow_setBuffersDataSpace+0x94>
    9e5c:      	ldp	x20, x19, [sp, #0x30]
    9e60:      	ldr	x21, [sp, #0x20]
    9e64:      	ldp	x29, x30, [sp, #0x10]
    9e68:      	add	sp, sp, #0x40
    9e6c:      	autiasp
    9e70:      	ret
    9e74:      	bl	0xadb0 <__stack_chk_fail@plt>

0000000000009e78 <ANativeWindow_getBuffersDataSpace>:
    9e78:      	paciasp
    9e7c:      	sub	sp, sp, #0x30
    9e80:      	stp	x29, x30, [sp, #0x10]
    9e84:      	stp	x20, x19, [sp, #0x20]
    9e88:      	add	x29, sp, #0x10
    9e8c:      	mrs	x19, TPIDR_EL0
    9e90:      	ldr	x8, [x19, #0x28]
    9e94:      	str	x8, [sp, #0x8]
    9e98:      	cbz	x0, 0x9ec0 <ANativeWindow_getBuffersDataSpace+0x48>
    9e9c:      	ldr	x8, [x0, #0x90]
    9ea0:      	add	x2, sp, #0x4
    9ea4:      	mov	w1, #0x11
    9ea8:      	str	wzr, [sp, #0x4]
    9eac:      	mov	x20, x0
    9eb0:      	blr	x8
    9eb4:      	tbnz	w0, #0x1f, 0x9ec8 <ANativeWindow_getBuffersDataSpace+0x50>
    9eb8:      	ldr	w8, [sp, #0x4]
    9ebc:      	cbnz	w8, 0x9ec8 <ANativeWindow_getBuffersDataSpace+0x50>
    9ec0:      	mov	w0, #-0x16
    9ec4:      	b	0x9eec <ANativeWindow_getBuffersDataSpace+0x74>
    9ec8:      	ldr	x8, [x20, #0x90]
    9ecc:      	mov	x0, x20
    9ed0:      	add	x2, sp, #0x4
    9ed4:      	mov	w1, #0x14
    9ed8:      	str	wzr, [sp, #0x4]
    9edc:      	blr	x8
    9ee0:      	ldr	w8, [sp, #0x4]
    9ee4:      	cmp	w0, #0x0
    9ee8:      	csel	w0, w0, w8, mi
    9eec:      	ldr	x8, [x19, #0x28]
    9ef0:      	ldr	x9, [sp, #0x8]
    9ef4:      	cmp	x8, x9
    9ef8:      	b.ne	0x9f10 <ANativeWindow_getBuffersDataSpace+0x98>
    9efc:      	ldp	x20, x19, [sp, #0x20]
    9f00:      	ldp	x29, x30, [sp, #0x10]
    9f04:      	add	sp, sp, #0x30
    9f08:      	autiasp
    9f0c:      	ret
    9f10:      	bl	0xadb0 <__stack_chk_fail@plt>

0000000000009f14 <ANativeWindow_getBuffersDefaultDataSpace>:
    9f14:      	paciasp
    9f18:      	sub	sp, sp, #0x30
    9f1c:      	stp	x29, x30, [sp, #0x10]
    9f20:      	stp	x20, x19, [sp, #0x20]
    9f24:      	add	x29, sp, #0x10
    9f28:      	mrs	x19, TPIDR_EL0
    9f2c:      	ldr	x8, [x19, #0x28]
    9f30:      	str	x8, [sp, #0x8]
    9f34:      	cbz	x0, 0x9f5c <ANativeWindow_getBuffersDefaultDataSpace+0x48>
    9f38:      	ldr	x8, [x0, #0x90]
    9f3c:      	add	x2, sp, #0x4
    9f40:      	mov	w1, #0x11
    9f44:      	str	wzr, [sp, #0x4]
    9f48:      	mov	x20, x0
    9f4c:      	blr	x8
    9f50:      	tbnz	w0, #0x1f, 0x9f64 <ANativeWindow_getBuffersDefaultDataSpace+0x50>
    9f54:      	ldr	w8, [sp, #0x4]
    9f58:      	cbnz	w8, 0x9f64 <ANativeWindow_getBuffersDefaultDataSpace+0x50>
    9f5c:      	mov	w0, #-0x16
    9f60:      	b	0x9f88 <ANativeWindow_getBuffersDefaultDataSpace+0x74>
    9f64:      	ldr	x8, [x20, #0x90]
    9f68:      	mov	x0, x20
    9f6c:      	add	x2, sp, #0x4
    9f70:      	mov	w1, #0xc
    9f74:      	str	wzr, [sp, #0x4]
    9f78:      	blr	x8
    9f7c:      	ldr	w8, [sp, #0x4]
    9f80:      	cmp	w0, #0x0
    9f84:      	csel	w0, w0, w8, mi
    9f88:      	ldr	x8, [x19, #0x28]
    9f8c:      	ldr	x9, [sp, #0x8]
    9f90:      	cmp	x8, x9
    9f94:      	b.ne	0x9fac <ANativeWindow_getBuffersDefaultDataSpace+0x98>
    9f98:      	ldp	x20, x19, [sp, #0x20]
    9f9c:      	ldp	x29, x30, [sp, #0x10]
    9fa0:      	add	sp, sp, #0x30
    9fa4:      	autiasp
    9fa8:      	ret
    9fac:      	bl	0xadb0 <__stack_chk_fail@plt>

0000000000009fb0 <ANativeWindow_setFrameRate>:
    9fb0:      	paciasp
    9fb4:      	sub	sp, sp, #0x40
    9fb8:      	str	d8, [sp, #0x10]
    9fbc:      	stp	x29, x30, [sp, #0x18]
    9fc0:      	str	x21, [sp, #0x28]
    9fc4:      	stp	x20, x19, [sp, #0x30]
    9fc8:      	add	x29, sp, #0x18
    9fcc:      	mrs	x20, TPIDR_EL0
    9fd0:      	ldr	x8, [x20, #0x28]
    9fd4:      	str	x8, [sp, #0x8]
    9fd8:      	cbz	x0, 0xa008 <ANativeWindow_setFrameRate+0x58>
    9fdc:      	ldr	x8, [x0, #0x90]
    9fe0:      	mov	w19, w1
    9fe4:      	add	x2, sp, #0x4
    9fe8:      	mov	w1, #0x11
    9fec:      	fmov	s8, s0
    9ff0:      	str	wzr, [sp, #0x4]
    9ff4:      	mov	x21, x0
    9ff8:      	blr	x8
    9ffc:      	tbnz	w0, #0x1f, 0xa010 <ANativeWindow_setFrameRate+0x60>
    a000:      	ldr	w8, [sp, #0x4]
    a004:      	cbnz	w8, 0xa010 <ANativeWindow_setFrameRate+0x60>
    a008:      	mov	w0, #-0x16
    a00c:      	b	0xa02c <ANativeWindow_setFrameRate+0x7c>
    a010:      	fcvt	d0, s8
    a014:      	ldr	x8, [x21, #0x98]
    a018:      	sxtb	w2, w19
    a01c:      	mov	x0, x21
    a020:      	mov	w1, #0x28
    a024:      	mov	w3, wzr
    a028:      	blr	x8
    a02c:      	ldr	x8, [x20, #0x28]
    a030:      	ldr	x9, [sp, #0x8]
    a034:      	cmp	x8, x9
    a038:      	b.ne	0xa058 <ANativeWindow_setFrameRate+0xa8>
    a03c:      	ldp	x20, x19, [sp, #0x30]
    a040:      	ldr	x21, [sp, #0x28]
    a044:      	ldp	x29, x30, [sp, #0x18]
    a048:      	ldr	d8, [sp, #0x10]
    a04c:      	add	sp, sp, #0x40
    a050:      	autiasp
    a054:      	ret
    a058:      	bl	0xadb0 <__stack_chk_fail@plt>

000000000000a05c <ANativeWindow_setFrameRateWithChangeStrategy>:
    a05c:      	paciasp
    a060:      	sub	sp, sp, #0x50
    a064:      	str	d8, [sp, #0x10]
    a068:      	stp	x29, x30, [sp, #0x20]
    a06c:      	stp	x22, x21, [sp, #0x30]
    a070:      	stp	x20, x19, [sp, #0x40]
    a074:      	add	x29, sp, #0x20
    a078:      	mrs	x21, TPIDR_EL0
    a07c:      	ldr	x8, [x21, #0x28]
    a080:      	str	x8, [sp, #0x8]
    a084:      	cbz	x0, 0xa0b8 <ANativeWindow_setFrameRateWithChangeStrategy+0x5c>
    a088:      	ldr	x8, [x0, #0x90]
    a08c:      	mov	w19, w2
    a090:      	mov	w20, w1
    a094:      	add	x2, sp, #0x4
    a098:      	mov	w1, #0x11
    a09c:      	fmov	s8, s0
    a0a0:      	str	wzr, [sp, #0x4]
    a0a4:      	mov	x22, x0
    a0a8:      	blr	x8
    a0ac:      	tbnz	w0, #0x1f, 0xa0c0 <ANativeWindow_setFrameRateWithChangeStrategy+0x64>
    a0b0:      	ldr	w8, [sp, #0x4]
    a0b4:      	cbnz	w8, 0xa0c0 <ANativeWindow_setFrameRateWithChangeStrategy+0x64>
    a0b8:      	mov	w0, #-0x16
    a0bc:      	b	0xa0dc <ANativeWindow_setFrameRateWithChangeStrategy+0x80>
    a0c0:      	fcvt	d0, s8
    a0c4:      	ldr	x8, [x22, #0x98]
    a0c8:      	sxtb	w2, w20
    a0cc:      	sxtb	w3, w19
    a0d0:      	mov	x0, x22
    a0d4:      	mov	w1, #0x28
    a0d8:      	blr	x8
    a0dc:      	ldr	x8, [x21, #0x28]
    a0e0:      	ldr	x9, [sp, #0x8]
    a0e4:      	cmp	x8, x9
    a0e8:      	b.ne	0xa108 <ANativeWindow_setFrameRateWithChangeStrategy+0xac>
    a0ec:      	ldp	x20, x19, [sp, #0x40]
    a0f0:      	ldr	d8, [sp, #0x10]
    a0f4:      	ldp	x22, x21, [sp, #0x30]
    a0f8:      	ldp	x29, x30, [sp, #0x20]
    a0fc:      	add	sp, sp, #0x50
    a100:      	autiasp
    a104:      	ret
    a108:      	bl	0xadb0 <__stack_chk_fail@plt>

000000000000a10c <ANativeWindow_tryAllocateBuffers>:
    a10c:      	paciasp
    a110:      	sub	sp, sp, #0x30
    a114:      	stp	x29, x30, [sp, #0x10]
    a118:      	stp	x20, x19, [sp, #0x20]
    a11c:      	add	x29, sp, #0x10
    a120:      	mrs	x20, TPIDR_EL0
    a124:      	ldr	x8, [x20, #0x28]
    a128:      	str	x8, [sp, #0x8]
    a12c:      	cbz	x0, 0xa164 <ANativeWindow_tryAllocateBuffers+0x58>
    a130:      	ldr	x8, [x0, #0x90]
    a134:      	add	x2, sp, #0x4
    a138:      	mov	w1, #0x11
    a13c:      	mov	x19, x0
    a140:      	str	wzr, [sp, #0x4]
    a144:      	blr	x8
    a148:      	tbnz	w0, #0x1f, 0xa154 <ANativeWindow_tryAllocateBuffers+0x48>
    a14c:      	ldr	w8, [sp, #0x4]
    a150:      	cbz	w8, 0xa164 <ANativeWindow_tryAllocateBuffers+0x58>
    a154:      	ldr	x8, [x19, #0x98]
    a158:      	mov	x0, x19
    a15c:      	mov	w1, #0x2d
    a160:      	blr	x8
    a164:      	ldr	x8, [x20, #0x28]
    a168:      	ldr	x9, [sp, #0x8]
    a16c:      	cmp	x8, x9
    a170:      	b.ne	0xa188 <ANativeWindow_tryAllocateBuffers+0x7c>
    a174:      	ldp	x20, x19, [sp, #0x20]
    a178:      	ldp	x29, x30, [sp, #0x10]
    a17c:      	add	sp, sp, #0x30
    a180:      	autiasp
    a184:      	ret
    a188:      	bl	0xadb0 <__stack_chk_fail@plt>

000000000000a18c <ANativeWindow_setProducerThrottlingEnabled>:
    a18c:      	paciasp
    a190:      	sub	sp, sp, #0x40
    a194:      	stp	x29, x30, [sp, #0x10]
    a198:      	str	x21, [sp, #0x20]
    a19c:      	stp	x20, x19, [sp, #0x30]
    a1a0:      	add	x29, sp, #0x10
    a1a4:      	mrs	x20, TPIDR_EL0
    a1a8:      	ldr	x8, [x20, #0x28]
    a1ac:      	str	x8, [sp, #0x8]
    a1b0:      	cbz	x0, 0xa1dc <ANativeWindow_setProducerThrottlingEnabled+0x50>
    a1b4:      	ldr	x8, [x0, #0x90]
    a1b8:      	mov	w19, w1
    a1bc:      	add	x2, sp, #0x4
    a1c0:      	mov	w1, #0x11
    a1c4:      	str	wzr, [sp, #0x4]
    a1c8:      	mov	x21, x0
    a1cc:      	blr	x8
    a1d0:      	tbnz	w0, #0x1f, 0xa1e4 <ANativeWindow_setProducerThrottlingEnabled+0x58>
    a1d4:      	ldr	w8, [sp, #0x4]
    a1d8:      	cbnz	w8, 0xa1e4 <ANativeWindow_setProducerThrottlingEnabled+0x58>
    a1dc:      	mov	w0, #-0x16
    a1e0:      	b	0xa1f8 <ANativeWindow_setProducerThrottlingEnabled+0x6c>
    a1e4:      	ldr	x8, [x21, #0x98]
    a1e8:      	mov	x0, x21
    a1ec:      	and	w2, w19, #0x1
    a1f0:      	mov	w1, #0x33
    a1f4:      	blr	x8
    a1f8:      	ldr	x8, [x20, #0x28]
    a1fc:      	ldr	x9, [sp, #0x8]
    a200:      	cmp	x8, x9
    a204:      	b.ne	0xa220 <ANativeWindow_setProducerThrottlingEnabled+0x94>
    a208:      	ldp	x20, x19, [sp, #0x30]
    a20c:      	ldr	x21, [sp, #0x20]
    a210:      	ldp	x29, x30, [sp, #0x10]
    a214:      	add	sp, sp, #0x40
    a218:      	autiasp
    a21c:      	ret
    a220:      	bl	0xadb0 <__stack_chk_fail@plt>

000000000000a224 <ANativeWindow_isProducerThrottlingEnabled>:
    a224:      	paciasp
    a228:      	sub	sp, sp, #0x40
    a22c:      	stp	x29, x30, [sp, #0x10]
    a230:      	str	x21, [sp, #0x20]
    a234:      	stp	x20, x19, [sp, #0x30]
    a238:      	add	x29, sp, #0x10
    a23c:      	mrs	x20, TPIDR_EL0
    a240:      	ldr	x8, [x20, #0x28]
    a244:      	str	x8, [sp, #0x8]
    a248:      	cbz	x0, 0xa274 <ANativeWindow_isProducerThrottlingEnabled+0x50>
    a24c:      	ldr	x8, [x0, #0x90]
    a250:      	mov	x19, x1
    a254:      	add	x2, sp, #0x4
    a258:      	mov	w1, #0x11
    a25c:      	str	wzr, [sp, #0x4]
    a260:      	mov	x21, x0
    a264:      	blr	x8
    a268:      	tbnz	w0, #0x1f, 0xa27c <ANativeWindow_isProducerThrottlingEnabled+0x58>
    a26c:      	ldr	w8, [sp, #0x4]
    a270:      	cbnz	w8, 0xa27c <ANativeWindow_isProducerThrottlingEnabled+0x58>
    a274:      	mov	w0, #-0x16
    a278:      	b	0xa290 <ANativeWindow_isProducerThrottlingEnabled+0x6c>
    a27c:      	ldr	x8, [x21, #0x98]
    a280:      	mov	x0, x21
    a284:      	mov	w1, #0x34
    a288:      	mov	x2, x19
    a28c:      	blr	x8
    a290:      	ldr	x8, [x20, #0x28]
    a294:      	ldr	x9, [sp, #0x8]
    a298:      	cmp	x8, x9
    a29c:      	b.ne	0xa2b8 <ANativeWindow_isProducerThrottlingEnabled+0x94>
    a2a0:      	ldp	x20, x19, [sp, #0x30]
    a2a4:      	ldr	x21, [sp, #0x20]
    a2a8:      	ldp	x29, x30, [sp, #0x10]
    a2ac:      	add	sp, sp, #0x40
    a2b0:      	autiasp
    a2b4:      	ret
    a2b8:      	bl	0xadb0 <__stack_chk_fail@plt>

000000000000a2bc <ANativeWindowBuffer_getHardwareBuffer>:
    a2bc:      	bti	c
    a2c0:      	sub	x0, x0, #0x10
    a2c4:      	b	0xabe8 <_ZN7android13GraphicBuffer17toAHardwareBufferEv@plt>

000000000000a2c8 <ANativeWindow_OemStorageSet>:
    a2c8:      	bti	c
    a2cc:      	cmp	w1, #0x3
    a2d0:      	b.hi	0xa2e8 <ANativeWindow_OemStorageSet+0x20>
    a2d4:      	mov	x8, x0
    a2d8:      	mov	w0, wzr
    a2dc:      	add	x8, x8, w1, uxtw #3
    a2e0:      	str	x2, [x8, #0x50]
    a2e4:      	ret
    a2e8:      	mov	w0, #-0x16
    a2ec:      	ret

000000000000a2f0 <ANativeWindow_OemStorageGet>:
    a2f0:      	bti	c
    a2f4:      	cmp	w1, #0x4
    a2f8:      	b.lo	0xa314 <ANativeWindow_OemStorageGet+0x24>
    a2fc:      	mov	x8, x0
    a300:      	mov	w0, wzr
    a304:      	add	x8, x8, w1, uxtw #3
    a308:      	ldr	x8, [x8, #0x50]
    a30c:      	str	x8, [x2]
    a310:      	ret
    a314:      	mov	w0, #-0x16
    a318:      	ret

000000000000a31c <ANativeWindow_setSwapInterval>:
    a31c:      	bti	c
    a320:      	ldr	x16, [x0, #0x70]
    a324:      	br	x16

000000000000a328 <ANativeWindow_query>:
    a328:      	bti	c
    a32c:      	mov	x8, x0
    a330:      	cmp	w1, #0x10, lsl #12      // =0x10000
    a334:      	mov	w0, #-0x16
    a338:      	b.ge	0xa35c <ANativeWindow_query+0x34>
    a33c:      	cmp	w1, #0xd
    a340:      	b.hi	0xa3b4 <ANativeWindow_query+0x8c>
    a344:      	mov	w9, #0x21c8
    a348:      	lsr	w9, w9, w1
    a34c:      	tbz	w9, #0x0, 0xa3b4 <ANativeWindow_query+0x8c>
    a350:      	ldr	x16, [x8, #0x90]
    a354:      	mov	x0, x8
    a358:      	br	x16
    a35c:      	mov	w9, #0x10001
    a360:      	cmp	w1, w9
    a364:      	b.gt	0xa380 <ANativeWindow_query+0x58>
    a368:      	cmp	w1, #0x10, lsl #12      // =0x10000
    a36c:      	b.eq	0xa3a8 <ANativeWindow_query+0x80>
    a370:      	cmp	w1, w9
    a374:      	b.ne	0xa3b4 <ANativeWindow_query+0x8c>
    a378:      	ldr	w8, [x8, #0x40]
    a37c:      	b	0xa3ac <ANativeWindow_query+0x84>
    a380:      	mov	w9, #0x2
    a384:      	movk	w9, #0x1, lsl #16
    a388:      	cmp	w1, w9
    a38c:      	b.eq	0xa3b8 <ANativeWindow_query+0x90>
    a390:      	mov	w9, #0x3
    a394:      	movk	w9, #0x1, lsl #16
    a398:      	cmp	w1, w9
    a39c:      	b.ne	0xa3b4 <ANativeWindow_query+0x8c>
    a3a0:      	ldr	s0, [x8, #0x48]
    a3a4:      	b	0xa3bc <ANativeWindow_query+0x94>
    a3a8:      	ldr	w8, [x8, #0x3c]
    a3ac:      	mov	w0, wzr
    a3b0:      	str	w8, [x2]
    a3b4:      	ret
    a3b8:      	ldr	s0, [x8, #0x44]
    a3bc:      	mov	w0, wzr
    a3c0:      	fcvtzs	s0, s0
    a3c4:      	str	s0, [x2]
    a3c8:      	ret

000000000000a3cc <ANativeWindow_queryf>:
    a3cc:      	paciasp
    a3d0:      	sub	sp, sp, #0x40
    a3d4:      	stp	x29, x30, [sp, #0x10]
    a3d8:      	str	x21, [sp, #0x20]
    a3dc:      	stp	x20, x19, [sp, #0x30]
    a3e0:      	add	x29, sp, #0x10
    a3e4:      	mrs	x19, TPIDR_EL0
    a3e8:      	sub	w9, w1, #0x10, lsl #12  // =0x10000
    a3ec:      	ldr	x8, [x19, #0x28]
    a3f0:      	cmp	w9, #0x3
    a3f4:      	str	x8, [sp, #0x8]
    a3f8:      	b.eq	0xa418 <ANativeWindow_queryf+0x4c>
    a3fc:      	mov	w8, #0x2
    a400:      	movk	w8, #0x1, lsl #16
    a404:      	cmp	w1, w8
    a408:      	b.ne	0xa424 <ANativeWindow_queryf+0x58>
    a40c:      	ldr	s0, [x0, #0x44]
    a410:      	mov	w8, wzr
    a414:      	b	0xa48c <ANativeWindow_queryf+0xc0>
    a418:      	ldr	s0, [x0, #0x48]
    a41c:      	mov	w8, wzr
    a420:      	b	0xa48c <ANativeWindow_queryf+0xc0>
    a424:      	cmp	w1, #0xd
    a428:      	str	wzr, [sp, #0x4]
    a42c:      	b.hi	0xa460 <ANativeWindow_queryf+0x94>
    a430:      	mov	w8, #0x21c8
    a434:      	lsr	w8, w8, w1
    a438:      	tbz	w8, #0x0, 0xa460 <ANativeWindow_queryf+0x94>
    a43c:      	ldr	x8, [x0, #0x90]
    a440:      	mov	x21, x2
    a444:      	add	x2, sp, #0x4
    a448:      	add	x20, sp, #0x4
    a44c:      	blr	x8
    a450:      	mov	w8, w0
    a454:      	cbnz	w0, 0xa490 <ANativeWindow_queryf+0xc4>
    a458:      	mov	x2, x21
    a45c:      	b	0xa480 <ANativeWindow_queryf+0xb4>
    a460:      	mov	w8, #0x10001
    a464:      	cmp	w1, w8
    a468:      	b.eq	0xa47c <ANativeWindow_queryf+0xb0>
    a46c:      	cmp	w1, #0x10, lsl #12      // =0x10000
    a470:      	b.ne	0xa4bc <ANativeWindow_queryf+0xf0>
    a474:      	add	x20, x0, #0x3c
    a478:      	b	0xa480 <ANativeWindow_queryf+0xb4>
    a47c:      	add	x20, x0, #0x40
    a480:      	ldr	s0, [x20]
    a484:      	mov	w8, wzr
    a488:      	scvtf	s0, s0
    a48c:      	str	s0, [x2]
    a490:      	ldr	x9, [x19, #0x28]
    a494:      	ldr	x10, [sp, #0x8]
    a498:      	cmp	x9, x10
    a49c:      	b.ne	0xa4c4 <ANativeWindow_queryf+0xf8>
    a4a0:      	mov	w0, w8
    a4a4:      	ldp	x20, x19, [sp, #0x30]
    a4a8:      	ldr	x21, [sp, #0x20]
    a4ac:      	ldp	x29, x30, [sp, #0x10]
    a4b0:      	add	sp, sp, #0x40
    a4b4:      	autiasp
    a4b8:      	ret
    a4bc:      	mov	w8, #-0x16
    a4c0:      	b	0xa490 <ANativeWindow_queryf+0xc4>
    a4c4:      	bl	0xadb0 <__stack_chk_fail@plt>

000000000000a4c8 <ANativeWindow_dequeueBuffer>:
    a4c8:      	bti	c
    a4cc:      	ldr	x16, [x0, #0xa8]
    a4d0:      	br	x16

000000000000a4d4 <ANativeWindow_queueBuffer>:
    a4d4:      	bti	c
    a4d8:      	ldr	x16, [x0, #0xb0]
    a4dc:      	br	x16

000000000000a4e0 <ANativeWindow_cancelBuffer>:
    a4e0:      	bti	c
    a4e4:      	ldr	x16, [x0, #0xb8]
    a4e8:      	br	x16

000000000000a4ec <ANativeWindow_setUsage>:
    a4ec:      	bti	c
    a4f0:      	ldr	x16, [x0, #0x98]
    a4f4:      	mov	x2, x1
    a4f8:      	mov	w1, #0x1e
    a4fc:      	br	x16

000000000000a500 <ANativeWindow_setBufferCount>:
    a500:      	bti	c
    a504:      	ldr	x16, [x0, #0x98]
    a508:      	mov	x2, x1
    a50c:      	mov	w1, #0x4
    a510:      	br	x16

000000000000a514 <ANativeWindow_setBuffersDimensions>:
    a514:      	bti	c
    a518:      	ldr	x16, [x0, #0x98]
    a51c:      	mov	w3, w2
    a520:      	mov	w2, w1
    a524:      	mov	w1, #0x8
    a528:      	br	x16

000000000000a52c <ANativeWindow_setBuffersFormat>:
    a52c:      	bti	c
    a530:      	ldr	x16, [x0, #0x98]
    a534:      	mov	w2, w1
    a538:      	mov	w1, #0x9
    a53c:      	br	x16

000000000000a540 <ANativeWindow_setBuffersTimestamp>:
    a540:      	bti	c
    a544:      	ldr	x16, [x0, #0x98]
    a548:      	mov	x2, x1
    a54c:      	mov	w1, #0x7
    a550:      	br	x16

000000000000a554 <ANativeWindow_setSharedBufferMode>:
    a554:      	bti	c
    a558:      	ldr	x16, [x0, #0x98]
    a55c:      	and	w2, w1, #0x1
    a560:      	mov	w1, #0x15
    a564:      	br	x16

000000000000a568 <ANativeWindow_setAutoRefresh>:
    a568:      	bti	c
    a56c:      	ldr	x16, [x0, #0x98]
    a570:      	and	w2, w1, #0x1
    a574:      	mov	w1, #0x16
    a578:      	br	x16

000000000000a57c <ANativeWindow_setAutoPrerotation>:
    a57c:      	bti	c
    a580:      	ldr	x16, [x0, #0x98]
    a584:      	and	w2, w1, #0x1
    a588:      	mov	w1, #0x23
    a58c:      	br	x16

000000000000a590 <ANativeWindow_readFromParcel>:
    a590:      	paciasp
    a594:      	sub	sp, sp, #0x30
    a598:      	stp	x29, x30, [sp, #0x10]
    a59c:      	stp	x20, x19, [sp, #0x20]
    a5a0:      	add	x29, sp, #0x10
    a5a4:      	nop
    a5a8:      	adr	x8, #0x5a68
    a5ac:      	mov	x19, x1
    a5b0:      	ldarb	w8, [x8]
    a5b4:      	tbz	w8, #0x0, 0xa618 <ANativeWindow_readFromParcel+0x88>
    a5b8:      	adrp	x20, 0x10000
    a5bc:      	ldr	x8, [x20, #0x8]
    a5c0:      	cbz	x8, 0xa5e4 <ANativeWindow_readFromParcel+0x54>
    a5c4:      	bl	0xab28 <_Z26AParcel_viewPlatformParcelPK7AParcel@plt>
    a5c8:      	ldr	x16, [x20, #0x8]
    a5cc:      	mov	x1, x19
    a5d0:      	ldp	x20, x19, [sp, #0x20]
    a5d4:      	ldp	x29, x30, [sp, #0x10]
    a5d8:      	add	sp, sp, #0x30
    a5dc:      	autiasp
    a5e0:      	br	x16
    a5e4:      	nop
    a5e8:      	adr	x1, #-0x7a27
    a5ec:      	adrp	x2, 0x2000
    a5f0:      	add	x2, x2, #0xfd1
    a5f4:      	mov	w0, #0x6
    a5f8:      	bl	0xa9a8 <__android_log_print@plt>
    a5fc:      	mov	w0, #0x2
    a600:      	movk	w0, #0x8000, lsl #16
    a604:      	ldp	x20, x19, [sp, #0x20]
    a608:      	ldp	x29, x30, [sp, #0x10]
    a60c:      	add	sp, sp, #0x30
    a610:      	autiasp
    a614:      	ret
    a618:      	nop
    a61c:      	adr	x8, #0x59f4
    a620:      	str	x0, [sp, #0x8]
    a624:      	mov	x0, x8
    a628:      	bl	0xad38 <__cxa_guard_acquire@plt>
    a62c:      	mov	w8, w0
    a630:      	ldr	x0, [sp, #0x8]
    a634:      	cbz	w8, 0xa5b8 <ANativeWindow_readFromParcel+0x28>
    a638:      	bl	0x9a70 <_ZN7android38AHardwareBuffer_to_ANativeWindowBufferEP15AHardwareBuffer+0x23c>
    a63c:      	nop
    a640:      	adr	x8, #0x59c0
    a644:      	stp	x0, x1, [x8]
    a648:      	nop
    a64c:      	adr	x0, #0x59c4
    a650:      	bl	0xad50 <__cxa_guard_release@plt>
    a654:      	ldr	x0, [sp, #0x8]
    a658:      	b	0xa5b8 <ANativeWindow_readFromParcel+0x28>

000000000000a65c <ANativeWindow_writeToParcel>:
    a65c:      	paciasp
    a660:      	sub	sp, sp, #0x30
    a664:      	stp	x29, x30, [sp, #0x10]
    a668:      	stp	x20, x19, [sp, #0x20]
    a66c:      	add	x29, sp, #0x10
    a670:      	nop
    a674:      	adr	x8, #0x599c
    a678:      	mov	x19, x0
    a67c:      	ldarb	w8, [x8]
    a680:      	tbz	w8, #0x0, 0xa6ec <ANativeWindow_writeToParcel+0x90>
    a684:      	adrp	x20, 0x10000
    a688:      	ldr	x8, [x20]
    a68c:      	cbz	x8, 0xa6b8 <ANativeWindow_writeToParcel+0x5c>
    a690:      	mov	x0, x1
    a694:      	bl	0xab40 <_Z26AParcel_viewPlatformParcelP7AParcel@plt>
    a698:      	ldr	x16, [x20]
    a69c:      	mov	x1, x0
    a6a0:      	mov	x0, x19
    a6a4:      	ldp	x20, x19, [sp, #0x20]
    a6a8:      	ldp	x29, x30, [sp, #0x10]
    a6ac:      	add	sp, sp, #0x30
    a6b0:      	autiasp
    a6b4:      	br	x16
    a6b8:      	nop
    a6bc:      	adr	x1, #-0x7afb
    a6c0:      	adrp	x2, 0x3000
    a6c4:      	add	x2, x2, #0x169
    a6c8:      	mov	w0, #0x6
    a6cc:      	bl	0xa9a8 <__android_log_print@plt>
    a6d0:      	mov	w0, #0x2
    a6d4:      	movk	w0, #0x8000, lsl #16
    a6d8:      	ldp	x20, x19, [sp, #0x20]
    a6dc:      	ldp	x29, x30, [sp, #0x10]
    a6e0:      	add	sp, sp, #0x30
    a6e4:      	autiasp
    a6e8:      	ret
    a6ec:      	nop
    a6f0:      	adr	x0, #0x5920
    a6f4:      	str	x1, [sp, #0x8]
    a6f8:      	bl	0xad38 <__cxa_guard_acquire@plt>
    a6fc:      	ldr	x1, [sp, #0x8]
    a700:      	cbz	w0, 0xa684 <ANativeWindow_writeToParcel+0x28>
    a704:      	bl	0x9a70 <_ZN7android38AHardwareBuffer_to_ANativeWindowBufferEP15AHardwareBuffer+0x23c>
    a708:      	nop
    a70c:      	adr	x8, #0x58f4
    a710:      	stp	x0, x1, [x8]
    a714:      	nop
    a718:      	adr	x0, #0x58f8
    a71c:      	bl	0xad50 <__cxa_guard_release@plt>
    a720:      	ldr	x1, [sp, #0x8]
    a724:      	b	0xa684 <ANativeWindow_writeToParcel+0x28>

000000000000a728 <ANativeWindow_getLastDequeueDuration>:
    a728:      	paciasp
    a72c:      	sub	sp, sp, #0x30
    a730:      	stp	x29, x30, [sp, #0x10]
    a734:      	str	x19, [sp, #0x20]
    a738:      	add	x29, sp, #0x10
    a73c:      	mrs	x19, TPIDR_EL0
    a740:      	mov	x2, sp
    a744:      	mov	w1, #0x26
    a748:      	ldr	x8, [x19, #0x28]
    a74c:      	str	x8, [sp, #0x8]
    a750:      	ldr	x8, [x0, #0x98]
    a754:      	str	xzr, [sp]
    a758:      	blr	x8
    a75c:      	ldr	x8, [sp]
    a760:      	ldr	x9, [x19, #0x28]
    a764:      	sxtw	x10, w0
    a768:      	ldr	x11, [sp, #0x8]
    a76c:      	cmp	w0, #0x0
    a770:      	csel	x0, x10, x8, mi
    a774:      	cmp	x9, x11
    a778:      	b.ne	0xa790 <ANativeWindow_getLastDequeueDuration+0x68>
    a77c:      	ldp	x29, x30, [sp, #0x10]
    a780:      	ldr	x19, [sp, #0x20]
    a784:      	add	sp, sp, #0x30
    a788:      	autiasp
    a78c:      	ret
    a790:      	bl	0xadb0 <__stack_chk_fail@plt>

000000000000a794 <ANativeWindow_getLastQueueDuration>:
    a794:      	paciasp
    a798:      	sub	sp, sp, #0x30
    a79c:      	stp	x29, x30, [sp, #0x10]
    a7a0:      	str	x19, [sp, #0x20]
    a7a4:      	add	x29, sp, #0x10
    a7a8:      	mrs	x19, TPIDR_EL0
    a7ac:      	mov	x2, sp
    a7b0:      	mov	w1, #0x27
    a7b4:      	ldr	x8, [x19, #0x28]
    a7b8:      	str	x8, [sp, #0x8]
    a7bc:      	ldr	x8, [x0, #0x98]
    a7c0:      	str	xzr, [sp]
    a7c4:      	blr	x8
    a7c8:      	ldr	x8, [sp]
    a7cc:      	ldr	x9, [x19, #0x28]
    a7d0:      	sxtw	x10, w0
    a7d4:      	ldr	x11, [sp, #0x8]
    a7d8:      	cmp	w0, #0x0
    a7dc:      	csel	x0, x10, x8, mi
    a7e0:      	cmp	x9, x11
    a7e4:      	b.ne	0xa7fc <ANativeWindow_getLastQueueDuration+0x68>
    a7e8:      	ldp	x29, x30, [sp, #0x10]
    a7ec:      	ldr	x19, [sp, #0x20]
    a7f0:      	add	sp, sp, #0x30
    a7f4:      	autiasp
    a7f8:      	ret
    a7fc:      	bl	0xadb0 <__stack_chk_fail@plt>

000000000000a800 <ANativeWindow_getLastDequeueStartTime>:
    a800:      	paciasp
    a804:      	sub	sp, sp, #0x30
    a808:      	stp	x29, x30, [sp, #0x10]
    a80c:      	str	x19, [sp, #0x20]
    a810:      	add	x29, sp, #0x10
    a814:      	mrs	x19, TPIDR_EL0
    a818:      	mov	x2, sp
    a81c:      	mov	w1, #0x24
    a820:      	ldr	x8, [x19, #0x28]
    a824:      	str	x8, [sp, #0x8]
    a828:      	ldr	x8, [x0, #0x98]
    a82c:      	str	xzr, [sp]
    a830:      	blr	x8
    a834:      	ldr	x8, [sp]
    a838:      	ldr	x9, [x19, #0x28]
    a83c:      	sxtw	x10, w0
    a840:      	ldr	x11, [sp, #0x8]
    a844:      	cmp	w0, #0x0
    a848:      	csel	x0, x10, x8, mi
    a84c:      	cmp	x9, x11
    a850:      	b.ne	0xa868 <ANativeWindow_getLastDequeueStartTime+0x68>
    a854:      	ldp	x29, x30, [sp, #0x10]
    a858:      	ldr	x19, [sp, #0x20]
    a85c:      	add	sp, sp, #0x30
    a860:      	autiasp
    a864:      	ret
    a868:      	bl	0xadb0 <__stack_chk_fail@plt>

000000000000a86c <ANativeWindow_setDequeueTimeout>:
    a86c:      	bti	c
    a870:      	ldr	x16, [x0, #0x98]
    a874:      	mov	x2, x1
    a878:      	mov	w1, #0x25
    a87c:      	br	x16

000000000000a880 <ANativeWindow_setCancelBufferInterceptor>:
    a880:      	bti	c
    a884:      	ldr	x16, [x0, #0x98]
    a888:      	mov	x3, x2
    a88c:      	mov	x2, x1
    a890:      	mov	w1, #0x29
    a894:      	br	x16

000000000000a898 <ANativeWindow_setDequeueBufferInterceptor>:
    a898:      	bti	c
    a89c:      	ldr	x16, [x0, #0x98]
    a8a0:      	mov	x3, x2
    a8a4:      	mov	x2, x1
    a8a8:      	mov	w1, #0x2a
    a8ac:      	br	x16

000000000000a8b0 <ANativeWindow_setPerformInterceptor>:
    a8b0:      	bti	c
    a8b4:      	ldr	x16, [x0, #0x98]
    a8b8:      	mov	x3, x2
    a8bc:      	mov	x2, x1
    a8c0:      	mov	w1, #0x2b
    a8c4:      	br	x16

000000000000a8c8 <ANativeWindow_setQueueBufferInterceptor>:
    a8c8:      	bti	c
    a8cc:      	ldr	x16, [x0, #0x98]
    a8d0:      	mov	x3, x2
    a8d4:      	mov	x2, x1
    a8d8:      	mov	w1, #0x2c
    a8dc:      	br	x16
