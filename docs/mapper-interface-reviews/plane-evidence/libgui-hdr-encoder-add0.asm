
retained-evidence/provider-callers-43776923589/legacy_graphics/abi-consumers/e317b632b2f49abadc7d17c4f7bf6730936b709a7ad6ec04e71d21a5d2eb1881.elf:	file format elf64-littleaarch64

Disassembly of section .text:

000000000000add0 <_ZN7android8gralloc420encodeCta861_3HelperERKN4aidl7android8hardware8graphics6common8Cta861_3EPNS0_13OutputHidlVecE>:
    add0:      	paciasp
    add4:      	stp	x29, x30, [sp, #-0x20]!
    add8:      	stp	x20, x19, [sp, #0x10]
    addc:      	mov	x29, sp
    ade0:      	cbz	x1, 0xae1c <_ZN7android8gralloc420encodeCta861_3HelperERKN4aidl7android8hardware8graphics6common8Cta861_3EPNS0_13OutputHidlVecE+0x4c>
    ade4:      	mov	x20, x0
    ade8:      	mov	x19, x1
    adec:      	mov	x0, x1
    adf0:      	mov	x1, x20
    adf4:      	mov	w2, #0x4
    adf8:      	bl	0x8bc4 <_ZN7android8gralloc412encodeStringERKNSt3__112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEEPNS0_13OutputHidlVecE+0xd0>
    adfc:      	cbnz	w0, 0xae20 <_ZN7android8gralloc420encodeCta861_3HelperERKN4aidl7android8hardware8graphics6common8Cta861_3EPNS0_13OutputHidlVecE+0x50>
    ae00:      	add	x1, x20, #0x4
    ae04:      	mov	x0, x19
    ae08:      	mov	w2, #0x4
    ae0c:      	ldp	x20, x19, [sp, #0x10]
    ae10:      	ldp	x29, x30, [sp], #0x20
    ae14:      	autiasp
    ae18:      	b	0x8bc4 <_ZN7android8gralloc412encodeStringERKNSt3__112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEEPNS0_13OutputHidlVecE+0xd0>
    ae1c:      	mov	w0, #-0x16
    ae20:      	ldp	x20, x19, [sp, #0x10]
    ae24:      	ldp	x29, x30, [sp], #0x20
    ae28:      	autiasp
    ae2c:      	ret
