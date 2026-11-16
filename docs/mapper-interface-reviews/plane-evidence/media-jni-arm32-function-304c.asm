
/Users/manvindar.singh/HarnessAgents/hive/agents/pam-mw9kdvck/artifacts/android17-actions-20261115/provider-callers-43776923589/legacy_graphics/abi-consumers/83587929f18e3aaa432fcb82b7c7ceff1dad5f94470cf494d092abb20360b920.elf:	file format elf32-littlearm

Disassembly of section .text:

00002c84 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE>:
    304c:      	push.w	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
    3050:      	sub	sp, #0x2c
    3052:      	mov	r9, r0
    3054:      	ldr	r0, [pc, #0x1a0]        @ 0x31f8 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x574>
    3056:      	mov	r10, r1
    3058:      	ldr	r1, [pc, #0x1a0]        @ 0x31fc <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x578>
    305a:      	add	r0, pc
    305c:      	mov	r11, r2
    305e:      	add	r1, pc
    3060:      	ldr	r4, [r0]
    3062:      	ldr	r1, [r1]
    3064:      	mov	r0, r4
    3066:      	ldr	r1, [r1]
    3068:      	str	r1, [sp, #0x28]
    306a:      	blx	0x35a0                  @ imm = #0x534
    306e:      	ldr	r0, [pc, #0x190]        @ 0x3200 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x57c>
    3070:      	add	r0, pc
    3072:      	ldr	r6, [r0]
    3074:      	ldr	r7, [r6]
    3076:      	cbnz	r7, 0x3086 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x402> @ imm = #0xc
    3078:      	movs	r0, #0x8
    307a:      	blx	0x35b0                  @ imm = #0x534
    307e:      	mov	r7, r0
    3080:      	blx	0x35c0                  @ imm = #0x53c
    3084:      	str	r0, [r6]
    3086:      	mov	r0, r4
    3088:      	blx	0x35d0                  @ imm = #0x544
    308c:      	ldr.w	r0, [r9]
    3090:      	add.w	r8, sp, #0x18
    3094:      	mov	r2, r8
    3096:      	ldr	r1, [r0, #0x44]
    3098:      	movs	r0, #0x0
    309a:      	strd	r0, r0, [sp, #24]
    309e:      	str	r0, [sp, #0x20]
    30a0:      	mov	r0, r7
    30a2:      	blx	0x35e0                  @ imm = #0x53c
    30a6:      	mov	r7, r0
    30a8:      	cmp	r0, #0x0
    30aa:      	bne.w	0x31d2 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x54e> @ imm = #0x124
    30ae:      	ldrd	r0, r2, [sp, #24]
    30b2:      	cmp	r0, r2
    30b4:      	beq	0x319e <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x51a> @ imm = #0xe6
    30b6:      	movs	r1, #0x0
    30b8:      	movs	r6, #0x0
    30ba:      	movs	r7, #0x0
    30bc:      	movs	r5, #0x0
    30be:      	movs	r4, #0x0
    30c0:      	str	r2, [sp, #0x4]
    30c2:      	ldrd	lr, r3, [r0]
    30c6:      	cmp	lr, r3
    30c8:      	beq	0x3198 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x514> @ imm = #0xcc
    30ca:      	strd	r5, r4, [sp, #16]
    30ce:      	mov	r5, r10
    30d0:      	strd	r1, r7, [sp, #8]
    30d4:      	mov	r4, r6
    30d6:      	movs	r1, #0x0
    30d8:      	mov.w	r12, #0x0
    30dc:      	mov	r7, lr
    30de:      	ldrd	r6, r10, [r7, #32]
    30e2:      	eor	r6, r6, #0xa
    30e6:      	orrs.w	r6, r6, r10
    30ea:      	bne	0x3198 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x514> @ imm = #0xaa
    30ec:      	ldrd	r6, r2, [r7, #16]
    30f0:      	adds	r7, #0x28
    30f2:      	orr.w	r12, r12, r2
    30f6:      	cmp	r7, r3
    30f8:      	orr.w	r1, r1, r6
    30fc:      	bne	0x30de <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x45a> @ imm = #-0x22
    30fe:      	eor	r2, r1, #0x6
    3102:      	orrs.w	r2, r2, r12
    3106:      	beq	0x313a <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x4b6> @ imm = #0x30
    3108:      	eor	r1, r1, #0x1
    310c:      	orrs.w	r1, r1, r12
    3110:      	bne	0x3198 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x514> @ imm = #0x84
    3112:      	ldrd	r1, r2, [r0, #24]
    3116:      	eor	r1, r1, #0x10
    311a:      	orrs	r1, r2
    311c:      	bne	0x3198 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x514> @ imm = #0x78
    311e:      	ldrd	r1, r2, [lr, #24]
    3122:      	eor	r1, r1, #0x6
    3126:      	orrs	r1, r2
    3128:      	bne	0x3198 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x514> @ imm = #0x6c
    312a:      	ldr	r1, [r0, #0x10]
    312c:      	mov	r10, r5
    312e:      	ldr	r7, [r0, #0x20]
    3130:      	mov	r6, r4
    3132:      	add	r1, r5
    3134:      	ldrd	r5, r4, [sp, #16]
    3138:      	b	0x318e <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x50a> @ imm = #0x52
    313a:      	ldrd	r1, r2, [r0, #24]
    313e:      	eor	r1, r1, #0x20
    3142:      	orrs	r1, r2
    3144:      	bne	0x3198 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x514> @ imm = #0x50
    3146:      	mov	r10, r5
    3148:      	b	0x315e <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x4da> @ imm = #0x12
    314a:      	ldrd	r1, r2, [lr, #24]
    314e:      	eor	r1, r1, #0x16
    3152:      	orrs	r1, r2
    3154:      	bne	0x3198 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x514> @ imm = #0x40
    3156:      	add.w	lr, lr, #0x28
    315a:      	cmp	lr, r3
    315c:      	beq	0x3180 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x4fc> @ imm = #0x20
    315e:      	ldrd	r7, r1, [lr, #16]
    3162:      	eor	r2, r7, #0x4
    3166:      	orrs	r2, r1
    3168:      	beq	0x314a <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x4c6> @ imm = #-0x22
    316a:      	eor	r2, r7, #0x2
    316e:      	orrs	r1, r2
    3170:      	bne	0x3156 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x4d2> @ imm = #-0x1e
    3172:      	ldrd	r1, r2, [lr, #24]
    3176:      	eor	r1, r1, #0x6
    317a:      	orrs	r1, r2
    317c:      	beq	0x3156 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x4d2> @ imm = #-0x2a
    317e:      	b	0x3198 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x514> @ imm = #0x16
    3180:      	ldr	r1, [r0, #0x10]
    3182:      	ldr	r6, [r0, #0x20]
    3184:      	add.w	r4, r10, r1
    3188:      	ldrd	r1, r7, [sp, #8]
    318c:      	adds	r5, r4, #0x2
    318e:      	adds	r0, #0x50
    3190:      	ldr	r2, [sp, #0x4]
    3192:      	cmp	r0, r2
    3194:      	bne	0x30c2 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x43e> @ imm = #-0xd6
    3196:      	b	0x31a8 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x524> @ imm = #0xe
    3198:      	mvn	r7, #0x15
    319c:      	b	0x31d2 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x54e> @ imm = #0x32
    319e:      	movs	r4, #0x0
    31a0:      	movs	r5, #0x0
    31a2:      	movs	r7, #0x0
    31a4:      	movs	r6, #0x0
    31a6:      	movs	r1, #0x0
    31a8:      	str.w	r1, [r11]
    31ac:      	movs	r2, #0x4
    31ae:      	ldr.w	r0, [r9]
    31b2:      	movs	r1, #0x3c
    31b4:      	add.w	r3, r11, #0x48
    31b8:      	ldr	r0, [r0, #0x28]
    31ba:      	str.w	r0, [r11, #0x4]
    31be:      	ldr.w	r0, [r9]
    31c2:      	ldr	r0, [r0, #0x2c]
    31c4:      	str.w	r2, [r11, #0x58]
    31c8:      	add.w	r2, r11, #0x8
    31cc:      	stm	r2!, {r0, r1, r7}
    31ce:      	movs	r7, #0x0
    31d0:      	stm	r3!, {r1, r4, r5, r6}
    31d2:      	add	r0, sp, #0x24
    31d4:      	str.w	r8, [sp, #0x24]
    31d8:      	bl	0x3438 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x10c> @ imm = #0x25c
    31dc:      	ldr	r0, [sp, #0x28]
    31de:      	ldr	r1, [pc, #0x24]         @ 0x3204 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x580>
    31e0:      	add	r1, pc
    31e2:      	ldr	r1, [r1]
    31e4:      	ldr	r1, [r1]
    31e6:      	cmp	r1, r0
    31e8:      	ittt	eq
    31ea:      	moveq	r0, r7
    31ec:      	addeq	sp, #0x2c
    31ee:      	popeq.w	{r4, r5, r6, r7, r8, r9, r10, r11, pc}
    31f2:      	blx	0x3550                  @ imm = #0x35c
    31f6:      	nop
    31f8:      	asrs	r2, r7, #0x1b
    31fa:      	movs	r0, r0
    31fc:      	asrs	r2, r6, #0x1b
    31fe:      	movs	r0, r0
    3200:      	asrs	r0, r5, #0x1b
    3202:      	movs	r0, r0
    3204:      	asrs	r0, r6, #0x15
    3206:      	movs	r0, r0
