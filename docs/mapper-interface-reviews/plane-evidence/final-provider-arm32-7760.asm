
/Users/manvindar.singh/HarnessAgents/hive/agents/pam-mw9kdvck/artifacts/android17-actions-20261115/provider-callers-43776923589/legacy_graphics/abi-consumers/1bec054223a83bf3014d758894e0ae1dbeb795fa7baa2e0132ad0cea94f33bc4.elf:	file format elf32-littlearm

Disassembly of section .text:

00007760 <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE>:
    7760:      	push	{r4, r5, r6, r7, lr}
    7762:      	sub	sp, #0x4
    7764:      	cmp	r1, #0x0
    7766:      	ittt	ne
    7768:      	movne	r4, r0
    776a:      	ldrne	r0, [r0]
    776c:      	cmpne	r0, #0x0
    776e:      	bne	0x7778 <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x18> @ imm = #0x6
    7770:      	mvn	r0, #0x15
    7774:      	add	sp, #0x4
    7776:      	pop	{r4, r5, r6, r7, pc}
    7778:      	ldr	r3, [r4, #0x4]
    777a:      	cmn.w	r3, #0x9
    777e:      	bhi	0x7770 <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x10> @ imm = #-0x12
    7780:      	ldr	r2, [r0, #0x8]
    7782:      	add.w	r7, r3, #0x8
    7786:      	cmp	r7, r2
    7788:      	bhi	0x7770 <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x10> @ imm = #-0x1c
    778a:      	ldr	r0, [r0]
    778c:      	ldr	r2, [r0, r3]
    778e:      	add	r0, r3
    7790:      	movs	r3, #0x0
    7792:      	ldr	r0, [r0, #0x4]
    7794:      	str	r7, [r4, #0x4]
    7796:      	movw	r7, #0x2710
    779a:      	subs	r7, r7, r2
    779c:      	sbcs.w	r0, r3, r0
    77a0:      	blo	0x7770 <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x10> @ imm = #-0x34
    77a2:      	mov	r0, r1
    77a4:      	mov	r5, r1
    77a6:      	mov	r1, r2
    77a8:      	bl	0x744c <_ZN7android8gralloc427decodePlaneLayoutComponentsEPNS0_12InputHidlVecEPNSt3__16vectorIN4aidl7android8hardware8graphics6common20PlaneLayoutComponentENS3_9allocatorISA_EEEE+0x68> @ imm = #-0x360
    77ac:      	mov	r6, r5
    77ae:      	ldrd	r5, r7, [r5]
    77b2:      	cmp	r5, r7
    77b4:      	beq	0x77c8 <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x68> @ imm = #0x10
    77b6:      	mov	r0, r4
    77b8:      	mov	r1, r5
    77ba:      	blx	0xcb70                  @ imm = #0x53b4
    77be:      	cmp	r0, #0x0
    77c0:      	bne	0x7882 <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x122> @ imm = #0xbe
    77c2:      	adds	r5, #0x28
    77c4:      	cmp	r5, r7
    77c6:      	bne	0x77b6 <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x56> @ imm = #-0x14
    77c8:      	ldr	r0, [r4]
    77ca:      	cmp	r0, #0x0
    77cc:      	beq	0x7770 <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x10> @ imm = #-0x60
    77ce:      	ldr	r1, [r4, #0x4]
    77d0:      	cmn.w	r1, #0x9
    77d4:      	bhi	0x7770 <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x10> @ imm = #-0x68
    77d6:      	ldr	r2, [r0, #0x8]
    77d8:      	add.w	r3, r1, #0x8
    77dc:      	cmp	r3, r2
    77de:      	bhi	0x7770 <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x10> @ imm = #-0x72
    77e0:      	ldr	r0, [r0]
    77e2:      	ldr	r2, [r0, r1]
    77e4:      	add	r0, r1
    77e6:      	ldr	r0, [r0, #0x4]
    77e8:      	str	r0, [r6, #0x14]
    77ea:      	str	r2, [r6, #0x10]
    77ec:      	ldr	r0, [r4, #0x4]
    77ee:      	adds.w	r2, r0, #0x8
    77f2:      	bhs	0x7896 <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x136> @ imm = #0xa0
    77f4:      	ldr	r3, [r4]
    77f6:      	mvn	r0, #0x15
    77fa:      	str	r2, [r4, #0x4]
    77fc:      	cmp	r3, #0x0
    77fe:      	beq	0x7882 <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x122> @ imm = #0x80
    7800:      	cmn.w	r2, #0x9
    7804:      	bhi	0x7882 <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x122> @ imm = #0x7a
    7806:      	ldr	r0, [r3, #0x8]
    7808:      	add.w	r7, r2, #0x8
    780c:      	cmp	r7, r0
    780e:      	bhi	0x7770 <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x10> @ imm = #-0xa2
    7810:      	ldr	r0, [r3]
    7812:      	mov	r1, r6
    7814:      	ldr	r3, [r0, r2]
    7816:      	add	r0, r2
    7818:      	ldr	r0, [r0, #0x4]
    781a:      	str	r0, [r6, #0x1c]
    781c:      	str	r3, [r6, #0x18]
    781e:      	ldr	r0, [r4, #0x4]
    7820:      	adds.w	r2, r0, #0x8
    7824:      	bhs	0x789a <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x13a> @ imm = #0x72
    7826:      	ldr	r3, [r4]
    7828:      	mvn	r0, #0x15
    782c:      	str	r2, [r4, #0x4]
    782e:      	cbz	r3, 0x7882 <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x122> @ imm = #0x50
    7830:      	cmn.w	r2, #0x9
    7834:      	bhi	0x7882 <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x122> @ imm = #0x4a
    7836:      	ldr	r0, [r3, #0x8]
    7838:      	add.w	r7, r2, #0x8
    783c:      	cmp	r7, r0
    783e:      	bhi	0x7770 <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x10> @ imm = #-0xd2
    7840:      	ldr	r0, [r3]
    7842:      	ldr	r3, [r0, r2]
    7844:      	add	r0, r2
    7846:      	ldr	r0, [r0, #0x4]
    7848:      	str	r0, [r1, #0x24]
    784a:      	str	r3, [r1, #0x20]
    784c:      	ldr	r0, [r4, #0x4]
    784e:      	adds	r0, #0x8
    7850:      	bhs	0x789e <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x13e> @ imm = #0x4a
    7852:      	adds	r1, #0x28
    7854:      	str	r0, [r4, #0x4]
    7856:      	mov	r0, r4
    7858:      	blx	0xca50                  @ imm = #0x51f4
    785c:      	cbnz	r0, 0x7882 <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x122> @ imm = #0x22
    785e:      	add.w	r1, r6, #0x30
    7862:      	mov	r0, r4
    7864:      	blx	0xca50                  @ imm = #0x51e8
    7868:      	cbnz	r0, 0x7882 <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x122> @ imm = #0x16
    786a:      	add.w	r1, r6, #0x38
    786e:      	mov	r0, r4
    7870:      	blx	0xca50                  @ imm = #0x51dc
    7874:      	cbnz	r0, 0x7882 <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x122> @ imm = #0xa
    7876:      	add.w	r1, r6, #0x40
    787a:      	mov	r0, r4
    787c:      	blx	0xca50                  @ imm = #0x51d0
    7880:      	cbz	r0, 0x7886 <_ZN7android8gralloc417decodePlaneLayoutEPNS0_12InputHidlVecEPN4aidl7android8hardware8graphics6common11PlaneLayoutE+0x126> @ imm = #0x2
    7882:      	add	sp, #0x4
    7884:      	pop	{r4, r5, r6, r7, pc}
    7886:      	add.w	r1, r6, #0x48
    788a:      	mov	r0, r4
    788c:      	add	sp, #0x4
    788e:      	pop.w	{r4, r5, r6, r7, lr}
    7892:      	b.w	0xc928 <_ZN7android8gralloc414encodeMetadataINSt3__16vectorIhNS2_9allocatorIhEEEEEEiRKNS_8hardware8graphics6mapper4V4_07IMapper12MetadataTypeERKT_PNS7_8hidl_vecIhEEPFiSH_PNS0_13OutputHidlVecEE+0x1064> @ imm = #0x5092
    7896:      	blx	0xc830 <_ZN7android8gralloc414encodeMetadataINSt3__16vectorIhNS2_9allocatorIhEEEEEEiRKNS_8hardware8graphics6mapper4V4_07IMapper12MetadataTypeERKT_PNS7_8hidl_vecIhEEPFiSH_PNS0_13OutputHidlVecEE+0xf6c> @ imm = #0x4f98
    789a:      	blx	0xc830 <_ZN7android8gralloc414encodeMetadataINSt3__16vectorIhNS2_9allocatorIhEEEEEEiRKNS_8hardware8graphics6mapper4V4_07IMapper12MetadataTypeERKT_PNS7_8hidl_vecIhEEPFiSH_PNS0_13OutputHidlVecEE+0xf6c> @ imm = #0x4f94
    789e:      	blx	0xc830 <_ZN7android8gralloc414encodeMetadataINSt3__16vectorIhNS2_9allocatorIhEEEEEEiRKNS_8hardware8graphics6mapper4V4_07IMapper12MetadataTypeERKT_PNS7_8hidl_vecIhEEPFiSH_PNS0_13OutputHidlVecEE+0xf6c> @ imm = #0x4f90
