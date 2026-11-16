
retained-evidence/provider-callers-43776923589/legacy_graphics/patched/system/lib64/libui.so:	file format elf64-littleaarch64

Disassembly of section .text:

00000000000357a4 <_ZN7android19GraphicBufferMapperC2Ev>:
   357a4:      	paciasp
   357a8:      	stp	x29, x30, [sp, #-0x30]!
   357ac:      	str	x21, [sp, #0x10]
   357b0:      	stp	x20, x19, [sp, #0x20]
   357b4:      	mov	x29, sp
   357b8:      	mov	x19, x0
   357bc:      	str	xzr, [x0]
   357c0:      	mov	w0, #0x10
   357c4:      	bl	0x67a88 <_Znwm@plt>
   357c8:      	adrp	x8, 0x6d000 <_ZTVN7android14Gralloc5MapperE+0xe0>
   357cc:      	mov	x20, x0
   357d0:      	ldr	x8, [x8, #0x8e0]
   357d4:      	add	x21, x8, #0x10
   357d8:      	str	x21, [x0]
   357dc:      	bl	0x35a0c <_ZN7android17Gralloc5AllocatorC2ERKNS_14Gralloc5MapperE+0xd0>
   357e0:      	adrp	x8, 0x70000
   357e4:      	ldr	x9, [x8, #0x990]
   357e8:      	ldr	x8, [x19]
   357ec:      	str	x20, [x19]
   357f0:      	str	x9, [x20, #0x8]
   357f4:      	cbnz	x8, 0x35824 <_ZN7android19GraphicBufferMapperC2Ev+0x80>
   357f8:      	ldr	x8, [x21, #0x10]
   357fc:      	mov	x0, x20
   35800:      	blr	x8
   35804:      	tbz	w0, #0x0, 0x35840 <_ZN7android19GraphicBufferMapperC2Ev+0x9c>
   35808:      	mov	w8, #0x5
   3580c:      	str	w8, [x19, #0x8]
   35810:      	ldp	x20, x19, [sp, #0x20]
   35814:      	ldr	x21, [sp, #0x10]
   35818:      	ldp	x29, x30, [sp], #0x30
   3581c:      	autiasp
   35820:      	ret
   35824:      	ldr	x9, [x8]
   35828:      	mov	x0, x8
   3582c:      	ldr	x9, [x9, #0x8]
   35830:      	blr	x9
   35834:      	ldr	x20, [x19]
   35838:      	ldr	x21, [x20]
   3583c:      	b	0x357f8 <_ZN7android19GraphicBufferMapperC2Ev+0x54>
   35840:      	mov	w0, #0x10
   35844:      	bl	0x67a88 <_Znwm@plt>
   35848:      	mov	x20, x0
   3584c:      	bl	0x683d0 <_ZN7android14Gralloc4MapperC1Ev@plt>
   35850:      	ldr	x0, [x19]
   35854:      	str	x20, [x19]
   35858:      	cbz	x0, 0x3586c <_ZN7android19GraphicBufferMapperC2Ev+0xc8>
   3585c:      	ldr	x8, [x0]
   35860:      	ldr	x8, [x8, #0x8]
   35864:      	blr	x8
   35868:      	ldr	x20, [x19]
   3586c:      	ldr	x8, [x20]
   35870:      	mov	x0, x20
   35874:      	ldr	x8, [x8, #0x10]
   35878:      	blr	x8
   3587c:      	tbz	w0, #0x0, 0x35888 <_ZN7android19GraphicBufferMapperC2Ev+0xe4>
   35880:      	mov	w8, #0x4
   35884:      	b	0x3580c <_ZN7android19GraphicBufferMapperC2Ev+0x68>
   35888:      	bl	0x69048 <android_get_device_api_level@plt>
   3588c:      	cmp	w0, #0x23
   35890:      	nop
   35894:      	mov	w0, #0x10
   35898:      	bl	0x67a88 <_Znwm@plt>
   3589c:      	mov	x20, x0
   358a0:      	bl	0x68328 <_ZN7android14Gralloc3MapperC1Ev@plt>
   358a4:      	ldr	x0, [x19]
   358a8:      	str	x20, [x19]
   358ac:      	cbz	x0, 0x358c0 <_ZN7android19GraphicBufferMapperC2Ev+0x11c>
   358b0:      	ldr	x8, [x0]
   358b4:      	ldr	x8, [x8, #0x8]
   358b8:      	blr	x8
   358bc:      	ldr	x20, [x19]
   358c0:      	ldr	x8, [x20]
   358c4:      	mov	x0, x20
   358c8:      	ldr	x8, [x8, #0x10]
   358cc:      	blr	x8
   358d0:      	tbz	w0, #0x0, 0x358dc <_ZN7android19GraphicBufferMapperC2Ev+0x138>
   358d4:      	mov	w8, #0x3
   358d8:      	b	0x3580c <_ZN7android19GraphicBufferMapperC2Ev+0x68>
   358dc:      	mov	w0, #0x18
   358e0:      	bl	0x67a88 <_Znwm@plt>
   358e4:      	mov	x20, x0
   358e8:      	bl	0x680a0 <_ZN7android14Gralloc2MapperC1Ev@plt>
   358ec:      	ldr	x0, [x19]
   358f0:      	str	x20, [x19]
   358f4:      	cbz	x0, 0x35908 <_ZN7android19GraphicBufferMapperC2Ev+0x164>
   358f8:      	ldr	x8, [x0]
   358fc:      	ldr	x8, [x8, #0x8]
   35900:      	blr	x8
   35904:      	ldr	x20, [x19]
   35908:      	ldr	x8, [x20]
   3590c:      	mov	x0, x20
   35910:      	ldr	x8, [x8, #0x10]
   35914:      	blr	x8
   35918:      	tbz	w0, #0x0, 0x35924 <_ZN7android19GraphicBufferMapperC2Ev+0x180>
   3591c:      	mov	w8, #0x2
   35920:      	b	0x3580c <_ZN7android19GraphicBufferMapperC2Ev+0x68>
   35924:      	nop
   35928:      	adr	x1, #-0x1ec46
   3592c:      	adrp	x2, 0x14000
   35930:      	add	x2, x2, #0xe42
   35934:      	mov	x0, xzr
   35938:      	bl	0x680e8 <__android_log_assert@plt>
