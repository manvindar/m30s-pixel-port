
retained-evidence/provider-callers-43776923589/legacy_graphics/patched/system/lib64/libui.so:	file format elf64-littleaarch64

Disassembly of section .text:

00000000000311dc <_ZN7android13FenceTimeline4pushERKNSt3__110shared_ptrINS_9FenceTimeEEE>:
   31380:      	ldr	x8, [x0]
   31384:      	ldr	x9, [x8]
   31388:      	cbz	x9, 0x313ac <_ZN7android13FenceTimeline4pushERKNSt3__110shared_ptrINS_9FenceTimeEEE+0x1d0>
   3138c:      	str	x9, [x8, #0x8]
   31390:      	ldr	x8, [x0]
   31394:      	ldr	x0, [x8]
   31398:      	ldr	x8, [x8, #0x18]
   3139c:      	cmp	x0, x8
   313a0:      	b.eq	0x313a8 <_ZN7android13FenceTimeline4pushERKNSt3__110shared_ptrINS_9FenceTimeEEE+0x1cc>
   313a4:      	b	0x67c80 <free@plt>
   313a8:      	strb	wzr, [x8, #0x80]
   313ac:      	ret
