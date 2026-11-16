
/Users/manvindar.singh/HarnessAgents/hive/agents/pam-mw9kdvck/artifacts/android17-actions-20261115/provider-callers-43776923589/legacy_graphics/abi-consumers/1bec054223a83bf3014d758894e0ae1dbeb795fa7baa2e0132ad0cea94f33bc4.elf:	file format elf32-littlearm

Disassembly of section .text:

00006aec <_ZN7android8gralloc420decodeExtendableTypeEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common14ExtendableTypeE>:
    6aec:      	push	{r4, r5, r7, lr}
    6aee:      	mov	r5, r1
    6af0:      	mov	r4, r0
    6af2:      	blx	0xca40                  @ imm = #0x5f4c
    6af6:      	cmp	r0, #0x0
    6af8:      	it	ne
    6afa:      	popne	{r4, r5, r7, pc}
    6afc:      	ldr	r0, [r4]
    6afe:      	cbz	r0, 0x6b12 <_ZN7android8gralloc420decodeExtendableTypeEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common14ExtendableTypeE+0x26> @ imm = #0x10
    6b00:      	ldr	r1, [r4, #0x4]
    6b02:      	cmn.w	r1, #0x9
    6b06:      	bhi	0x6b12 <_ZN7android8gralloc420decodeExtendableTypeEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common14ExtendableTypeE+0x26> @ imm = #0x8
    6b08:      	ldr	r2, [r0, #0x8]
    6b0a:      	add.w	r3, r1, #0x8
    6b0e:      	cmp	r3, r2
    6b10:      	bls	0x6b18 <_ZN7android8gralloc420decodeExtendableTypeEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common14ExtendableTypeE+0x2c> @ imm = #0x4
    6b12:      	mvn	r0, #0x15
    6b16:      	pop	{r4, r5, r7, pc}
    6b18:      	ldr	r0, [r0]
    6b1a:      	ldr	r2, [r0, r1]
    6b1c:      	add	r0, r1
    6b1e:      	ldr	r0, [r0, #0x4]
    6b20:      	str	r0, [r5, #0x14]
    6b22:      	str	r2, [r5, #0x10]
    6b24:      	ldr	r0, [r4, #0x4]
    6b26:      	adds	r0, #0x8
    6b28:      	bhs	0x6b30 <_ZN7android8gralloc420decodeExtendableTypeEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common14ExtendableTypeE+0x44> @ imm = #0x4
    6b2a:      	str	r0, [r4, #0x4]
    6b2c:      	movs	r0, #0x0
    6b2e:      	pop	{r4, r5, r7, pc}
    6b30:      	blx	0xc830 <_ZN7android8gralloc414encodeMetadataINSt3__16vectorIhNS2_9allocatorIhEEEEEEiRKNS_8hardware8graphics6mapper4V4_07IMapper12MetadataTypeERKT_PNS7_8hidl_vecIhEEPFiSH_PNS0_13OutputHidlVecEE+0xf6c> @ imm = #0x5cfc
