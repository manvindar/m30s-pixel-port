import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch
import inspect_codec_ownership as inspect


class CodecOwnershipTests(unittest.TestCase):
    def metadata(self, abi='arm64'):
        return {'abi': abi, 'needed': ['libc.so'], 'exports': {'move'},
                'imports': {'close'}, 'symbol_table_text': 'exact symbol evidence\n'}

    def source(self, directory):
        source = Path(directory) / 'source.so'; source.write_bytes(b'pinned-provider')
        return source, Path(directory) / 'retained/provider.so'

    def test_required_identity_and_readback(self):
        with tempfile.TemporaryDirectory() as tmp:
            source, target = self.source(tmp)
            with patch.object(inspect, 'elf', return_value=self.metadata()):
                total, row = inspect.retain_provider(source, target, 'arm64', 0)
            self.assertEqual(total, len(b'pinned-provider'))
            self.assertEqual(row['sha256'], inspect.digest(source))
            self.assertEqual(source.read_bytes(), target.read_bytes())

    def test_wrong_abi_rejected(self):
        with tempfile.TemporaryDirectory() as tmp:
            source, target = self.source(tmp)
            with patch.object(inspect, 'elf', return_value=self.metadata('arm32')):
                with self.assertRaisesRegex(RuntimeError, 'ABI mismatch'):
                    inspect.retain_provider(source, target, 'arm64', 0)
            self.assertFalse(target.exists())

    def test_empty_missing_and_symlink_rejected(self):
        with tempfile.TemporaryDirectory() as tmp:
            source, target = self.source(tmp)
            missing = Path(tmp) / 'missing.so'; empty = Path(tmp) / 'empty.so'; empty.touch()
            link = Path(tmp) / 'link.so'; link.symlink_to(source)
            for candidate in (missing, empty, link):
                with self.assertRaisesRegex(RuntimeError, 'nonregular'):
                    inspect.retain_provider(candidate, target, 'arm64', 0)

    def test_file_and_total_caps_reject(self):
        with tempfile.TemporaryDirectory() as tmp:
            source, target = self.source(tmp)
            with patch.object(inspect, 'FILE_CAP', 1):
                with self.assertRaisesRegex(RuntimeError, 'cap'):
                    inspect.retain_provider(source, target, 'arm64', 0)
            with self.assertRaisesRegex(RuntimeError, 'cap'):
                inspect.retain_provider(source, target, 'arm64', inspect.TOTAL_CAP)
            self.assertFalse(target.exists())

    def test_corrupt_copy_rejected(self):
        with tempfile.TemporaryDirectory() as tmp:
            source, target = self.source(tmp)
            def corrupt_copy(_source, destination):
                Path(destination).write_bytes(b'corrupt')
            with patch.object(inspect, 'elf', return_value=self.metadata()), patch.object(inspect.shutil, 'copyfile', side_effect=corrupt_copy):
                with self.assertRaisesRegex(RuntimeError, 'readback'):
                    inspect.retain_provider(source, target, 'arm64', 0)

    def test_complete_set_missing_duplicate_and_drift_reject(self):
        rows = [{'abi': abi, 'source_path': path} for abi, path in inspect.TARGETS]
        inspect.complete_receipt(rows)
        for bad in ([], rows[:-1], rows[:-1] + [rows[0]], rows + [rows[0]], rows[:-1] + [{'abi': 'arm64', 'source_path': '/different'}]):
            with self.assertRaisesRegex(RuntimeError, 'Incomplete'):
                inspect.complete_receipt(bad)

    def test_runner_space_gate_rejects_before_extraction(self):
        from types import SimpleNamespace
        with patch.object(inspect.shutil, 'disk_usage', return_value=SimpleNamespace(free=10)):
            with self.assertRaisesRegex(RuntimeError, 'Insufficient runner space'):
                inspect.require_space('/tmp', 11, 'test boundary')
            self.assertEqual(inspect.require_space('/tmp', 10, 'test boundary')['free_bytes'], 10)

    def test_failed_debugfs_extraction_is_not_exit_zero_pass(self):
        import common
        from types import SimpleNamespace
        with patch.object(common.subprocess, 'run', return_value=SimpleNamespace(returncode=0, stdout='', stderr='debugfs 1.47\nFile not found by ext2_lookup while dumping\n')):
            with self.assertRaisesRegex(RuntimeError, 'debugfs failed'):
                common.run('debugfs', '-R', 'dump /lib64/libhidlbase.so /tmp/provider.so', '/tmp/payload.img')


if __name__ == '__main__': unittest.main()
