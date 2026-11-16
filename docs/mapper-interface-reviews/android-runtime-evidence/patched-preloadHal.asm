
retained-evidence/provider-callers-43776923589/legacy_graphics/patched/system/lib64/libui.so:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000061588 <_ZN7android19GraphicBufferMapper10preloadHalEv>:
   61588:      	paciasp
   6158c:      	stp	x29, x30, [sp, #-0x10]!
   61590:      	mov	x29, sp
   61594:      	bl	0x69048 <android_get_device_api_level@plt>
   61598:      	cmp	w0, #0x23
   6159c:      	nop
   615a0:      	bl	0x48434 <_ZN7android14Gralloc2Mapper7preloadEv+0x8>
   615a4:      	bl	0x49c24 <_ZN7android14Gralloc3Mapper7preloadEv+0x8>
   615a8:      	ldp	x29, x30, [sp], #0x10
   615ac:      	autiasp
   615b0:      	b	0x4bd9c <_ZN7android14Gralloc4Mapper7preloadEv+0x8>
