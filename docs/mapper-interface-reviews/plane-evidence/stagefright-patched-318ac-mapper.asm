
/Users/manvindar.singh/HarnessAgents/hive/agents/pam-mw9kdvck/artifacts/android17-actions-20261115/provider-callers-43776923589/legacy_graphics/patched/system/lib64/libui.so:	file format elf64-littleaarch64

Disassembly of section .text:

00000000000318ac <_ZN7android19GraphicBufferMapper6unlockEPK13native_handlePNS_4base14unique_fd_implINS4_13DefaultCloserEEE>:
   318ac:      	paciasp
   318b0:      	sub	sp, sp, #0x50
   318b4:      	stp	x29, x30, [sp, #0x20]
   318b8:      	stp	x22, x21, [sp, #0x30]
   318bc:      	stp	x20, x19, [sp, #0x40]
   318c0:      	add	x29, sp, #0x20
   318c4:      	mrs	x22, TPIDR_EL0
   318c8:      	mov	x19, x2
   318cc:      	mov	x20, x1
   318d0:      	ldr	x8, [x22, #0x28]
   318d4:      	mov	x21, x0
   318d8:      	stur	x8, [x29, #-0x8]
   318dc:      	bl	0x67e48 <atrace_get_enabled_tags@plt>
   318e0:      	tbz	w0, #0x1, 0x318f0 <_ZN7android19GraphicBufferMapper6unlockEPK13native_handlePNS_4base14unique_fd_implINS4_13DefaultCloserEEE+0x44>
   318e4:      	adrp	x0, 0x15000
   318e8:      	add	x0, x0, #0x561
   318ec:      	bl	0x67e30 <atrace_begin_body@plt>
   318f0:      	ldr	x0, [x21]
   318f4:      	mov	x1, x20
   318f8:      	ldr	x8, [x0]
   318fc:      	ldr	x8, [x8, #0x50]
   31900:      	blr	x8
   31904:      	mov	w20, w0
   31908:      	cbz	x19, 0x31994 <_ZN7android19GraphicBufferMapper6unlockEPK13native_handlePNS_4base14unique_fd_implINS4_13DefaultCloserEEE+0xe8>
   3190c:      	bl	0x67da0 <__errno@plt>
   31910:      	ldr	w21, [x0]
   31914:      	cmn	w20, #0x1
   31918:      	mov	w10, #-0x1
   3191c:      	mov	w8, #-0x1
   31920:      	stur	w20, [x29, #-0xc]
   31924:      	b.ne	0x319ac <_ZN7android19GraphicBufferMapper6unlockEPK13native_handlePNS_4base14unique_fd_implINS4_13DefaultCloserEEE+0x100>
   31928:      	str	w21, [x0]
   3192c:      	ldr	w9, [x19]
   31930:      	stur	w10, [x29, #-0xc]
   31934:      	cmn	w9, #0x1
   31938:      	b.ne	0x319d0 <_ZN7android19GraphicBufferMapper6unlockEPK13native_handlePNS_4base14unique_fd_implINS4_13DefaultCloserEEE+0x124>
   3193c:      	cmn	w8, #0x1
   31940:      	str	w8, [x19]
   31944:      	b.ne	0x319f4 <_ZN7android19GraphicBufferMapper6unlockEPK13native_handlePNS_4base14unique_fd_implINS4_13DefaultCloserEEE+0x148>
   31948:      	str	w21, [x0]
   3194c:      	ldur	w8, [x29, #-0xc]
   31950:      	cmn	w8, #0x1
   31954:      	b.ne	0x31a10 <_ZN7android19GraphicBufferMapper6unlockEPK13native_handlePNS_4base14unique_fd_implINS4_13DefaultCloserEEE+0x164>
   31958:      	str	w21, [x0]
   3195c:      	bl	0x67e48 <atrace_get_enabled_tags@plt>
   31960:      	tbz	w0, #0x1, 0x31968 <_ZN7android19GraphicBufferMapper6unlockEPK13native_handlePNS_4base14unique_fd_implINS4_13DefaultCloserEEE+0xbc>
   31964:      	bl	0x67e60 <atrace_end_body@plt>
   31968:      	ldr	x8, [x22, #0x28]
   3196c:      	ldur	x9, [x29, #-0x8]
   31970:      	cmp	x8, x9
   31974:      	b.ne	0x319f0 <_ZN7android19GraphicBufferMapper6unlockEPK13native_handlePNS_4base14unique_fd_implINS4_13DefaultCloserEEE+0x144>
   31978:      	mov	w0, wzr
   3197c:      	ldp	x20, x19, [sp, #0x40]
   31980:      	ldp	x22, x21, [sp, #0x30]
   31984:      	ldp	x29, x30, [sp, #0x20]
   31988:      	add	sp, sp, #0x50
   3198c:      	autiasp
   31990:      	ret
   31994:      	mov	w0, w20
   31998:      	mov	w1, #-0x1
   3199c:      	bl	0x67d88 <sync_wait@plt>
   319a0:      	mov	w0, w20
   319a4:      	bl	0x67ed8 <close@plt>
   319a8:      	b	0x3195c <_ZN7android19GraphicBufferMapper6unlockEPK13native_handlePNS_4base14unique_fd_implINS4_13DefaultCloserEEE+0xb0>
   319ac:      	sub	x2, x29, #0xc
   319b0:      	str	x0, [sp, #0x8]
   319b4:      	mov	w0, w20
   319b8:      	mov	x1, xzr
   319bc:      	bl	0x61cf4 <_ZN7android19GraphicBufferMapper15getSmpte2094_50EPK13native_handlePNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x14>
   319c0:      	ldr	x0, [sp, #0x8]
   319c4:      	ldur	w8, [x29, #-0xc]
   319c8:      	mov	w10, #-0x1
   319cc:      	b	0x31928 <_ZN7android19GraphicBufferMapper6unlockEPK13native_handlePNS_4base14unique_fd_implINS4_13DefaultCloserEEE+0x7c>
   319d0:      	str	x0, [sp, #0x8]
   319d4:      	mov	w0, w9
   319d8:      	mov	x1, x19
   319dc:      	mov	w20, w8
   319e0:      	bl	0x47294 <_ZNK7android5Fence7flattenERPvRmRPiS3_+0x15c>
   319e4:      	ldr	x0, [sp, #0x8]
   319e8:      	mov	w8, w20
   319ec:      	b	0x3193c <_ZN7android19GraphicBufferMapper6unlockEPK13native_handlePNS_4base14unique_fd_implINS4_13DefaultCloserEEE+0x90>
   319f0:      	bl	0x69468 <__stack_chk_fail@plt>
   319f4:      	sub	x1, x29, #0xc
   319f8:      	mov	x20, x0
   319fc:      	mov	w0, w8
   31a00:      	mov	x2, x19
   31a04:      	bl	0x61cf4 <_ZN7android19GraphicBufferMapper15getSmpte2094_50EPK13native_handlePNSt3__18optionalINS4_6vectorIhNS4_9allocatorIhEEEEEE+0x14>
   31a08:      	mov	x0, x20
   31a0c:      	b	0x31948 <_ZN7android19GraphicBufferMapper6unlockEPK13native_handlePNS_4base14unique_fd_implINS4_13DefaultCloserEEE+0x9c>
   31a10:      	sub	x1, x29, #0xc
   31a14:      	mov	x19, x0
   31a18:      	mov	w0, w8
   31a1c:      	bl	0x47294 <_ZNK7android5Fence7flattenERPvRmRPiS3_+0x15c>
   31a20:      	mov	x0, x19
   31a24:      	b	0x31958 <_ZN7android19GraphicBufferMapper6unlockEPK13native_handlePNS_4base14unique_fd_implINS4_13DefaultCloserEEE+0xac>
