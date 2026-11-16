  2aacc4:      	bl	0x2aae90 <_ZN7android57android_hardware_HardwareBuffer_convertToGrallocUsageBitsEm+0x70c>
  2aacc8:      	ldrb	w8, [sp, #0x48]
  2aaccc:      	ldr	x1, [x24, #0x70]
  2aacd0:      	strb	wzr, [sp, #0x10]
  2aacd4:      	strb	wzr, [sp, #0x28]
  2aacd8:      	cbz	w8, 0x2aad30 <_ZN7android57android_hardware_HardwareBuffer_convertToGrallocUsageBitsEm+0x5ac>
  2aacdc:      	ldp	x19, x8, [sp, #0x30]
  2aace0:      	stp	xzr, xzr, [sp, #0x10]
  2aace4:      	str	xzr, [sp, #0x20]
  2aace8:      	subs	x20, x8, x19
  2aacec:      	b.eq	0x2aad28 <_ZN7android57android_hardware_HardwareBuffer_convertToGrallocUsageBitsEm+0x5a4>
  2aacf0:      	b.mi	0x2aada8 <_ZN7android57android_hardware_HardwareBuffer_convertToGrallocUsageBitsEm+0x624>
  2aacf4:      	mov	x22, x0
  2aacf8:      	mov	x0, x20
  2aacfc:      	mov	x21, x1
  2aad00:      	bl	0x2d9980 <_Znwm@plt>
  2aad04:      	add	x24, x0, x20
  2aad08:      	mov	x1, x19
  2aad0c:      	mov	x2, x20
  2aad10:      	str	x0, [sp, #0x10]
  2aad14:      	str	x24, [sp, #0x20]
  2aad18:      	bl	0x2e56e0 <memmove@plt>
  2aad1c:      	mov	x0, x22
  2aad20:      	mov	x1, x21
  2aad24:      	str	x24, [sp, #0x18]
  2aad28:      	mov	w8, #0x1
  2aad2c:      	strb	w8, [sp, #0x28]
  2aad30:      	add	x2, sp, #0x10
  2aad34:      	bl	0x2e2f90 <_ZN7android19GraphicBufferMapper15setSmpte2094_50EPK13native_handleNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE@plt>
  2aad38:      	ldrb	w8, [sp, #0x28]
  2aad3c:      	cbz	w8, 0x2aad58 <_ZN7android57android_hardware_HardwareBuffer_convertToGrallocUsageBitsEm+0x5d4>
  2aad40:      	ldr	x0, [sp, #0x10]
  2aad44:      	cbz	x0, 0x2aad58 <_ZN7android57android_hardware_HardwareBuffer_convertToGrallocUsageBitsEm+0x5d4>
  2aad48:      	ldr	x8, [sp, #0x20]
  2aad4c:      	str	x0, [sp, #0x18]
  2aad50:      	sub	x1, x8, x0
  2aad54:      	bl	0x2d98a0 <_ZdlPvm@plt>
  2aad58:      	ldrb	w8, [sp, #0x48]
  2aad5c:      	cbz	w8, 0x2aad78 <_ZN7android57android_hardware_HardwareBuffer_convertToGrallocUsageBitsEm+0x5f4>
  2aad60:      	ldr	x0, [sp, #0x30]
  2aad64:      	cbz	x0, 0x2aad78 <_ZN7android57android_hardware_HardwareBuffer_convertToGrallocUsageBitsEm+0x5f4>
  2aad68:      	ldr	x8, [sp, #0x40]
  2aad6c:      	str	x0, [sp, #0x38]
  2aad70:      	sub	x1, x8, x0
  2aad74:      	bl	0x2d98a0 <_ZdlPvm@plt>
  2aad78:      	ldr	x8, [x23, #0x28]
  2aad7c:      	ldur	x9, [x29, #-0x8]
  2aad80:      	cmp	x8, x9
  2aad84:      	b.ne	0x2aada4 <_ZN7android57android_hardware_HardwareBuffer_convertToGrallocUsageBitsEm+0x620>
  2aad88:      	ldp	x20, x19, [sp, #0x90]
  2aad8c:      	ldp	x22, x21, [sp, #0x80]
  2aad90:      	ldp	x24, x23, [sp, #0x70]
  2aad94:      	ldp	x29, x30, [sp, #0x60]
  2aad98:      	add	sp, sp, #0xa0
  2aad9c:      	autiasp
  2aada0:      	ret
  2aada4:      	bl	0x2e4c40 <__stack_chk_fail@plt>
  2aada8:      	bl	0x12271c <_ZN7android37createAudioDeviceAttributesFromNativeEP7_JNIEnvPP8_jobjectPKNS_19AudioDeviceTypeAddrE+0x1344>
  2aadac:      	bti	c
  2aadb0:      	cbz	x0, 0x2aadf0 <_ZN7android57android_hardware_HardwareBuffer_convertToGrallocUsageBitsEm+0x66c>
