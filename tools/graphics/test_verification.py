import tempfile
from pathlib import Path
import unittest
from unittest.mock import patch
from common import dump, extract_fs, protobuf_fields
from verify_final import ImageInventory, missing_symbols


def library(imports=(), exports=(), needed=()):
    return {'abi': 'arm64', 'imports': set(imports), 'exports': set(exports), 'needed': list(needed)}


class VerificationTests(unittest.TestCase):
    def test_zero_exit_missing_file_rejected(self):
        with tempfile.TemporaryDirectory() as scratch, patch('common.run', return_value=''):
            with self.assertRaisesRegex(RuntimeError, 'empty extraction'):
                dump('image', '/missing', Path(scratch) / 'missing')

    def test_zero_exit_empty_filesystem_rejected(self):
        with tempfile.TemporaryDirectory() as scratch, patch('common.run', return_value=''):
            image = Path(scratch) / 'image'
            data = bytearray(2048); data[1080:1082] = b'\x53\xef'; image.write_bytes(data)
            with self.assertRaisesRegex(RuntimeError, 'empty filesystem'):
                extract_fs(image, Path(scratch) / 'empty')

    def test_symbol_version_must_match(self):
        self.assertEqual(missing_symbols({'method@ABI2'}, [library(exports={'method@ABI1'})]), ['method@ABI2'])

    def test_codec_cannot_use_undeclared_system_dependency(self):
        inventory = ImageInventory.__new__(ImageInventory)
        inventory.contexts = {'codec': {'require': []}, 'system': {'provide': []}}
        inventory.own = lambda context, name, abi: None
        with self.assertRaisesRegex(RuntimeError, 'not required by APEX manifest'):
            inventory.resolve('codec', 'mapper2.so', 'arm64')

    def test_declared_but_missing_dependency_rejected(self):
        inventory = ImageInventory.__new__(ImageInventory)
        inventory.contexts = {'codec': {'require': ['mapper2.so'], 'provide': []}, 'system': {'provide': []}}
        inventory.own = lambda context, name, abi: None
        with self.assertRaisesRegex(RuntimeError, 'unresolved or ambiguous'):
            inventory.resolve('codec', 'mapper2.so', 'arm64')

    def test_transitive_own_namespace_and_missing_symbol(self):
        inventory = ImageInventory.__new__(ImageInventory)
        inventory.contexts = {'codec': {'require': [], 'provide': []}}
        mapper = library(exports={'mapper_method'}, needed=['common.so'])
        common = library(exports={'common_method'})
        objects = {'mapper2.so': mapper, 'common.so': common}
        inventory.own = lambda context, name, abi: ('codec', '/' + name, objects[name]) if name in objects else None
        ui = library(imports={'mapper_method', 'common_method', 'new_lock_method'}, needed=['mapper2.so'])
        providers, edges = inventory.closure('codec', '/libui.so', ui)
        self.assertEqual(len(edges), 2)
        self.assertEqual(missing_symbols(ui['imports'], providers), ['new_lock_method'])

    def test_corrupt_namespace_manifest_rejected(self):
        with self.assertRaisesRegex(ValueError, 'Truncated'):
            protobuf_fields(b'\x42\x05a')


if __name__ == '__main__':
    unittest.main()
