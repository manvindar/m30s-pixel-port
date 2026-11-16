  155070:      	paciasp
  155074:      	sub	sp, sp, #0xa0
  155078:      	stp	x29, x30, [sp, #0x60]
  15507c:      	str	x23, [sp, #0x70]
  155080:      	stp	x22, x21, [sp, #0x80]
  155084:      	stp	x20, x19, [sp, #0x90]
  155088:      	add	x29, sp, #0x60
  15508c:      	mrs	x23, TPIDR_EL0
  155090:      	mov	x19, x2
  155094:      	mov	x21, x1
  155098:      	ldr	x8, [x23, #0x28]
  15509c:      	mov	x22, x0
  1550a0:      	stur	x8, [x29, #-0x8]
  1550a4:      	bl	0x1e5e60 <atrace_get_enabled_tags@plt>
  1550a8:      	tbz	w0, #0x1, 0x1550b8 <_ZN7android7Surface26applyGrallocMetadataLockedERKNS_2spINS_13GraphicBufferEEERKNS_22IGraphicBufferProducer16QueueBufferInputE+0x48>
  1550ac:      	adrp	x0, 0x6a000
  1550b0:      	add	x0, x0, #0xa5e
  1550b4:      	bl	0x1e5e30 <atrace_begin_body@plt>
  1550b8:      	bl	0x1551f8 <_ZN7android7Surface26applyGrallocMetadataLockedERKNS_2spINS_13GraphicBufferEEERKNS_22IGraphicBufferProducer16QueueBufferInputE+0x188>
  1550bc:      	ldr	x8, [x21]
  1550c0:      	ldr	w2, [x19, #0xc]
  1550c4:      	mov	x20, x0
  1550c8:      	ldr	x1, [x8, #0x70]
  1550cc:      	bl	0x1e7258 <_ZN7android19GraphicBufferMapper12setDataspaceEPK13native_handleNS_8hardware8graphics6common4V1_29DataspaceE@plt>
  1550d0:      	ldr	w8, [x22, #0x1e8]
  1550d4:      	tbz	w8, #0x0, 0x155104 <_ZN7android7Surface26applyGrallocMetadataLockedERKNS_2spINS_13GraphicBufferEEERKNS_22IGraphicBufferProducer16QueueBufferInputE+0x94>
  1550d8:      	ldr	x8, [x21]
  1550dc:      	ldrb	w9, [x19, #0xa8]
  1550e0:      	ldr	x1, [x8, #0x70]
  1550e4:      	tbnz	w9, #0x0, 0x1551d0 <_ZN7android7Surface26applyGrallocMetadataLockedERKNS_2spINS_13GraphicBufferEEERKNS_22IGraphicBufferProducer16QueueBufferInputE+0x160>
  1550e8:      	mov	w8, wzr
  1550ec:      	strb	wzr, [sp, #0x20]
  1550f0:      	add	x2, sp, #0x20
  1550f4:      	mov	x0, x20
  1550f8:      	strb	w8, [sp, #0x48]
  1550fc:      	bl	0x1e7270 <_ZN7android19GraphicBufferMapper12setSmpte2086EPK13native_handleNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEE@plt>
  155100:      	ldr	w8, [x22, #0x1e8]
  155104:      	tbz	w8, #0x1, 0x155134 <_ZN7android7Surface26applyGrallocMetadataLockedERKNS_2spINS_13GraphicBufferEEERKNS_22IGraphicBufferProducer16QueueBufferInputE+0xc4>
  155108:      	ldr	w8, [x19, #0xa8]
  15510c:      	ldr	x9, [x21]
  155110:      	mov	x0, x20
  155114:      	ldur	x11, [x19, #0xd4]
  155118:      	and	x10, x8, #0x2
  15511c:      	ldr	x1, [x9, #0x70]
  155120:      	ubfx	x3, x8, #1, #1
  155124:      	cmp	w10, #0x0
  155128:      	csel	x2, xzr, x11, eq
  15512c:      	bl	0x1e7288 <_ZN7android19GraphicBufferMapper11setCta861_3EPK13native_handleNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEE@plt>
  155130:      	ldr	w8, [x22, #0x1e8]
  155134:      	tbnz	w8, #0x2, 0x155170 <_ZN7android7Surface26applyGrallocMetadataLockedERKNS_2spINS_13GraphicBufferEEERKNS_22IGraphicBufferProducer16QueueBufferInputE+0x100>
  155138:      	bl	0x1e5e60 <atrace_get_enabled_tags@plt>
  15513c:      	tbnz	w0, #0x1, 0x1551c8 <_ZN7android7Surface26applyGrallocMetadataLockedERKNS_2spINS_13GraphicBufferEEERKNS_22IGraphicBufferProducer16QueueBufferInputE+0x158>
  155140:      	ldr	x8, [x23, #0x28]
  155144:      	ldur	x9, [x29, #-0x8]
  155148:      	cmp	x8, x9
  15514c:      	b.ne	0x15516c <_ZN7android7Surface26applyGrallocMetadataLockedERKNS_2spINS_13GraphicBufferEEERKNS_22IGraphicBufferProducer16QueueBufferInputE+0xfc>
  155150:      	ldp	x20, x19, [sp, #0x90]
  155154:      	ldr	x23, [sp, #0x70]
  155158:      	ldp	x22, x21, [sp, #0x80]
  15515c:      	ldp	x29, x30, [sp, #0x60]
  155160:      	add	sp, sp, #0xa0
  155164:      	autiasp
  155168:      	ret
  15516c:      	bl	0x1eb0c8 <__stack_chk_fail@plt>
  155170:      	ldr	x8, [x21]
  155174:      	ldrb	w9, [x19, #0xa8]
  155178:      	ldr	x21, [x8, #0x70]
  15517c:      	tbz	w9, #0x2, 0x1551ec <_ZN7android7Surface26applyGrallocMetadataLockedERKNS_2spINS_13GraphicBufferEEERKNS_22IGraphicBufferProducer16QueueBufferInputE+0x17c>
  155180:      	mov	x0, sp
  155184:      	add	x1, x19, #0xe0
  155188:      	bl	0x12f1cc <_ZNK7android3gui17IBLASTBufferQueue22getInterfaceDescriptorEv+0xc0>
  15518c:      	mov	w8, #0x1
  155190:      	mov	x2, sp
  155194:      	mov	x0, x20
  155198:      	mov	x1, x21
  15519c:      	strb	w8, [sp, #0x18]
  1551a0:      	bl	0x1e72a0 <_ZN7android19GraphicBufferMapper15setSmpte2094_40EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE@plt>
  1551a4:      	ldrb	w8, [sp, #0x18]
  1551a8:      	cbz	w8, 0x155138 <_ZN7android7Surface26applyGrallocMetadataLockedERKNS_2spINS_13GraphicBufferEEERKNS_22IGraphicBufferProducer16QueueBufferInputE+0xc8>
  1551ac:      	ldr	x0, [sp]
  1551b0:      	cbz	x0, 0x155138 <_ZN7android7Surface26applyGrallocMetadataLockedERKNS_2spINS_13GraphicBufferEEERKNS_22IGraphicBufferProducer16QueueBufferInputE+0xc8>
  1551b4:      	ldr	x8, [sp, #0x10]
  1551b8:      	str	x0, [sp, #0x8]
  1551bc:      	sub	x1, x8, x0
  1551c0:      	bl	0x1e55a8 <_ZdlPvm@plt>
  1551c4:      	b	0x155138 <_ZN7android7Surface26applyGrallocMetadataLockedERKNS_2spINS_13GraphicBufferEEERKNS_22IGraphicBufferProducer16QueueBufferInputE+0xc8>
  1551c8:      	bl	0x1e5e48 <atrace_end_body@plt>
  1551cc:      	b	0x155140 <_ZN7android7Surface26applyGrallocMetadataLockedERKNS_2spINS_13GraphicBufferEEERKNS_22IGraphicBufferProducer16QueueBufferInputE+0xd0>
  1551d0:      	ldur	q0, [x19, #0xac]
  1551d4:      	ldur	q1, [x19, #0xbc]
  1551d8:      	mov	w8, #0x1
  1551dc:      	ldur	d2, [x19, #0xcc]
  1551e0:      	stp	q0, q1, [sp, #0x20]
  1551e4:      	str	d2, [sp, #0x40]
  1551e8:      	b	0x1550f0 <_ZN7android7Surface26applyGrallocMetadataLockedERKNS_2spINS_13GraphicBufferEEERKNS_22IGraphicBufferProducer16QueueBufferInputE+0x80>
  1551ec:      	mov	w8, wzr
  1551f0:      	strb	wzr, [sp]
  1551f4:      	b	0x155190 <_ZN7android7Surface26applyGrallocMetadataLockedERKNS_2spINS_13GraphicBufferEEERKNS_22IGraphicBufferProducer16QueueBufferInputE+0x120>
