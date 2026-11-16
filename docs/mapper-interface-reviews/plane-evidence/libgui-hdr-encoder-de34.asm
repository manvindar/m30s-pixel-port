
retained-evidence/provider-callers-43776923589/legacy_graphics/abi-consumers/e317b632b2f49abadc7d17c4f7bf6730936b709a7ad6ec04e71d21a5d2eb1881.elf:	file format elf64-littleaarch64

Disassembly of section .text:

000000000000de34 <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE>:
    de34:      	paciasp
    de38:      	sub	sp, sp, #0x70
    de3c:      	stp	x29, x30, [sp, #0x30]
    de40:      	str	x23, [sp, #0x40]
    de44:      	stp	x22, x21, [sp, #0x50]
    de48:      	stp	x20, x19, [sp, #0x60]
    de4c:      	add	x29, sp, #0x30
    de50:      	mrs	x22, TPIDR_EL0
    de54:      	ldr	x8, [x22, #0x28]
    de58:      	stur	x8, [x29, #-0x8]
    de5c:      	ldrb	w8, [x0, #0x28]
    de60:      	cbz	w8, 0xdf08 <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE+0xd4>
    de64:      	mov	x19, x0
    de68:      	stp	x1, xzr, [sp, #0x8]
    de6c:      	nop
    de70:      	adr	x0, #0xa3f8
    de74:      	add	x1, sp, #0x8
    de78:      	stp	xzr, xzr, [sp, #0x18]
    de7c:      	bl	0x11b50 <_ZN7android8gralloc418encodeMetadataTypeERKNS_8hardware8graphics6mapper4V4_07IMapper12MetadataTypeEPNS0_13OutputHidlVecE@plt>
    de80:      	cbnz	w0, 0xdf0c <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE+0xd8>
    de84:      	add	x1, sp, #0x8
    de88:      	mov	x0, x19
    de8c:      	bl	0x11c58 <_ZN7android8gralloc421encodeSmpte2086HelperERKN4aidl7android8hardware8graphics6common9Smpte2086EPNS0_13OutputHidlVecE@plt>
    de90:      	cbnz	w0, 0xdf0c <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE+0xd8>
    de94:      	ldr	x23, [sp, #0x8]
    de98:      	cbz	x23, 0xdf38 <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE+0x104>
    de9c:      	ldr	x20, [sp, #0x10]
    dea0:      	lsr	x8, x20, #32
    dea4:      	cbz	x8, 0xdeb4 <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE+0x80>
    dea8:      	adrp	x0, 0x5000
    deac:      	add	x0, x0, #0x46d
    deb0:      	bl	0x11d78 <_ZN7android8hardware7details14logAlwaysFatalEPKc@plt>
    deb4:      	mov	x0, x20
    deb8:      	bl	0x11d90 <_Znam@plt>
    debc:      	mov	w1, wzr
    dec0:      	mov	x2, x20
    dec4:      	mov	x21, x0
    dec8:      	bl	0x11fd0 <memset@plt>
    decc:      	ldr	w8, [x23, #0x8]
    ded0:      	cmp	w8, w20
    ded4:      	csel	w8, w8, w20, lo
    ded8:      	cbz	w8, 0xdfc0 <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE+0x18c>
    dedc:      	ldr	x9, [x23]
    dee0:      	cmp	w8, #0x8
    dee4:      	mov	x10, xzr
    dee8:      	b.lo	0xdfa4 <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE+0x170>
    deec:      	sub	x11, x21, x9
    def0:      	cmp	x11, #0x20
    def4:      	b.lo	0xdfa4 <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE+0x170>
    def8:      	cmp	w8, #0x20
    defc:      	b.hs	0xdf40 <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE+0x10c>
    df00:      	mov	x10, xzr
    df04:      	b	0xdf78 <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE+0x144>
    df08:      	mov	w0, wzr
    df0c:      	ldr	x8, [x22, #0x28]
    df10:      	ldur	x9, [x29, #-0x8]
    df14:      	cmp	x8, x9
    df18:      	b.ne	0xe00c <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE+0x1d8>
    df1c:      	ldp	x20, x19, [sp, #0x60]
    df20:      	ldr	x23, [sp, #0x40]
    df24:      	ldp	x22, x21, [sp, #0x50]
    df28:      	ldp	x29, x30, [sp, #0x30]
    df2c:      	add	sp, sp, #0x70
    df30:      	autiasp
    df34:      	ret
    df38:      	mov	w0, #-0x16
    df3c:      	b	0xdf0c <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE+0xd8>
    df40:      	and	x11, x8, #0x18
    df44:      	and	x10, x8, #0xffffffe0
    df48:      	add	x12, x21, #0x10
    df4c:      	add	x13, x9, #0x10
    df50:      	and	x14, x8, #0xffffffe0
    df54:      	ldp	q0, q1, [x13, #-0x10]
    df58:      	subs	x14, x14, #0x20
    df5c:      	add	x13, x13, #0x20
    df60:      	stp	q0, q1, [x12, #-0x10]
    df64:      	add	x12, x12, #0x20
    df68:      	b.ne	0xdf54 <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE+0x120>
    df6c:      	cmp	x10, x8
    df70:      	b.eq	0xdfc0 <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE+0x18c>
    df74:      	cbz	x11, 0xdfa4 <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE+0x170>
    df78:      	mov	x13, x10
    df7c:      	and	x10, x8, #0xfffffff8
    df80:      	sub	x11, x13, x10
    df84:      	add	x12, x21, x13
    df88:      	add	x13, x9, x13
    df8c:      	ldr	d0, [x13], #0x8
    df90:      	adds	x11, x11, #0x8
    df94:      	str	d0, [x12], #0x8
    df98:      	b.ne	0xdf8c <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE+0x158>
    df9c:      	cmp	x10, x8
    dfa0:      	b.eq	0xdfc0 <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE+0x18c>
    dfa4:      	sub	x8, x8, x10
    dfa8:      	add	x11, x21, x10
    dfac:      	add	x9, x9, x10
    dfb0:      	ldrb	w10, [x9], #0x1
    dfb4:      	subs	x8, x8, #0x1
    dfb8:      	strb	w10, [x11], #0x1
    dfbc:      	b.ne	0xdfb0 <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE+0x17c>
    dfc0:      	ldrb	w8, [x23, #0xc]
    dfc4:      	tbz	w8, #0x0, 0xdfd4 <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE+0x1a0>
    dfc8:      	ldr	x0, [x23]
    dfcc:      	cbz	x0, 0xdfd4 <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE+0x1a0>
    dfd0:      	bl	0x11da8 <_ZdaPv@plt>
    dfd4:      	mov	w8, #0x1
    dfd8:      	nop
    dfdc:      	adr	x0, #0xa28c
    dfe0:      	add	x1, sp, #0x8
    dfe4:      	str	x21, [x23]
    dfe8:      	str	w20, [x23, #0x8]
    dfec:      	strb	w8, [x23, #0xc]
    dff0:      	str	x8, [sp, #0x18]
    dff4:      	bl	0x11b50 <_ZN7android8gralloc418encodeMetadataTypeERKNS_8hardware8graphics6mapper4V4_07IMapper12MetadataTypeEPNS0_13OutputHidlVecE@plt>
    dff8:      	cbnz	w0, 0xdf0c <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE+0xd8>
    dffc:      	add	x1, sp, #0x8
    e000:      	mov	x0, x19
    e004:      	bl	0x11c58 <_ZN7android8gralloc421encodeSmpte2086HelperERKN4aidl7android8hardware8graphics6common9Smpte2086EPNS0_13OutputHidlVecE@plt>
    e008:      	b	0xdf0c <_ZN7android8gralloc415encodeSmpte2086ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common9Smpte2086EEEPNS_8hardware8hidl_vecIhEE+0xd8>
    e00c:      	bl	0x11fb8 <__stack_chk_fail@plt>
