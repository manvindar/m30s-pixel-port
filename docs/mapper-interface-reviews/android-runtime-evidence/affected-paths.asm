  2aae40:      	stp	xzr, xzr, [x19]
  2aae44:      	str	xzr, [x19, #0x10]
  2aae48:      	cbz	w20, 0x2aae70 <_ZN7android57android_hardware_HardwareBuffer_convertToGrallocUsageBitsEm+0x6ec>
  2aae4c:      	mov	x0, x19
  2aae50:      	mov	x1, x20
  2aae54:      	bl	0x234748 <_ZN7android36android_util_Log_isVerboseLogEnabledEPKc+0xeac>
  2aae58:      	ldr	x0, [x19, #0x8]
  2aae5c:      	mov	w1, wzr
  2aae60:      	mov	x2, x20
  2aae64:      	add	x21, x0, x20
  2aae68:      	bl	0x2e4ca0 <memset@plt>
  2aae6c:      	str	x21, [x19, #0x8]
  2aae70:      	mov	w8, #0x1
  2aae74:      	mov	x0, x19
  2aae78:      	strb	w8, [x19, #0x18]
  2aae7c:      	ldp	x20, x19, [sp, #0x20]
  2aae80:      	ldr	x21, [sp, #0x10]
  2aae84:      	ldp	x29, x30, [sp], #0x30
  2aae88:      	autiasp
  2aae8c:      	ret
  2aae90:      	paciasp
  2aae94:      	stp	x29, x30, [sp, #-0x20]!
  2aae98:      	stp	x20, x19, [sp, #0x10]
  2aae9c:      	mov	x29, sp
  2aaea0:      	adrp	x0, 0x30b000
  2aaea4:      	ldr	x0, [x0, #0xd28]
  2aaea8:      	bl	0x2dcb50 <pthread_mutex_lock@plt>
  2aaeac:      	adrp	x20, 0x30b000
  2aaeb0:      	ldr	x20, [x20, #0xd30]
  2aaeb4:      	ldr	x19, [x20]
  2aaeb8:      	cbnz	x19, 0x2aaed0 <_ZN7android57android_hardware_HardwareBuffer_convertToGrallocUsageBitsEm+0x74c>
  2aaebc:      	mov	w0, #0x10
  2aaec0:      	bl	0x2d9980 <_Znwm@plt>
  2aaec4:      	mov	x19, x0
  2aaec8:      	bl	0x2e2fa0 <_ZN7android19GraphicBufferMapperC1Ev@plt>
  2aaecc:      	str	x19, [x20]
  2aaed0:      	adrp	x0, 0x30b000
  2aaed4:      	ldr	x0, [x0, #0xd28]
  2aaed8:      	bl	0x2dcb40 <pthread_mutex_unlock@plt>
  2aaedc:      	mov	x0, x19
  2aaee0:      	ldp	x20, x19, [sp, #0x10]
  2aaee4:      	ldp	x29, x30, [sp], #0x20
  2aaee8:      	autiasp
  2aaeec:      	ret
  2aaef0:      	paciasp
  2aaef4:      	sub	sp, sp, #0x50
  2aaef8:      	stp	x29, x30, [sp, #0x20]
  2aaefc:      	str	x21, [sp, #0x30]
  2aaf00:      	stp	x20, x19, [sp, #0x40]
  2aaf04:      	add	x29, sp, #0x20
  2aaf08:      	mrs	x21, TPIDR_EL0
  2aaf0c:      	mov	w1, #0x4
  2aaf10:      	mov	x20, x0
  2aaf14:      	ldr	x8, [x21, #0x28]
  2aaf18:      	stur	x8, [x29, #-0x8]
  2aaf1c:      	ldr	x8, [x0]
  2aaf20:      	ldr	x8, [x8, #0x598]
  2aaf24:      	blr	x8
  2aaf28:      	mov	x19, x0
  2aaf2c:      	cbz	x0, 0x2aaf5c <_ZN7android57android_hardware_HardwareBuffer_convertToGrallocUsageBitsEm+0x7d8>
  2aaf30:      	ldr	x9, [x20]
  2aaf34:      	adrp	x8, 0xa8000
  2aaf38:      	mov	x4, sp
  2aaf3c:      	ldr	q0, [x8, #0xc20]
  2aaf40:      	mov	x0, x20
  2c53f0:      	bl	0x2e4c40 <__stack_chk_fail@plt>
  2c53f4:      	paciasp
  2c53f8:      	stp	x29, x30, [sp, #-0x10]!
  2c53fc:      	mov	x29, sp
  2c5400:      	adrp	x8, 0x30b000
  2c5404:      	ldr	x8, [x8, #0xfd0]
  2c5408:      	cbz	x8, 0x2c5410 <_ZN7android20perfettoProducerInitEP7_JNIEnvP7_jclassjj+0x1264>
  2c540c:      	bl	0x2e4be0 <_ZTHN7android8protolog10datasource22tl_use_test_datasourceE@plt>
  2c5410:      	adrp	x0, 0x30b000
  2c5414:      	ldr	x1, [x0, #0xfd8]
  2c5418:      	add	x0, x0, #0xfd8
  2c541c:      	blr	x1
  2c5420:      	mrs	x8, TPIDR_EL0
  2c5424:      	add	x0, x8, x0
  2c5428:      	ldp	x29, x30, [sp], #0x10
  2c542c:      	autiasp
  2c5430:      	ret
  2c5434:      	bti	c
  2c5438:      	mov	x0, x1
  2c543c:      	b	0x2d98c0 <_Znam@plt>
  2c5440:      	bti	c
