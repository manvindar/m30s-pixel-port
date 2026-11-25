"""Runnable check for verify_baked_oat.py with synthetic vdex/odex/APK files: python3 tools/img/test_verify_baked_oat.py"""
import hashlib, io, json, os, struct, sys, tempfile, unittest, zipfile, zlib
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import verify_baked_oat as v

APK = '/system/system_ext/priv-app/Foo/Foo.apk'
BOOT = [0x1000, 0x2002, 0x3004]                       # dex CRCs of the image's boot image, as the oat file records them


def apk(dex):
    b = io.BytesIO()
    with zipfile.ZipFile(b, 'w') as z: z.writestr('classes.dex', dex); z.writestr('AndroidManifest.xml', b'x')
    return b.getvalue()


def vdex(sums):                                        # header + 4 section headers (kind, offset, size); kind 0 = checksums right after them
    return b'vdex027\0' + struct.pack('<I', 4) + struct.pack('<3I', 0, 12 + 48, 4 * len(sums)) + b'\0' * 36 + struct.pack('<%dI' % len(sums), *sums)


def odex(bcp):
    kv = b'compiler-filter\0speed\0bootclasspath-checksums\0' + ':'.join('d/%x' % c for c in bcp).encode() + b'\0'
    hdr = b'oat\n291\0' + b'\0' * (v.KVS_SIZE_OFF - 8) + struct.pack('<I', len(kv))
    return b'\x7fELF' + b'\0' * 4092 + hdr + kv


class Verify(unittest.TestCase):
    def setUp(self):
        self.t = tempfile.TemporaryDirectory(); self.seed = self.t.name; self.dex = b'dex\n035\0' + b'A' * 64
        self.image = {APK: apk(self.dex), '/system/framework/boot.vdex': vdex([BOOT[0] ^ 1]), '/system/framework/boot-ext.vdex': vdex([BOOT[1] ^ 1, BOOT[2] ^ 1])}
        self.write(vdex([zlib.crc32(self.dex)]), odex(BOOT))

    def tearDown(self): self.t.cleanup()

    def write(self, vd, od):
        d = os.path.join(self.seed, APK.lstrip('/').rsplit('/', 1)[0], 'oat', 'arm64'); os.makedirs(d, exist_ok=True)
        open(os.path.join(d, 'Foo.vdex'), 'wb').write(vd); open(os.path.join(d, 'Foo.odex'), 'wb').write(od)
        json.dump({'apps': [{'apk': APK, 'sha256': {'odex': hashlib.sha256(od).hexdigest(), 'vdex': hashlib.sha256(vd).hexdigest()}}]}, open(os.path.join(self.seed, 'manifest.json'), 'w'))

    def run_verify(self): return v.verify(self.seed, self.image.__getitem__, [p for p in self.image if p.endswith('.vdex')])

    def test_matching_seed_passes(self): self.assertEqual(self.run_verify(), [])

    def test_dex_container_repeats_crc(self):
        self.write(vdex([zlib.crc32(self.dex)] * 3), odex(BOOT)); self.assertEqual(self.run_verify(), [])

    def test_altered_apk_fails(self):
        self.image[APK] = apk(self.dex + b'B')
        self.assertIn('another APK', self.run_verify()[0])

    def test_other_boot_image_fails(self):
        self.image['/system/framework/boot-ext.vdex'] = vdex([(BOOT[1] + 2) ^ 1, BOOT[2] ^ 1])
        self.assertIn('another boot image', self.run_verify()[0])

    def test_damaged_file_fails(self):
        p = os.path.join(self.seed, APK.lstrip('/').rsplit('/', 1)[0], 'oat', 'arm64', 'Foo.odex'); b = bytearray(open(p, 'rb').read()); b[100] ^= 1; open(p, 'wb').write(b)
        self.assertIn('manifest sha256', self.run_verify()[0])

    def test_missing_file_fails(self):
        os.remove(os.path.join(self.seed, APK.lstrip('/').rsplit('/', 1)[0], 'oat', 'arm64', 'Foo.vdex'))
        self.assertIn('missing', self.run_verify()[0])


if __name__ == '__main__': unittest.main()
