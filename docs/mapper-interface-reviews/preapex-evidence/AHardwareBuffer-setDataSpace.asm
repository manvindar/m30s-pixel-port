
retained-evidence/provider-callers-43776923589/legacy_graphics/abi-consumers/5970db0a77ea05f7174e2efbb245a6e497cbcd544bcc22ecd8f02cbfc48124ee.elf:	file format elf64-littleaarch64

Disassembly of section .text:

00000000000a619c <AHardwareBuffer_setDataSpace>:
   a619c:      	paciasp
   a61a0:      	stp	x29, x30, [sp, #-0x30]!
   a61a4:      	stp	x22, x21, [sp, #0x10]
   a61a8:      	stp	x20, x19, [sp, #0x20]
   a61ac:      	mov	x29, sp
   a61b0:      	mov	w19, w1
   a61b4:      	bl	0xb7060 <_ZN7android13GraphicBuffer19fromAHardwareBufferEP15AHardwareBuffer@plt>
   a61b8:      	mov	x20, x0
   a61bc:      	adrp	x0, 0xc4000
   a61c0:      	ldr	x0, [x0, #0x438]
   a61c4:      	bl	0xb6e00 <pthread_mutex_lock@plt>
   a61c8:      	adrp	x22, 0xc4000
   a61cc:      	ldr	x22, [x22, #0x440]
   a61d0:      	ldr	x21, [x22]
   a61d4:      	cbnz	x21, 0xa61ec <AHardwareBuffer_setDataSpace+0x50>
   a61d8:      	mov	w0, #0x10
   a61dc:      	bl	0xb5ae0 <_Znwm@plt>
   a61e0:      	mov	x21, x0
   a61e4:      	bl	0xb7b60 <_ZN7android19GraphicBufferMapperC1Ev@plt>
   a61e8:      	str	x21, [x22]
   a61ec:      	adrp	x0, 0xc4000
   a61f0:      	ldr	x0, [x0, #0x438]
   a61f4:      	bl	0xb6e30 <pthread_mutex_unlock@plt>
   a61f8:      	ldr	x1, [x20, #0x70]
   a61fc:      	mov	x0, x21
   a6200:      	mov	w2, w19
   a6204:      	bl	0xb7b10 <_ZN7android19GraphicBufferMapper12setDataspaceEPK13native_handleNS_8hardware8graphics6common4V1_29DataspaceE@plt>
   a6208:      	cmn	w0, #0x17
   a620c:      	b.le	0xa6228 <AHardwareBuffer_setDataSpace+0x8c>
   a6210:      	cmn	w0, #0x16
   a6214:      	b.eq	0xa6244 <AHardwareBuffer_setDataSpace+0xa8>
   a6218:      	cmn	w0, #0xc
   a621c:      	b.eq	0xa6244 <AHardwareBuffer_setDataSpace+0xa8>
   a6220:      	cbz	w0, 0xa6244 <AHardwareBuffer_setDataSpace+0xa8>
   a6224:      	b	0xa6240 <AHardwareBuffer_setDataSpace+0xa4>
   a6228:      	cmn	w0, #0x4a
   a622c:      	b.eq	0xa6238 <AHardwareBuffer_setDataSpace+0x9c>
   a6230:      	cmn	w0, #0x26
   a6234:      	b.ne	0xa6240 <AHardwareBuffer_setDataSpace+0xa4>
   a6238:      	mov	w0, #-0x26
   a623c:      	b	0xa6244 <AHardwareBuffer_setDataSpace+0xa8>
   a6240:      	mov	w0, #-0x80000000
   a6244:      	ldp	x20, x19, [sp, #0x20]
   a6248:      	ldp	x22, x21, [sp, #0x10]
   a624c:      	ldp	x29, x30, [sp], #0x30
   a6250:      	autiasp
   a6254:      	ret
