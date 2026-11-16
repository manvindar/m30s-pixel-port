  1551f8:      	paciasp
  1551fc:      	stp	x29, x30, [sp, #-0x20]!
  155200:      	stp	x20, x19, [sp, #0x10]
  155204:      	mov	x29, sp
  155208:      	adrp	x0, 0x212000 <_ZTTN7android3gui21BpWindowInfosListenerE+0x48>
  15520c:      	ldr	x0, [x0, #0xb88]
  155210:      	bl	0x1e5ae8 <pthread_mutex_lock@plt>
  155214:      	adrp	x20, 0x212000 <_ZTTN7android3gui21BpWindowInfosListenerE+0x48>
  155218:      	ldr	x20, [x20, #0xb90]
  15521c:      	ldr	x19, [x20]
  155220:      	cbnz	x19, 0x155238 <_ZN7android7Surface26applyGrallocMetadataLockedERKNS_2spINS_13GraphicBufferEEERKNS_22IGraphicBufferProducer16QueueBufferInputE+0x1c8>
  155224:      	mov	w0, #0x10
  155228:      	bl	0x1e5590 <_Znwm@plt>
  15522c:      	mov	x19, x0
  155230:      	bl	0x1e74c8 <_ZN7android19GraphicBufferMapperC1Ev@plt>
  155234:      	str	x19, [x20]
  155238:      	adrp	x0, 0x212000 <_ZTTN7android3gui21BpWindowInfosListenerE+0x48>
  15523c:      	ldr	x0, [x0, #0xb88]
  155240:      	bl	0x1e5b00 <pthread_mutex_unlock@plt>
  155244:      	mov	x0, x19
  155248:      	ldp	x20, x19, [sp, #0x10]
  15524c:      	ldp	x29, x30, [sp], #0x20
  155250:      	autiasp
  155254:      	ret
