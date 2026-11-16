  12f1cc:      	paciasp
  12f1d0:      	stp	x29, x30, [sp, #-0x30]!
  12f1d4:      	stp	x22, x21, [sp, #0x10]
  12f1d8:      	stp	x20, x19, [sp, #0x20]
  12f1dc:      	mov	x29, sp
  12f1e0:      	stp	xzr, xzr, [x0]
  12f1e4:      	str	xzr, [x0, #0x10]
  12f1e8:      	ldp	x19, x8, [x1]
  12f1ec:      	subs	x20, x8, x19
  12f1f0:      	b.ne	0x12f208 <_ZNK7android3gui17IBLASTBufferQueue22getInterfaceDescriptorEv+0xfc>
  12f1f4:      	ldp	x20, x19, [sp, #0x20]
  12f1f8:      	ldp	x22, x21, [sp, #0x10]
  12f1fc:      	ldp	x29, x30, [sp], #0x30
  12f200:      	autiasp
  12f204:      	ret
  12f208:      	tbnz	x20, #0x3f, 0x12f238 <_ZNK7android3gui17IBLASTBufferQueue22getInterfaceDescriptorEv+0x12c>
  12f20c:      	mov	x21, x0
  12f210:      	mov	x0, x20
  12f214:      	bl	0x1e5590 <_Znwm@plt>
  12f218:      	add	x22, x0, x20
  12f21c:      	mov	x1, x19
  12f220:      	mov	x2, x20
  12f224:      	stp	x0, x0, [x21]
  12f228:      	str	x22, [x21, #0x10]
  12f22c:      	bl	0x1eb0b0 <memmove@plt>
  12f230:      	str	x22, [x21, #0x8]
  12f234:      	b	0x12f1f4 <_ZNK7android3gui17IBLASTBufferQueue22getInterfaceDescriptorEv+0xe8>
  12f238:      	bl	0xbd404 <_ZN7android3guilsERNSt3__113basic_ostreamIcNS1_11char_traitsIcEEEERKNS0_10WindowInfoE+0x858>
