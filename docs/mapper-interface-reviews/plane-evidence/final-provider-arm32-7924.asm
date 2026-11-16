
/Users/manvindar.singh/HarnessAgents/hive/agents/pam-mw9kdvck/artifacts/android17-actions-20261115/provider-callers-43776923589/legacy_graphics/abi-consumers/1bec054223a83bf3014d758894e0ae1dbeb795fa7baa2e0132ad0cea94f33bc4.elf:	file format elf32-littlearm

Disassembly of section .text:

00007924 <_ZN7android8gralloc424decodePlaneLayoutsHelperEPNS0_12InputHidlVecEPNSt3__16vectorIN4aidl7android8hardware8graphics6common11PlaneLayoutENS3_9allocatorISA_EEEE>:
    7924:      	push.w	{r4, r5, r6, r7, r8, lr}
    7928:      	vpush	{d8, d9}
    792c:      	mov	r5, r0
    792e:      	ldr	r0, [r0]
    7930:      	cbz	r0, 0x79a8 <_ZN7android8gralloc424decodePlaneLayoutsHelperEPNS0_12InputHidlVecEPNSt3__16vectorIN4aidl7android8hardware8graphics6common11PlaneLayoutENS3_9allocatorISA_EEEE+0x84> @ imm = #0x74
    7932:      	mov	r4, r1
    7934:      	ldr	r1, [r5, #0x4]
    7936:      	cmn.w	r1, #0x9
    793a:      	bhi	0x79a8 <_ZN7android8gralloc424decodePlaneLayoutsHelperEPNS0_12InputHidlVecEPNSt3__16vectorIN4aidl7android8hardware8graphics6common11PlaneLayoutENS3_9allocatorISA_EEEE+0x84> @ imm = #0x6a
    793c:      	ldr	r3, [r0, #0x8]
    793e:      	add.w	r2, r1, #0x8
    7942:      	cmp	r2, r3
    7944:      	bhi	0x79a8 <_ZN7android8gralloc424decodePlaneLayoutsHelperEPNS0_12InputHidlVecEPNSt3__16vectorIN4aidl7android8hardware8graphics6common11PlaneLayoutENS3_9allocatorISA_EEEE+0x84> @ imm = #0x60
    7946:      	ldr	r0, [r0]
    7948:      	ldr.w	r8, [r0, r1]
    794c:      	add	r0, r1
    794e:      	ldr	r7, [r0, #0x4]
    7950:      	str	r2, [r5, #0x4]
    7952:      	cmp	r7, #0x0
    7954:      	bmi	0x79a8 <_ZN7android8gralloc424decodePlaneLayoutsHelperEPNS0_12InputHidlVecEPNSt3__16vectorIN4aidl7android8hardware8graphics6common11PlaneLayoutENS3_9allocatorISA_EEEE+0x84> @ imm = #0x50
    7956:      	orrs.w	r0, r8, r7
    795a:      	beq	0x79b4 <_ZN7android8gralloc424decodePlaneLayoutsHelperEPNS0_12InputHidlVecEPNSt3__16vectorIN4aidl7android8hardware8graphics6common11PlaneLayoutENS3_9allocatorISA_EEEE+0x90> @ imm = #0x56
    795c:      	vmov.i32	q4, #0x0
    7960:      	movs	r6, #0x0
    7962:      	ldrd	r0, r1, [r4, #4]
    7966:      	cmp	r0, r1
    7968:      	bhs	0x79a0 <_ZN7android8gralloc424decodePlaneLayoutsHelperEPNS0_12InputHidlVecEPNSt3__16vectorIN4aidl7android8hardware8graphics6common11PlaneLayoutENS3_9allocatorISA_EEEE+0x7c> @ imm = #0x34
    796a:      	vst1.32	{d8, d9}, [r0]!
    796e:      	vst1.32	{d8, d9}, [r0]!
    7972:      	vst1.32	{d8, d9}, [r0]!
    7976:      	vst1.32	{d8, d9}, [r0]!
    797a:      	vst1.32	{d8, d9}, [r0]!
    797e:      	sub.w	r1, r0, #0x50
    7982:      	str	r0, [r4, #0x4]
    7984:      	mov	r0, r5
    7986:      	blx	0xcb90                  @ imm = #0x5208
    798a:      	cbnz	r0, 0x79ac <_ZN7android8gralloc424decodePlaneLayoutsHelperEPNS0_12InputHidlVecEPNSt3__16vectorIN4aidl7android8hardware8graphics6common11PlaneLayoutENS3_9allocatorISA_EEEE+0x88> @ imm = #0x1e
    798c:      	adds	r1, r6, #0x1
    798e:      	bhs	0x79be <_ZN7android8gralloc424decodePlaneLayoutsHelperEPNS0_12InputHidlVecEPNSt3__16vectorIN4aidl7android8hardware8graphics6common11PlaneLayoutENS3_9allocatorISA_EEEE+0x9a> @ imm = #0x2c
    7990:      	adds	r6, #0x1
    7992:      	movs	r0, #0x0
    7994:      	subs.w	r1, r1, r8
    7998:      	sbcs.w	r1, r0, r7
    799c:      	blo	0x7962 <_ZN7android8gralloc424decodePlaneLayoutsHelperEPNS0_12InputHidlVecEPNSt3__16vectorIN4aidl7android8hardware8graphics6common11PlaneLayoutENS3_9allocatorISA_EEEE+0x3e> @ imm = #-0x3e
    799e:      	b	0x79ac <_ZN7android8gralloc424decodePlaneLayoutsHelperEPNS0_12InputHidlVecEPNSt3__16vectorIN4aidl7android8hardware8graphics6common11PlaneLayoutENS3_9allocatorISA_EEEE+0x88> @ imm = #0xa
    79a0:      	mov	r0, r4
    79a2:      	bl	0xb108 <_ZN7android8gralloc431getPlaneLayoutComponentTypeNameERKN4aidl7android8hardware8graphics6common14ExtendableTypeE+0x3b8> @ imm = #0x3762
    79a6:      	b	0x797e <_ZN7android8gralloc424decodePlaneLayoutsHelperEPNS0_12InputHidlVecEPNSt3__16vectorIN4aidl7android8hardware8graphics6common11PlaneLayoutENS3_9allocatorISA_EEEE+0x5a> @ imm = #-0x2c
    79a8:      	mvn	r0, #0x15
    79ac:      	vpop	{d8, d9}
    79b0:      	pop.w	{r4, r5, r6, r7, r8, pc}
    79b4:      	movs	r0, #0x0
    79b6:      	vpop	{d8, d9}
    79ba:      	pop.w	{r4, r5, r6, r7, r8, pc}
    79be:      	blx	0xc830 <_ZN7android8gralloc414encodeMetadataINSt3__16vectorIhNS2_9allocatorIhEEEEEEiRKNS_8hardware8graphics6mapper4V4_07IMapper12MetadataTypeERKT_PNS7_8hidl_vecIhEEPFiSH_PNS0_13OutputHidlVecEE+0xf6c> @ imm = #0x4e70
