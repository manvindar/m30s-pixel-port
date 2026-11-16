"""Exercise shipped installer flow with host-only fake partitions and commands."""
import hashlib
import lzma
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
import zipfile


@unittest.skipUnless(shutil.which('xz') and shutil.which('unzip'), 'host xz/unzip required')
class RecoveryFlowTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(); self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name); self.bin = self.root / 'bin'; self.bin.mkdir()
        for name in ('system', 'boot', 'vendor'): (self.root / name).write_bytes(('old-' + name).encode())
        self.payload = b'exact-system-fixture' * 1024
        self.image_hash = hashlib.sha256(self.payload).hexdigest()
        self.zip = self.root / 'update.zip'; self.make_zip()
        script = Path(__file__).with_name('twrp-system-update.sh').read_text()
        for name in ('system', 'boot', 'vendor'): script = script.replace('/dev/block/by-name/' + name, str(self.root / name))
        script = script.replace('[ -b "$SYSTEM" ] && [ -b "$BOOT" ] && [ -b "$VENDOR" ]',
                                '[ -f "$SYSTEM" ] && [ -f "$BOOT" ] && [ -f "$VENDOR" ]')
        (self.root / 'mounts').write_text('')
        script = script.replace('/proc/mounts', str(self.root / 'mounts')).replace('/proc/self/fd/', '/dev/fd/')
        self.script = self.root / 'installer'; self.script.write_text(script)
        self.command('id', 'echo 0')
        self.command('getprop', 'case "$1" in ro.product.device) echo "${MODEL:-m30s}";; ro.product.model) echo "${MODEL_NAME:-SM-M307F}";; ro.twrp.version) echo "${TWRP_VERSION-3.7}";; ro.bootmode) echo "${BOOTMODE:-recovery}";; esac')
        self.command('blockdev', 'echo "${GEOMETRY:-5033164800}"')
        real_dd = shutil.which('dd')
        self.command('dd', f'touch "$FIXTURE/write-attempted"\n[ "${{FAIL_WRITE:-0}}" = 0 ] || exit 1\nexec "{real_dd}" "$@"')
        self.command('sha256sum', '''case "$1" in
 "$FIXTURE/boot") echo "${BOOT_HASH:-5219d618dad571438312ab1fcd62deaa9af17f3e49a48b70638bb9e817917426}  $1";;
 "$FIXTURE/vendor") echo "63548021f66206ce28fc1739eb157febcc0c456fe2e1e11886ec8fa782433646  $1";;
 *) exec python3 -c 'import hashlib,sys;print(hashlib.sha256(sys.stdin.buffer.read()).hexdigest()+"  -")';;
esac''')
        self.env = dict(os.environ, PATH=str(self.bin) + ':' + os.environ['PATH'], FIXTURE=str(self.root))

    def command(self, name, body):
        p = self.bin / name; p.write_text('#!/bin/sh\n' + body + '\n'); p.chmod(0o755)

    def make_zip(self, checksum=None, compressed=None):
        with zipfile.ZipFile(self.zip, 'w') as z:
            z.writestr('system.sha256', (checksum or self.image_hash) + '\n')
            z.writestr('system.img.xz', lzma.compress(self.payload) if compressed is None else compressed)

    def run_installer(self, **extra):
        return subprocess.run(['bash', str(self.script), '3', '1', str(self.zip)],
                              env=dict(self.env, **extra), capture_output=True, text=True, timeout=15)

    def test_success_writes_exact_system_and_preserves_other_partitions(self):
        r = self.run_installer(); self.assertEqual(r.returncode, 0, r.stdout + r.stderr)
        self.assertEqual((self.root / 'system').read_bytes(), self.payload)
        self.assertEqual((self.root / 'boot').read_bytes(), b'old-boot')
        self.assertEqual((self.root / 'vendor').read_bytes(), b'old-vendor')
        self.assertIn('System readback verified', r.stdout)

    def test_wrong_model_geometry_boot_or_checksum_never_write(self):
        for extra in ({'TWRP_VERSION': '', 'BOOTMODE': 'normal'}, {'MODEL': 'another-device'}, {'MODEL_NAME': 'SM-M307FN'}, {'GEOMETRY': '1'}, {'BOOT_HASH': '0' * 64}):
            with self.subTest(extra=extra):
                self.assertNotEqual(self.run_installer(**extra).returncode, 0)
                self.assertFalse((self.root / 'write-attempted').exists())
        self.make_zip(checksum='0' * 64)
        self.assertNotEqual(self.run_installer().returncode, 0)
        self.assertFalse((self.root / 'write-attempted').exists())

    def test_corrupt_compressed_payload_never_write(self):
        self.make_zip(compressed=b'not-xz')
        self.assertNotEqual(self.run_installer().returncode, 0)
        self.assertFalse((self.root / 'write-attempted').exists())

    def test_failed_write_reports_stay_in_recovery(self):
        r = self.run_installer(FAIL_WRITE='1')
        self.assertNotEqual(r.returncode, 0)
        self.assertIn('stay in recovery', r.stdout)
        self.assertNotIn('System readback verified', r.stdout)

    def test_mounted_system_rejects_before_write(self):
        (self.root / 'mounts').write_text(str(self.root / 'system') + ' /system ext4 ro 0 0\n')
        r = self.run_installer()
        self.assertNotEqual(r.returncode, 0)
        self.assertIn('Unmount', r.stdout)
        self.assertFalse((self.root / 'write-attempted').exists())

    def test_incorrect_readback_rejects_success(self):
        self.command('dd', 'cat >/dev/null; printf corrupt > "$FIXTURE/system"')
        r = self.run_installer()
        self.assertNotEqual(r.returncode, 0)
        self.assertIn('Readback mismatch', r.stdout)
        self.assertNotIn('System readback verified', r.stdout)

    def test_live_root_ext4_rejected_even_with_alias_block_source(self):
        (self.root / 'mounts').write_text('/dev/root / ext4 ro 0 0\n')
        self.assertNotEqual(self.run_installer().returncode, 0)
        self.assertFalse((self.root / 'write-attempted').exists())
