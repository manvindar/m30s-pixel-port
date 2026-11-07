#!/usr/bin/env python3
"""patch_netbpfload.py IN OUT [MESSAGE_PREFIX ...]: make Android's mainline netbpfload (tethering apex, aarch64) run on kernel 4.14.
The loader refuses old kernels with fatal messages ("Android V requires kernel 4.19.", "Android 25Q2 requires kernel 5.4.", "Android 26Q3 requires kernel 5.15.", "Android V+ only supports LTS kernels.",
"Android V+ requires %d.%d kernel to be %d.%d.%d+."). Each message is printed after `cmp ; b.cc skip ; ldrb ; cbz/tbz skip ; adrp x1,tag ; add ; adrp x2,msg ; add x2,...`.
This finds every reference to those strings (adrp+add, no per-build offsets) and turns the nearest conditional branch before the message that skips it into an unconditional branch.
Program selection by kernel version stays on the real uname (4.14), so only the programs that suit 4.14 are loaded (docs/oneui9/M2-GAPS.md, tools/oneui/bpf_needs.py)."""
import struct, sys
MSGS = [b'Android U requires kernel', b'Android V requires kernel', b'Android 25Q2 requires kernel', b'Android 26Q3 requires kernel', b'Android V+ only supports LTS', b'Android V+ requires %d.%d kernel to be']
if len(sys.argv) > 3: MSGS = [m.encode() for m in sys.argv[3:]]      # e.g. libnetd_updatable.so: 'V+ platform with kernel version <' ...
d = bytearray(open(sys.argv[1], 'rb').read())
phoff, = struct.unpack_from('<Q', d, 0x20); phentsize, phnum = struct.unpack_from('<HH', d, 0x36)
loads = [(p[3], p[2], p[5]) for p in (struct.unpack_from('<IIQQQQQQ', d, phoff + i * phentsize) for i in range(phnum)) if p[0] == 1]   # (vaddr, offset, filesz) PT_LOAD
exec_seg = [(va, fo, sz) for (va, fo, sz), p in zip(loads, [struct.unpack_from('<IIQQQQQQ', d, phoff + i * phentsize) for i in range(phnum) if struct.unpack_from('<I', d, phoff + i * phentsize)[0] == 1]) if p[1] & 1]
def off2va(o): return next(va + (o - fo) for va, fo, sz in loads if fo <= o < fo + sz)
def sx(v, bits): return v - (1 << bits) if v >> (bits - 1) else v
def cond_target(w, a):
    """target of a conditional branch word at address a, or None"""
    if w & 0xff000010 == 0x54000000: return a + 4 * sx((w >> 5) & 0x7ffff, 19)          # b.cond
    if w & 0x7e000000 == 0x34000000: return a + 4 * sx((w >> 5) & 0x7ffff, 19)          # cbz / cbnz
    if w & 0x7e000000 == 0x36000000: return a + 4 * sx((w >> 5) & 0x3fff, 14)           # tbz / tbnz
    return None
code_va, code_off, code_sz = exec_seg[0]
words = struct.unpack_from('<%dI' % (code_sz // 4), d, code_off)
adrp = {}                                                                                  # string address -> [index of the adrp that builds it]
for k in range(len(words) - 1):
    w, n = words[k], words[k + 1]
    if w & 0x9f000000 == 0x90000000 and n & 0xffc00000 == 0x91000000 and (n >> 5) & 31 == w & 31 and n & 31 == w & 31:
        a = code_va + 4 * k; imm = (((w >> 29) & 3) | (((w >> 5) & 0x7ffff) << 2)); imm = sx(imm, 21)
        tgt = ((a & ~0xfff) + (imm << 12)) + ((n >> 10) & 0xfff); adrp.setdefault(tgt, []).append(k)
done = 0
for m in MSGS:
    pos = 0
    while (i := bytes(d).find(m, pos)) >= 0:
        pos = i + 1; sva = off2va(i)
        for k in adrp.get(sva, []):
            # block start: the `adrp x1 (tag)` two instructions before the message's adrp; search back for the guard branch
            for j in range(k - 1, k - 16, -1):
                a = code_va + 4 * j; t = cond_target(words[j], a)
                if t is not None and t > code_va + 4 * (k + 2):
                    struct.pack_into('<I', d, code_off + 4 * j, 0x14000000 | (((t - a) >> 2) & 0x3ffffff))
                    print(f'  {m.decode()}: {a:#x} {words[j]:#010x} -> b {t:#x}'); done += 1; break
            else: sys.exit(f'no guard branch found before {m!r} at {code_va + 4 * k:#x}')
assert done >= 4, f'only {done} gates patched: not a netbpfload this tool knows'
open(sys.argv[2], 'wb').write(d); print('patched', done, 'gates ->', sys.argv[2])
