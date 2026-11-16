
retained-evidence/provider-callers-43776923589/legacy_graphics/abi-consumers/b196e0a8e32fd3b10208dda16d1def366efeaedf756e47eb08ecd91c3c4157d3.elf:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000009178 <AHardwareBuffer_getDataSpace>:
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
