
retained-evidence/provider-callers-43776923589/legacy_graphics/abi-consumers/e317b632b2f49abadc7d17c4f7bf6730936b709a7ad6ec04e71d21a5d2eb1881.elf:	file format elf64-littleaarch64

Disassembly of section .text:

000000000000e0fc <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE>:
    e0fc:      	paciasp
    e100:      	sub	sp, sp, #0x70
    e104:      	stp	x29, x30, [sp, #0x30]
    e108:      	str	x23, [sp, #0x40]
    e10c:      	stp	x22, x21, [sp, #0x50]
    e110:      	stp	x20, x19, [sp, #0x60]
    e114:      	add	x29, sp, #0x30
    e118:      	mrs	x22, TPIDR_EL0
    e11c:      	ldr	x8, [x22, #0x28]
    e120:      	stur	x8, [x29, #-0x8]
    e124:      	ldrb	w8, [x0, #0x8]
    e128:      	cbz	w8, 0xe1e8 <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0xec>
    e12c:      	mov	x19, x0
    e130:      	stp	x1, xzr, [sp, #0x8]
    e134:      	nop
    e138:      	adr	x0, #0xa148
    e13c:      	add	x1, sp, #0x8
    e140:      	stp	xzr, xzr, [sp, #0x18]
    e144:      	bl	0x11b50 <_ZN7android8gralloc418encodeMetadataTypeERKNS_8hardware8graphics6mapper4V4_07IMapper12MetadataTypeEPNS0_13OutputHidlVecE@plt>
    e148:      	cbnz	w0, 0xe1ec <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0xf0>
    e14c:      	add	x0, sp, #0x8
    e150:      	mov	x1, x19
    e154:      	mov	w2, #0x4
    e158:      	bl	0x8bc4 <_ZN7android8gralloc412encodeStringERKNSt3__112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEEPNS0_13OutputHidlVecE+0xd0>
    e15c:      	cbnz	w0, 0xe1ec <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0xf0>
    e160:      	add	x0, sp, #0x8
    e164:      	add	x1, x19, #0x4
    e168:      	mov	w2, #0x4
    e16c:      	bl	0x8bc4 <_ZN7android8gralloc412encodeStringERKNSt3__112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEEPNS0_13OutputHidlVecE+0xd0>
    e170:      	cbnz	w0, 0xe1ec <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0xf0>
    e174:      	ldr	x23, [sp, #0x8]
    e178:      	cbz	x23, 0xe218 <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0x11c>
    e17c:      	ldr	x20, [sp, #0x10]
    e180:      	lsr	x8, x20, #32
    e184:      	cbz	x8, 0xe194 <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0x98>
    e188:      	adrp	x0, 0x5000
    e18c:      	add	x0, x0, #0x46d
    e190:      	bl	0x11d78 <_ZN7android8hardware7details14logAlwaysFatalEPKc@plt>
    e194:      	mov	x0, x20
    e198:      	bl	0x11d90 <_Znam@plt>
    e19c:      	mov	w1, wzr
    e1a0:      	mov	x2, x20
    e1a4:      	mov	x21, x0
    e1a8:      	bl	0x11fd0 <memset@plt>
    e1ac:      	ldr	w8, [x23, #0x8]
    e1b0:      	cmp	w8, w20
    e1b4:      	csel	w8, w8, w20, lo
    e1b8:      	cbz	w8, 0xe2a0 <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0x1a4>
    e1bc:      	ldr	x9, [x23]
    e1c0:      	cmp	w8, #0x8
    e1c4:      	mov	x10, xzr
    e1c8:      	b.lo	0xe284 <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0x188>
    e1cc:      	sub	x11, x21, x9
    e1d0:      	cmp	x11, #0x20
    e1d4:      	b.lo	0xe284 <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0x188>
    e1d8:      	cmp	w8, #0x20
    e1dc:      	b.hs	0xe220 <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0x124>
    e1e0:      	mov	x10, xzr
    e1e4:      	b	0xe258 <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0x15c>
    e1e8:      	mov	w0, wzr
    e1ec:      	ldr	x8, [x22, #0x28]
    e1f0:      	ldur	x9, [x29, #-0x8]
    e1f4:      	cmp	x8, x9
    e1f8:      	b.ne	0xe304 <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0x208>
    e1fc:      	ldp	x20, x19, [sp, #0x60]
    e200:      	ldr	x23, [sp, #0x40]
    e204:      	ldp	x22, x21, [sp, #0x50]
    e208:      	ldp	x29, x30, [sp, #0x30]
    e20c:      	add	sp, sp, #0x70
    e210:      	autiasp
    e214:      	ret
    e218:      	mov	w0, #-0x16
    e21c:      	b	0xe1ec <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0xf0>
    e220:      	and	x11, x8, #0x18
    e224:      	and	x10, x8, #0xffffffe0
    e228:      	add	x12, x21, #0x10
    e22c:      	add	x13, x9, #0x10
    e230:      	and	x14, x8, #0xffffffe0
    e234:      	ldp	q0, q1, [x13, #-0x10]
    e238:      	subs	x14, x14, #0x20
    e23c:      	add	x13, x13, #0x20
    e240:      	stp	q0, q1, [x12, #-0x10]
    e244:      	add	x12, x12, #0x20
    e248:      	b.ne	0xe234 <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0x138>
    e24c:      	cmp	x10, x8
    e250:      	b.eq	0xe2a0 <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0x1a4>
    e254:      	cbz	x11, 0xe284 <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0x188>
    e258:      	mov	x13, x10
    e25c:      	and	x10, x8, #0xfffffff8
    e260:      	sub	x11, x13, x10
    e264:      	add	x12, x21, x13
    e268:      	add	x13, x9, x13
    e26c:      	ldr	d0, [x13], #0x8
    e270:      	adds	x11, x11, #0x8
    e274:      	str	d0, [x12], #0x8
    e278:      	b.ne	0xe26c <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0x170>
    e27c:      	cmp	x10, x8
    e280:      	b.eq	0xe2a0 <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0x1a4>
    e284:      	sub	x8, x8, x10
    e288:      	add	x11, x21, x10
    e28c:      	add	x9, x9, x10
    e290:      	ldrb	w10, [x9], #0x1
    e294:      	subs	x8, x8, #0x1
    e298:      	strb	w10, [x11], #0x1
    e29c:      	b.ne	0xe290 <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0x194>
    e2a0:      	ldrb	w8, [x23, #0xc]
    e2a4:      	tbz	w8, #0x0, 0xe2b4 <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0x1b8>
    e2a8:      	ldr	x0, [x23]
    e2ac:      	cbz	x0, 0xe2b4 <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0x1b8>
    e2b0:      	bl	0x11da8 <_ZdaPv@plt>
    e2b4:      	mov	w8, #0x1
    e2b8:      	nop
    e2bc:      	adr	x0, #0x9fc4
    e2c0:      	add	x1, sp, #0x8
    e2c4:      	str	x21, [x23]
    e2c8:      	str	w20, [x23, #0x8]
    e2cc:      	strb	w8, [x23, #0xc]
    e2d0:      	str	x8, [sp, #0x18]
    e2d4:      	bl	0x11b50 <_ZN7android8gralloc418encodeMetadataTypeERKNS_8hardware8graphics6mapper4V4_07IMapper12MetadataTypeEPNS0_13OutputHidlVecE@plt>
    e2d8:      	cbnz	w0, 0xe1ec <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0xf0>
    e2dc:      	add	x0, sp, #0x8
    e2e0:      	mov	x1, x19
    e2e4:      	mov	w2, #0x4
    e2e8:      	bl	0x8bc4 <_ZN7android8gralloc412encodeStringERKNSt3__112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEEPNS0_13OutputHidlVecE+0xd0>
    e2ec:      	cbnz	w0, 0xe1ec <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0xf0>
    e2f0:      	add	x0, sp, #0x8
    e2f4:      	add	x1, x19, #0x4
    e2f8:      	mov	w2, #0x4
    e2fc:      	bl	0x8bc4 <_ZN7android8gralloc412encodeStringERKNSt3__112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEEPNS0_13OutputHidlVecE+0xd0>
    e300:      	b	0xe1ec <_ZN7android8gralloc414encodeCta861_3ERKNSt3__18optionalIN4aidl7android8hardware8graphics6common8Cta861_3EEEPNS_8hardware8hidl_vecIhEE+0xf0>
    e304:      	bl	0x11fb8 <__stack_chk_fail@plt>
