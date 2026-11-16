; stagefright32-classified-code-14e8ec.asm
  14ebc6:      	ldr	r0, [pc, #0x200]        @ 0x14edc8 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x5358>
  14ebc8:      	add	r0, pc
  14ebca:      	ldr	r5, [r0]
  14ebcc:      	mov	r0, r5
  14ebce:      	blx	0x1767a0                @ imm = #0x27bd0
  14ebd2:      	movs	r1, #0x0
  14ebd4:      	cmp	r1, r0
  14ebd6:      	bvs.w	0x14f63a <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x5bca> @ imm = #0xa60
  14ebda:      	ldr	r0, [pc, #0x1f0]        @ 0x14edcc <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x535c>
  14ebdc:      	add	r0, pc
  14ebde:      	ldr	r4, [r0]
  14ebe0:      	ldr	r7, [r4]
  14ebe2:      	cbnz	r7, 0x14ebf2 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x5182> @ imm = #0xc
  14ebe4:      	movs	r0, #0x8
  14ebe6:      	blx	0x174e80                @ imm = #0x26298
  14ebea:      	mov	r7, r0
  14ebec:      	blx	0x17a670                @ imm = #0x2ba80
  14ebf0:      	str	r0, [r4]
  14ebf2:      	mov	r0, r5
  14ebf4:      	blx	0x1767b0                @ imm = #0x27bb8
  14ebf8:      	ldrd	r0, r1, [r8, #44]
  14ebfc:      	vmov.i32	q8, #0x0
  14ec00:      	strd	r0, r1, [sp, #108]
  14ec04:      	add	r0, sp, #0x98
  14ec06:      	ldr.w	r1, [r8, #0x4]
  14ec0a:      	movs	r2, #0x0
  14ec0c:      	mov	r3, r0
  14ec0e:      	strd	r2, r2, [sp, #100]
  14ec12:      	vst1.64	{d16, d17}, [r3]!
  14ec16:      	vst1.64	{d16, d17}, [r3]!
  14ec1a:      	vst1.64	{d16, d17}, [r3]!
  14ec1e:      	str	r2, [sp, #0x8c]
  14ec20:      	str	r2, [r3]
  14ec22:      	str	r2, [sp, #0xcc]
  14ec24:      	cbz	r1, 0x14ec42 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x51d2> @ imm = #0x1a
  14ec26:      	ldr	r0, [sp, #0x94]
  14ec28:      	add	r3, sp, #0x64
  14ec2a:      	movs	r2, #0x20
  14ec2c:      	ldr	r1, [r0, #0x3c]
  14ec2e:      	add	r0, sp, #0x8c
  14ec30:      	str	r0, [sp]
  14ec32:      	mov	r0, r7
  14ec34:      	blx	0x17a640                @ imm = #0x2ba08
  14ec38:      	cbz	r0, 0x14ec88 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x5218> @ imm = #0x4c
  14ec3a:      	ldr	r1, [pc, #0x194]        @ 0x14edd0 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x5360>
  14ec3c:      	add	r1, pc
  14ec3e:      	b.w	0x14f5fa <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x5b8a> @ imm = #0x9b8
  14ec42:      	ldr.w	r1, [r8]
  14ec46:      	movs	r2, #0xff
  14ec48:      	movt	r2, #0x7f00
  14ec4c:      	cmp	r1, r2
  14ec4e:      	bgt	0x14ec5a <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x51ea> @ imm = #0x8
  14ec50:      	cmp	r1, #0x13
  14ec52:      	it	ne
  14ec54:      	cmpne	r1, #0x15
  14ec56:      	beq	0x14ec72 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x5202> @ imm = #0x18
  14ec58:      	b	0x14ec26 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x51b6> @ imm = #-0x36
  14ec5a:      	movw	r2, #0x16b
  14ec5e:      	movt	r2, #0x7f42
  14ec62:      	cmp	r1, r2
  14ec64:      	ittt	ne
  14ec66:      	movwne	r2, #0x100
  14ec6a:      	movtne	r2, #0x7f00
  14ec6e:      	cmpne	r1, r2
  14ec70:      	bne	0x14ec26 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x51b6> @ imm = #-0x4e
  14ec72:      	ldr	r1, [sp, #0x94]
  14ec74:      	add	r3, sp, #0x64
  14ec76:      	movs	r2, #0x20
  14ec78:      	ldr	r1, [r1, #0x3c]
  14ec7a:      	str	r0, [sp]
  14ec7c:      	mov	r0, r7
  14ec7e:      	blx	0x17a630                @ imm = #0x2b9b0
  14ec82:      	cmp	r0, #0x0
  14ec84:      	bne.w	0x14f644 <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x5bd4> @ imm = #0x9bc
; stagefright32-classified-code-14e8ec.asm
  14ecee:      	ldr	r0, [sp, #0x94]
  14ecf0:      	movs	r2, #0x0
  14ecf2:      	movs	r4, #0x0
  14ecf4:      	ldr	r1, [r0, #0x3c]
  14ecf6:      	ldr	r0, [sp, #0x38]
  14ecf8:      	blx	0x17a650                @ imm = #0x2b954
  14ecfc:      	cmp	r0, #0x0
  14ecfe:      	bne.w	0x14f63e <_ZNK7android7content22AttributionSourceState13writeToParcelEPNS_6ParcelE+0x5bce> @ imm = #0x93c
; stagefright32-patched-389fc.asm
   38a78:      	ldr	r1, [sp, #0x48]
   38a7a:      	movs	r4, #0x0
   38a7c:      	ldr	r2, [sp, #0x10]
   38a7e:      	str	r2, [r1]
   38a80:      	b	0x38a86 <_ZN7android19GraphicBufferMapper4lockEPK13native_handlejRKNS_4RectEPPv+0x8a> @ imm = #0x2
; stagefright32-patched-38adc.asm
   38b70:      	vld1.32	{d16, d17}, [r4]!
   38b74:      	ldr	r1, [sp, #0x80]
   38b76:      	vld1.32	{d18, d19}, [r4]!
   38b7a:      	vst1.32	{d16, d17}, [r1]!
   38b7e:      	vld1.32	{d20, d21}, [r4]!
   38b82:      	vst1.32	{d18, d19}, [r1]!
   38b86:      	vldr	d22, [r4]
   38b8a:      	movs	r4, #0x0
   38b8c:      	vst1.32	{d20, d21}, [r1]!
   38b90:      	vstr	d22, [r1]
; stagefright32-latest-356d0.asm
   35764:      	vld1.32	{d16, d17}, [r4]!
   35768:      	ldr	r1, [sp, #0x80]
   3576a:      	vld1.32	{d18, d19}, [r4]!
   3576e:      	vst1.32	{d16, d17}, [r1]!
   35772:      	vld1.32	{d20, d21}, [r4]!
   35776:      	vst1.32	{d18, d19}, [r1]!
   3577a:      	vldr	d22, [r4]
   3577e:      	movs	r4, #0x0
   35780:      	vst1.32	{d20, d21}, [r1]!
   35784:      	vstr	d22, [r1]
