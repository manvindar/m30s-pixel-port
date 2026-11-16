
/Users/manvindar.singh/HarnessAgents/hive/agents/pam-mw9kdvck/artifacts/android17-actions-20261115/provider-callers-43776923589/legacy_graphics/abi-consumers/83587929f18e3aaa432fcb82b7c7ceff1dad5f94470cf494d092abb20360b920.elf:	file format elf32-littlearm

Disassembly of section .text:

00002c84 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE>:
    2e90:      	push.w	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
    2e94:      	sub	sp, #0x2c
    2e96:      	mov	r9, r0
    2e98:      	ldr	r0, [pc, #0x1a0]        @ 0x303c <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x3b8>
    2e9a:      	mov	r10, r1
    2e9c:      	ldr	r1, [pc, #0x1a0]        @ 0x3040 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x3bc>
    2e9e:      	add	r0, pc
    2ea0:      	mov	r11, r2
    2ea2:      	add	r1, pc
    2ea4:      	ldr	r4, [r0]
    2ea6:      	ldr	r1, [r1]
    2ea8:      	mov	r0, r4
    2eaa:      	ldr	r1, [r1]
    2eac:      	str	r1, [sp, #0x28]
    2eae:      	blx	0x35a0                  @ imm = #0x6f0
    2eb2:      	ldr	r0, [pc, #0x190]        @ 0x3044 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x3c0>
    2eb4:      	add	r0, pc
    2eb6:      	ldr	r6, [r0]
    2eb8:      	ldr	r7, [r6]
    2eba:      	cbnz	r7, 0x2eca <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x246> @ imm = #0xc
    2ebc:      	movs	r0, #0x8
    2ebe:      	blx	0x35b0                  @ imm = #0x6f0
    2ec2:      	mov	r7, r0
    2ec4:      	blx	0x35c0                  @ imm = #0x6f8
    2ec8:      	str	r0, [r6]
    2eca:      	mov	r0, r4
    2ecc:      	blx	0x35d0                  @ imm = #0x700
    2ed0:      	ldr.w	r0, [r9]
    2ed4:      	add.w	r8, sp, #0x18
    2ed8:      	mov	r2, r8
    2eda:      	ldr	r1, [r0, #0x44]
    2edc:      	movs	r0, #0x0
    2ede:      	strd	r0, r0, [sp, #24]
    2ee2:      	str	r0, [sp, #0x20]
    2ee4:      	mov	r0, r7
    2ee6:      	blx	0x35e0                  @ imm = #0x6f8
    2eea:      	mov	r7, r0
    2eec:      	cmp	r0, #0x0
    2eee:      	bne.w	0x3016 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x392> @ imm = #0x124
    2ef2:      	ldrd	r0, r2, [sp, #24]
    2ef6:      	cmp	r0, r2
    2ef8:      	beq	0x2fe2 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x35e> @ imm = #0xe6
    2efa:      	movs	r1, #0x0
    2efc:      	movs	r6, #0x0
    2efe:      	movs	r7, #0x0
    2f00:      	movs	r5, #0x0
    2f02:      	movs	r4, #0x0
    2f04:      	str	r2, [sp, #0x4]
    2f06:      	ldrd	lr, r3, [r0]
    2f0a:      	cmp	lr, r3
    2f0c:      	beq	0x2fdc <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x358> @ imm = #0xcc
    2f0e:      	strd	r5, r4, [sp, #16]
    2f12:      	mov	r5, r10
    2f14:      	strd	r1, r7, [sp, #8]
    2f18:      	mov	r4, r6
    2f1a:      	movs	r1, #0x0
    2f1c:      	mov.w	r12, #0x0
    2f20:      	mov	r7, lr
    2f22:      	ldrd	r6, r10, [r7, #32]
    2f26:      	eor	r6, r6, #0xa
    2f2a:      	orrs.w	r6, r6, r10
    2f2e:      	bne	0x2fdc <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x358> @ imm = #0xaa
    2f30:      	ldrd	r6, r2, [r7, #16]
    2f34:      	adds	r7, #0x28
    2f36:      	orr.w	r12, r12, r2
    2f3a:      	cmp	r7, r3
    2f3c:      	orr.w	r1, r1, r6
    2f40:      	bne	0x2f22 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x29e> @ imm = #-0x22
    2f42:      	eor	r2, r1, #0x6
    2f46:      	orrs.w	r2, r2, r12
    2f4a:      	beq	0x2f7e <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x2fa> @ imm = #0x30
    2f4c:      	eor	r1, r1, #0x1
    2f50:      	orrs.w	r1, r1, r12
    2f54:      	bne	0x2fdc <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x358> @ imm = #0x84
    2f56:      	ldrd	r1, r2, [r0, #24]
    2f5a:      	eor	r1, r1, #0x10
    2f5e:      	orrs	r1, r2
    2f60:      	bne	0x2fdc <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x358> @ imm = #0x78
    2f62:      	ldrd	r1, r2, [lr, #24]
    2f66:      	eor	r1, r1, #0x6
    2f6a:      	orrs	r1, r2
    2f6c:      	bne	0x2fdc <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x358> @ imm = #0x6c
    2f6e:      	ldr	r1, [r0, #0x10]
    2f70:      	mov	r10, r5
    2f72:      	ldr	r7, [r0, #0x20]
    2f74:      	mov	r6, r4
    2f76:      	add	r1, r5
    2f78:      	ldrd	r5, r4, [sp, #16]
    2f7c:      	b	0x2fd2 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x34e> @ imm = #0x52
    2f7e:      	ldrd	r1, r2, [r0, #24]
    2f82:      	eor	r1, r1, #0x20
    2f86:      	orrs	r1, r2
    2f88:      	bne	0x2fdc <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x358> @ imm = #0x50
    2f8a:      	mov	r10, r5
    2f8c:      	b	0x2fa2 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x31e> @ imm = #0x12
    2f8e:      	ldrd	r1, r2, [lr, #24]
    2f92:      	eor	r1, r1, #0x16
    2f96:      	orrs	r1, r2
    2f98:      	bne	0x2fdc <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x358> @ imm = #0x40
    2f9a:      	add.w	lr, lr, #0x28
    2f9e:      	cmp	lr, r3
    2fa0:      	beq	0x2fc4 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x340> @ imm = #0x20
    2fa2:      	ldrd	r7, r1, [lr, #16]
    2fa6:      	eor	r2, r7, #0x4
    2faa:      	orrs	r2, r1
    2fac:      	beq	0x2f8e <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x30a> @ imm = #-0x22
    2fae:      	eor	r2, r7, #0x2
    2fb2:      	orrs	r1, r2
    2fb4:      	bne	0x2f9a <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x316> @ imm = #-0x1e
    2fb6:      	ldrd	r1, r2, [lr, #24]
    2fba:      	eor	r1, r1, #0x6
    2fbe:      	orrs	r1, r2
    2fc0:      	beq	0x2f9a <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x316> @ imm = #-0x2a
    2fc2:      	b	0x2fdc <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x358> @ imm = #0x16
    2fc4:      	ldr	r1, [r0, #0x10]
    2fc6:      	ldr	r6, [r0, #0x20]
    2fc8:      	add.w	r4, r10, r1
    2fcc:      	ldrd	r1, r7, [sp, #8]
    2fd0:      	adds	r5, r4, #0x2
    2fd2:      	adds	r0, #0x50
    2fd4:      	ldr	r2, [sp, #0x4]
    2fd6:      	cmp	r0, r2
    2fd8:      	bne	0x2f06 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x282> @ imm = #-0xd6
    2fda:      	b	0x2fec <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x368> @ imm = #0xe
    2fdc:      	mvn	r7, #0x15
    2fe0:      	b	0x3016 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x392> @ imm = #0x32
    2fe2:      	movs	r4, #0x0
    2fe4:      	movs	r5, #0x0
    2fe6:      	movs	r7, #0x0
    2fe8:      	movs	r6, #0x0
    2fea:      	movs	r1, #0x0
    2fec:      	str.w	r1, [r11]
    2ff0:      	movs	r2, #0x4
    2ff2:      	ldr.w	r0, [r9]
    2ff6:      	movs	r1, #0x36
    2ff8:      	add.w	r3, r11, #0x48
    2ffc:      	ldr	r0, [r0, #0x28]
    2ffe:      	str.w	r0, [r11, #0x4]
    3002:      	ldr.w	r0, [r9]
    3006:      	ldr	r0, [r0, #0x2c]
    3008:      	str.w	r2, [r11, #0x58]
    300c:      	add.w	r2, r11, #0x8
    3010:      	stm	r2!, {r0, r1, r7}
    3012:      	movs	r7, #0x0
    3014:      	stm	r3!, {r1, r4, r5, r6}
    3016:      	add	r0, sp, #0x24
    3018:      	str.w	r8, [sp, #0x24]
    301c:      	bl	0x3438 <_ZN7android23checkAndClearBlobFooterEPNS_10BufferItemERNS_2spINS_5FenceEEE+0x10c> @ imm = #0x418
    3020:      	ldr	r0, [sp, #0x28]
    3022:      	ldr	r1, [pc, #0x24]         @ 0x3048 <_ZN7android19lockImageFromBufferENS_2spINS_13GraphicBufferEEEjRKNS_4RectEiPNS_11CpuConsumer12LockedBufferE+0x3c4>
    3024:      	add	r1, pc
    3026:      	ldr	r1, [r1]
    3028:      	ldr	r1, [r1]
    302a:      	cmp	r1, r0
    302c:      	ittt	eq
    302e:      	moveq	r0, r7
    3030:      	addeq	sp, #0x2c
    3032:      	popeq.w	{r4, r5, r6, r7, r8, r9, r10, r11, pc}
    3036:      	blx	0x3550                  @ imm = #0x518
    303a:      	nop
    303c:      	adds	r6, r6, r2
    303e:      	movs	r0, r0
    3040:      	adds	r6, r5, r2
    3042:      	movs	r0, r0
    3044:      	adds	r4, r4, r2
    3046:      	movs	r0, r0
    3048:      	asrs	r4, r5, #0x1c
    304a:      	movs	r0, r0
