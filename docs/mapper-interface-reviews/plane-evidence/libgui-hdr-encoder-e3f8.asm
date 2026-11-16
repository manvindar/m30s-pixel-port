
retained-evidence/provider-callers-43776923589/legacy_graphics/abi-consumers/e317b632b2f49abadc7d17c4f7bf6730936b709a7ad6ec04e71d21a5d2eb1881.elf:	file format elf64-littleaarch64

Disassembly of section .text:

000000000000e3f8 <_ZN7android8gralloc418encodeSmpte2094_40ERKNSt3__18optionalINS1_6vectorIhNS1_9allocatorIhEEEEEEPNS_8hardware8hidl_vecIhEE>:
    e3f8:      	bti	c
    e3fc:      	ldrb	w9, [x0, #0x18]
    e400:      	cbz	w9, 0xe41c <_ZN7android8gralloc418encodeSmpte2094_40ERKNSt3__18optionalINS1_6vectorIhNS1_9allocatorIhEEEEEEPNS_8hardware8hidl_vecIhEE+0x24>
    e404:      	mov	x8, x0
    e408:      	mov	x2, x1
    e40c:      	nop
    e410:      	adr	x0, #0x9e88
    e414:      	mov	x1, x8
    e418:      	b	0x10ec4 <_ZN7android8gralloc431getPlaneLayoutComponentTypeNameERKN4aidl7android8hardware8graphics6common14ExtendableTypeE+0xbec>
    e41c:      	mov	w0, wzr
    e420:      	ret
