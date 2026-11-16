
retained-evidence/bt-graphics-evidence-43772935293/latest-system-arm32-libui.so:	file format elf32-littlearm

Disassembly of section .text:

0002af8c <_ZN7android13GraphicBufferC2Ev>:
   2af8c:      	push.w	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
   2af90:      	sub	sp, #0x1c
   2af92:      	mov	r9, r0
   2af94:      	ldr	r0, [pc, #0x1e0]        @ 0x2b178 <_ZN7android13GraphicBufferC2Ev+0x1ec>
   2af96:      	movw	r1, #0x6672
   2af9a:      	vmov.i32	q8, #0x0
   2af9e:      	add	r0, pc
   2afa0:      	movt	r1, #0x5f62
   2afa4:      	add.w	r4, r9, #0x10
   2afa8:      	ldr	r0, [r0]
   2afaa:      	ldr	r0, [r0]
   2afac:      	str	r0, [sp, #0x18]
   2afae:      	movs	r0, #0x60
   2afb0:      	strd	r1, r0, [r9, #8]
   2afb4:      	mov	r0, r9
   2afb6:      	vst1.64	{d16, d17}, [r4]!
   2afba:      	blx	0x40020                 @ imm = #0x15064
   2afbe:      	ldr	r0, [pc, #0x1bc]        @ 0x2b17c <_ZN7android13GraphicBufferC2Ev+0x1f0>
   2afc0:      	ldr	r1, [pc, #0x1bc]        @ 0x2b180 <_ZN7android13GraphicBufferC2Ev+0x1f4>
   2afc2:      	add	r0, pc
   2afc4:      	ldr	r2, [pc, #0x1bc]        @ 0x2b184 <_ZN7android13GraphicBufferC2Ev+0x1f8>
   2afc6:      	add	r1, pc
   2afc8:      	ldr	r3, [pc, #0x1bc]        @ 0x2b188 <_ZN7android13GraphicBufferC2Ev+0x1fc>
   2afca:      	ldr	r0, [r0]
   2afcc:      	add	r2, pc
   2afce:      	ldr	r5, [r1]
   2afd0:      	movs	r1, #0x2
   2afd2:      	adds	r0, #0x8
   2afd4:      	str.w	r0, [r9]
   2afd8:      	add	r3, pc
   2afda:      	str.w	r2, [r9, #0x24]
   2afde:      	mov	r0, r5
   2afe0:      	str	r3, [r4]
   2afe2:      	strb.w	r1, [r9, #0x68]
   2afe6:      	blx	0x40030                 @ imm = #0x15048
   2afea:      	movs	r1, #0x0
   2afec:      	cmp	r1, r0
   2afee:      	bvs.w	0x2b16c <_ZN7android13GraphicBufferC2Ev+0x1e0> @ imm = #0x17a
   2aff2:      	ldr	r0, [pc, #0x198]        @ 0x2b18c <_ZN7android13GraphicBufferC2Ev+0x200>
   2aff4:      	add	r0, pc
   2aff6:      	ldr	r4, [r0]
   2aff8:      	ldr	r6, [r4]
   2affa:      	cbnz	r6, 0x2b00a <_ZN7android13GraphicBufferC2Ev+0x7e> @ imm = #0xc
   2affc:      	movs	r0, #0x8
   2affe:      	blx	0x3f480                 @ imm = #0x14480
   2b002:      	mov	r6, r0
   2b004:      	blx	0x40040                 @ imm = #0x15038
   2b008:      	str	r0, [r4]
   2b00a:      	mov	r0, r5
   2b00c:      	blx	0x40050                 @ imm = #0x15040
   2b010:      	movs	r0, #0x0
   2b012:      	strd	r6, r0, [r9, #108]
   2b016:      	blx	0x40060                 @ imm = #0x15048
   2b01a:      	ldr	r2, [pc, #0x174]        @ 0x2b190 <_ZN7android13GraphicBufferC2Ev+0x204>
   2b01c:      	add	r2, pc
   2b01e:      	ldrex	r1, [r2]
   2b022:      	adds	r3, r1, #0x1
   2b024:      	stlex	r7, r3, [r2]
   2b028:      	cmp	r7, #0x0
   2b02a:      	bne	0x2b01e <_ZN7android13GraphicBufferC2Ev+0x92> @ imm = #-0x10
   2b02c:      	strd	r1, r0, [r9, #128]
   2b030:      	vmov.i32	q8, #0x0
   2b034:      	add.w	r1, r9, #0x8c
   2b038:      	movs	r0, #0x14
   2b03a:      	vst1.32	{d16, d17}, [r1], r0
   2b03e:      	mov.w	r10, #0xffffffff
   2b042:      	add.w	r11, r9, #0xb0
   2b046:      	movs	r4, #0x0
   2b048:      	str.w	r10, [r9, #0x88]
   2b04c:      	movs	r6, #0x0
   2b04e:      	str	r1, [sp, #0x4]
   2b050:      	vst1.64	{d16, d17}, [r1]
   2b054:      	ldr	r0, [pc, #0x13c]        @ 0x2b194 <_ZN7android13GraphicBufferC2Ev+0x208>
   2b056:      	add	r0, pc
   2b058:      	ldr	r7, [r0]
   2b05a:      	b	0x2b070 <_ZN7android13GraphicBufferC2Ev+0xe4> @ imm = #0x12
   2b05c:      	adds	r6, #0xa0
   2b05e:      	str.w	r4, [r8, #0x98]
   2b062:      	cmp.w	r6, #0x640
   2b066:      	strb.w	r4, [r8, #0x94]
   2b06a:      	strh.w	r4, [r8, #0x88]
   2b06e:      	beq	0x2b0d8 <_ZN7android13GraphicBufferC2Ev+0x14c> @ imm = #0x66
   2b070:      	add.w	r8, r11, r6
   2b074:      	str.w	r10, [r11, r6]
   2b078:      	str.w	r10, [r8, #0x4]
   2b07c:      	ldr	r0, [r7]
   2b07e:      	str.w	r0, [r8, #0x8]
   2b082:      	ldr	r0, [r7, #0x4]
   2b084:      	str.w	r0, [r8, #0xc]
   2b088:      	cbz	r0, 0x2b09a <_ZN7android13GraphicBufferC2Ev+0x10e> @ imm = #0xe
   2b08a:      	adds	r0, #0x4
   2b08c:      	ldrex	r1, [r0]
   2b090:      	adds	r1, #0x1
   2b092:      	strex	r2, r1, [r0]
   2b096:      	cmp	r2, #0x0
   2b098:      	bne	0x2b08c <_ZN7android13GraphicBufferC2Ev+0x100> @ imm = #-0x10
   2b09a:      	mov	r5, r8
   2b09c:      	movs	r1, #0x4
   2b09e:      	str	r4, [r5, #28]!
   2b0a2:      	add.w	r0, r5, #0x10
   2b0a6:      	str	r0, [r5, #0xc]
   2b0a8:      	mov	r0, r5
   2b0aa:      	strb.w	r4, [r5, #0x60]
   2b0ae:      	strd	r4, r4, [r5, #4]
   2b0b2:      	strh	r4, [r5, #-12]
   2b0b6:      	bl	0x2c974 <_ZN7android13GraphicBuffer16addDeathCallbackENSt3__18functionIFvPvyEEES3_+0x74> @ imm = #0x18ba
   2b0ba:      	ldr	r0, [r7]
   2b0bc:      	str	r0, [r5, #0x64]
   2b0be:      	ldr	r0, [r7, #0x4]
   2b0c0:      	str	r0, [r5, #0x68]
   2b0c2:      	cmp	r0, #0x0
   2b0c4:      	beq	0x2b05c <_ZN7android13GraphicBufferC2Ev+0xd0> @ imm = #-0x6c
   2b0c6:      	adds	r0, #0x4
   2b0c8:      	ldrex	r1, [r0]
   2b0cc:      	adds	r1, #0x1
   2b0ce:      	strex	r2, r1, [r0]
   2b0d2:      	cmp	r2, #0x0
   2b0d4:      	bne	0x2b0c8 <_ZN7android13GraphicBufferC2Ev+0x13c> @ imm = #-0x10
   2b0d6:      	b	0x2b05c <_ZN7android13GraphicBufferC2Ev+0xd0> @ imm = #-0x7e
   2b0d8:      	vmov.i32	q8, #0x0
   2b0dc:      	mov.w	r1, #0xffffffff
   2b0e0:      	str.w	r1, [r9, #0x6f0]
   2b0e4:      	add.w	r1, r9, #0x28
   2b0e8:      	movs	r0, #0x0
   2b0ea:      	ldrd	r2, r3, [r9, #128]
   2b0ee:      	vst1.64	{d16, d17}, [r1]!
   2b0f2:      	str.w	r0, [r9, #0x6f4]
   2b0f6:      	strd	r0, r0, [r9, #68]
   2b0fa:      	str.w	r0, [r9, #0x4c]
   2b0fe:      	str.w	r0, [r9, #0x3c]
   2b102:      	str	r0, [r1]
   2b104:      	add	r0, sp, #0x8
   2b106:      	blx	0x40070                 @ imm = #0x14f68
   2b10a:      	ldrb.w	r0, [r9, #0xa0]
   2b10e:      	ldr.w	r1, [r9, #0xa0]
   2b112:      	lsls	r0, r0, #0x1f
   2b114:      	beq	0x2b11a <_ZN7android13GraphicBufferC2Ev+0x18e> @ imm = #0x2
   2b116:      	cmp	r1, #0x1
   2b118:      	bls	0x2b170 <_ZN7android13GraphicBufferC2Ev+0x1e4> @ imm = #0x54
   2b11a:      	lsls	r0, r1, #0x1f
   2b11c:      	beq	0x2b12e <_ZN7android13GraphicBufferC2Ev+0x1a2> @ imm = #0xe
   2b11e:      	cmp	r1, #0x1
   2b120:      	bls	0x2b174 <_ZN7android13GraphicBufferC2Ev+0x1e8> @ imm = #0x50
   2b122:      	ldr.w	r0, [r9, #0xa8]
   2b126:      	bic	r1, r1, #0x1
   2b12a:      	blx	0x3f4e0                 @ imm = #0x143b4
   2b12e:      	movs	r1, #0x0
   2b130:      	vldr	d16, [sp, #8]
   2b134:      	strh.w	r1, [sp, #0x8]
   2b138:      	ldrd	r2, r1, [sp, #4]
   2b13c:      	ldr	r0, [sp, #0x10]
   2b13e:      	str	r0, [r2, #0x8]
   2b140:      	lsls	r0, r1, #0x1f
   2b142:      	vstr	d16, [r2]
   2b146:      	beq	0x2b152 <_ZN7android13GraphicBufferC2Ev+0x1c6> @ imm = #0x8
   2b148:      	ldr	r0, [sp, #0x10]
   2b14a:      	bic	r1, r1, #0x1
   2b14e:      	blx	0x3f4e0                 @ imm = #0x14390
   2b152:      	ldr	r0, [sp, #0x18]
   2b154:      	ldr	r1, [pc, #0x40]         @ 0x2b198 <_ZN7android13GraphicBufferC2Ev+0x20c>
   2b156:      	add	r1, pc
   2b158:      	ldr	r1, [r1]
   2b15a:      	ldr	r1, [r1]
   2b15c:      	cmp	r1, r0
   2b15e:      	ittt	eq
   2b160:      	moveq	r0, r9
   2b162:      	addeq	sp, #0x1c
   2b164:      	popeq.w	{r4, r5, r6, r7, r8, r9, r10, r11, pc}
   2b168:      	blx	0x3f4f0                 @ imm = #0x14384
   2b16c:      	blx	0x3ec1c <android_convertGralloc1To0Usage+0x666> @ imm = #0x13aac
   2b170:      	blx	0x3ebc4 <android_convertGralloc1To0Usage+0x60e> @ imm = #0x13a50
   2b174:      	blx	0x3ebc4 <android_convertGralloc1To0Usage+0x60e> @ imm = #0x13a4c
   2b178:      	strb	r6, [r1]
   2b17a:      	movs	r1, r0
   2b17c:      	strb	r2, [r7, #0x1]
   2b17e:      	movs	r1, r0
   2b180:      	strb	r2, [r7, #0x1]
   2b182:      	movs	r1, r0
   2b184:      	subs	r7, r5, #0x5
   2b186:      	movs	r0, r0
   2b188:      	subs	r5, r2, #0x5
   2b18a:      	movs	r0, r0
   2b18c:      	strb	r0, [r2, #0x1]
   2b18e:      	movs	r1, r0
   2b190:      	ldrh	r4, [r5, #0x26]
   2b192:      	movs	r1, r0
   2b194:      	ldr	r2, [r6, #0x74]
   2b196:      	movs	r1, r0
   2b198:      	ldr	r6, [r2, #0x64]
   2b19a:      	movs	r1, r0
