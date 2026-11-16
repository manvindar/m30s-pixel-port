"""Small real-byte fixtures exercise prewrite rejection and interrupted rewrites."""
import contextlib
import gzip
import hashlib
import io
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch
from types import SimpleNamespace

import flash_system_verified as writer
import restore_system_verified as restore


def sha(data):
    return hashlib.sha256(data).hexdigest()


class SystemWriterTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name)
        self.image = self.root / 'system.img'
        self.raw = bytes(range(32))
        self.image.write_bytes(self.raw)
        lengths = [1] * 18 + [14]
        offset = 0
        windows = []
        for length in lengths:
            windows.append({'offset_bytes': offset, 'length_bytes': length,
                            'sha256': sha(self.raw[offset:offset + length])})
            offset += length
        self.manifest = {'schema': 'm30s-raw-readback-v1', 'partition': 'system',
                         'size_bytes': 32, 'windows': windows, 'sha256': sha(self.raw),
                         'source_commit': 'reviewed-source', 'actions_run': 'reviewed-run'}
        self.backup = self.root / 'rollback.gz'
        self.old = b'o' * 32
        self.trailer = '32 bytes copied\n'
        self.backup.write_bytes(gzip.compress(self.old + self.trailer.encode()))
        self.rollback = {'device': 'test-phone', 'raw_bytes': 32,
                         'gzip_readback_verified': True, 'compressed_file': 'rollback.gz',
                         'compressed_bytes': self.backup.stat().st_size,
                         'compressed_sha256': sha(self.backup.read_bytes()),
                         'raw_sha256': sha(self.old), 'trailing_text': self.trailer,
                         'trailing_bytes': len(self.trailer)}
        self.prior = {'device': 'test-phone', 'target': writer.TARGET, 'apply': True,
                      'candidate_sha256': sha(self.raw), 'source_commit': 'reviewed-source',
                      'actions_run': 'reviewed-run', 'gates': 'pass', 'write_returncode': 255}
        self.output = self.root / 'retry.json'
        self.calls = []
        self.current = sha(b'partial')
        self.readback = sha(self.raw)
        self.preserved = {'boot': 'fixed-boot', 'vendor': 'fixed-vendor'}
        self.mounts = ''

    def run_writer(self, resume=True, code=0):
        for name, value in [('manifest.json', self.manifest), ('rollback.json', self.rollback),
                            ('prior.json', self.prior)]:
            (self.root / name).write_text(json.dumps(value))
        argv = ['writer', str(self.image), str(self.root / 'manifest.json'),
                str(self.root / 'rollback.json'), str(self.output), '--apply',
                '--serial', 'test-phone', '--boot-sha256', 'fixed-boot',
                '--vendor-sha256', 'fixed-vendor', '--source-commit', 'reviewed-source',
                '--actions-run', 'reviewed-run']
        if resume:
            argv += ['--resume-interrupted-write', str(self.root / 'prior.json')]
        def shell(command):
            return {'getprop ro.serialno': 'test-phone', 'id -u': '0',
                    'getprop ro.twrp.version': '3.7', 'getprop ro.bootmode': 'recovery',
                    'readlink -f ' + writer.TARGET: '/dev/block/sda25',
                    'blockdev --getsize64 ' + writer.TARGET: '32',
                    'cat /proc/mounts': self.mounts}[command]
        def partition_hash(name):
            if name == 'system':
                return self.readback if self.calls and code == 0 else self.current
            return self.preserved[name]
        def run(command, **kwargs):
            self.calls.append((command, kwargs['stdin'].read()))
            return SimpleNamespace(returncode=code, stdout=b'', stderr=b'')
        with patch.object(writer, 'SIZE', 32), patch.object(restore, 'SIZE', 32), \
             patch.object(writer, 'shell', side_effect=shell), \
             patch.object(writer, 'partition_hash', side_effect=partition_hash), \
             patch.object(writer.subprocess, 'run', side_effect=run), \
             patch.object(sys, 'argv', argv), contextlib.redirect_stdout(io.StringIO()):
            writer.main()

    def test_retry_rewrites_whole_image_and_requires_readback(self):
        self.run_writer()
        self.assertEqual(len(self.calls), 1)
        self.assertEqual(self.calls[0][1], self.raw)
        self.assertEqual(self.calls[0][0][-1],
                         'dd of=/dev/block/by-name/system bs=1048576 && sync')
        self.assertEqual(json.loads(self.output.read_text())['status'], 'readback-pass')

    def test_unknown_partial_system_rejected_without_interruption_receipt(self):
        with self.assertRaises(AssertionError):
            self.run_writer(resume=False)
        self.assertEqual(self.calls, [])

    def test_prior_identity_and_failure_conditions_reject_before_write(self):
        for field in self.prior:
            with self.subTest(field=field):
                original = self.prior[field]
                self.prior[field] = 'changed'
                with self.assertRaises(AssertionError):
                    self.run_writer()
                self.assertEqual(self.calls, [])
                self.prior[field] = original

    def test_manifest_source_and_run_drift_reject_before_write(self):
        for field in ['source_commit', 'actions_run']:
            original = self.manifest[field]
            self.manifest[field] = 'changed'
            with self.assertRaises(AssertionError):
                self.run_writer()
            self.assertEqual(self.calls, [])
            self.manifest[field] = original

    def test_changed_image_rejects_before_device_write(self):
        self.image.write_bytes(b'x' * 32)
        with self.assertRaises(AssertionError):
            self.run_writer()
        self.assertEqual(self.calls, [])

    def test_changed_rollback_carrier_rejects_before_write(self):
        data = bytearray(self.backup.read_bytes())
        data[4] ^= 1  # Same size, different gzip header.
        self.backup.write_bytes(data)
        with self.assertRaises(AssertionError):
            self.run_writer()
        self.assertEqual(self.calls, [])

    def test_wrong_raw_rollback_hash_rejects_before_write(self):
        self.rollback['raw_sha256'] = 'wrong'
        with self.assertRaises(AssertionError):
            self.run_writer()
        self.assertEqual(self.calls, [])

    def test_interrupted_retry_records_failure_without_readback_or_reboot(self):
        with self.assertRaises(AssertionError):
            self.run_writer(code=255)
        receipt = json.loads(self.output.read_text())
        self.assertEqual(receipt['write_returncode'], 255)
        self.assertNotIn('readback_sha256', receipt)
        self.assertEqual(len(self.calls), 1)

    def test_changed_boot_or_vendor_rejects_before_write(self):
        for name in ['boot', 'vendor']:
            original = self.preserved[name]
            self.preserved[name] = 'changed'
            with self.assertRaises(AssertionError):
                self.run_writer()
            self.assertEqual(self.calls, [])
            self.preserved[name] = original

    def test_mounted_system_rejects_before_write(self):
        self.mounts = '/dev/block/sda25 /system ext4 rw 0 0'
        with self.assertRaises(AssertionError):
            self.run_writer()
        self.assertEqual(self.calls, [])

    def test_readback_mismatch_records_failure_without_reboot(self):
        self.readback = sha(b'wrong')
        with self.assertRaises(AssertionError):
            self.run_writer()
        self.assertEqual(json.loads(self.output.read_text())['status'], 'readback-failure')
        self.assertEqual(len(self.calls), 1)

    def test_restore_stream_excludes_dd_statistics(self):
        with patch.object(restore, 'SIZE', 32):
            self.assertEqual(b''.join(restore.restore_chunks(self.backup, self.rollback)), self.old)
            restore.verify(self.backup, self.rollback)

    def test_wrong_trailer_is_not_silently_accepted(self):
        self.rollback['trailing_text'] = 'wrong'
        with patch.object(restore, 'SIZE', 32), self.assertRaises(AssertionError):
            restore.verify(self.backup, self.rollback)

    def test_optimized_python_cannot_disable_write_guards(self):
        result = subprocess.run([sys.executable, '-O', str(Path(writer.__file__)), '--help'],
                                capture_output=True, text=True)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('verification assertions are required', result.stderr)


if __name__ == '__main__':
    unittest.main()
