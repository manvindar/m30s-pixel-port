
retained-evidence/bt-graphics-evidence-43772935293/latest-system-arm64-libui.so:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000046060 <_ZN7android19GraphicBufferMapperC2Ev>:
   46060:      	paciasp
   46064:      	stp	x29, x30, [sp, #-0x20]!
   46068:      	stp	x20, x19, [sp, #0x10]
   4606c:      	mov	x29, sp
   46070:      	mov	x19, x0
   46074:      	str	xzr, [x0]
   46078:      	mov	w0, #0x10
   4607c:      	bl	0x63ae0 <_Znwm@plt>
   46080:      	mov	x20, x0
   46084:      	bl	0x64878 <_ZN7android14Gralloc5MapperC1Ev@plt>
   46088:      	ldr	x8, [x19]
   4608c:      	str	x20, [x19]
   46090:      	cbz	x8, 0x460a8 <_ZN7android19GraphicBufferMapperC2Ev+0x48>
   46094:      	ldr	x9, [x8]
   46098:      	mov	x0, x8
   4609c:      	ldr	x9, [x9, #0x8]
   460a0:      	blr	x9
   460a4:      	ldr	x20, [x19]
   460a8:      	ldr	x8, [x20]
   460ac:      	mov	x0, x20
   460b0:      	ldr	x8, [x8, #0x10]
   460b4:      	blr	x8
   460b8:      	tbz	w0, #0x0, 0x460d4 <_ZN7android19GraphicBufferMapperC2Ev+0x74>
   460bc:      	mov	w8, #0x5
   460c0:      	str	w8, [x19, #0x8]
   460c4:      	ldp	x20, x19, [sp, #0x10]
   460c8:      	ldp	x29, x30, [sp], #0x20
   460cc:      	autiasp
   460d0:      	ret
   460d4:      	mov	w0, #0x10
   460d8:      	bl	0x63ae0 <_Znwm@plt>
   460dc:      	mov	x20, x0
   460e0:      	bl	0x640e0 <_ZN7android14Gralloc4MapperC1Ev@plt>
   460e4:      	ldr	x0, [x19]
   460e8:      	str	x20, [x19]
   460ec:      	cbnz	x0, 0x46124 <_ZN7android19GraphicBufferMapperC2Ev+0xc4>
   460f0:      	ldr	x8, [x20]
   460f4:      	mov	x0, x20
   460f8:      	ldr	x8, [x8, #0x10]
   460fc:      	blr	x8
   46100:      	tbz	w0, #0x0, 0x4610c <_ZN7android19GraphicBufferMapperC2Ev+0xac>
   46104:      	mov	w8, #0x4
   46108:      	b	0x460c0 <_ZN7android19GraphicBufferMapperC2Ev+0x60>
   4610c:      	nop
   46110:      	adr	x1, #-0x30acf
   46114:      	adrp	x2, 0x13000
   46118:      	add	x2, x2, #0x862
   4611c:      	mov	x0, xzr
   46120:      	bl	0x64140 <__android_log_assert@plt>
   46124:      	ldr	x8, [x0]
   46128:      	ldr	x8, [x8, #0x8]
   4612c:      	blr	x8
   46130:      	ldr	x20, [x19]
   46134:      	b	0x460f0 <_ZN7android19GraphicBufferMapperC2Ev+0x90>
