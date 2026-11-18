import hashlib
import importlib.util
from pathlib import Path
import tempfile
import unittest

spec = importlib.util.spec_from_file_location('public_assets', Path(__file__).with_name('select_public_assets.py'))
assets = importlib.util.module_from_spec(spec)
spec.loader.exec_module(assets)


class PublicAssetsTests(unittest.TestCase):
    def test_internal_reports_and_posting_drafts_are_not_published(self):
        with tempfile.TemporaryDirectory() as tmp:
            source = Path(tmp) / 'out'; source.mkdir()
            for name in assets.ASSETS['twrp']:
                (source / name).write_bytes(('verified ' + name).encode())
            for name in ['XDA-POST.md', 'RELEASE-NOTES.md', 'build-receipt.json', 'graphics-compatibility-verification.json']:
                (source / name).write_text('internal evidence or drafting text')
            destination = Path(tmp) / 'public'
            assets.select(source, destination, 'twrp')
            self.assertEqual({p.name for p in destination.iterdir()}, assets.ASSETS['twrp'] | {'SHA256SUMS'})
            for line in (destination / 'SHA256SUMS').read_text().splitlines():
                expected, name = line.split(maxsplit=1)
                self.assertEqual(expected, hashlib.sha256((destination / name).read_bytes()).hexdigest())

    def test_missing_required_image_prevents_public_package(self):
        with tempfile.TemporaryDirectory() as tmp:
            source = Path(tmp) / 'out'; source.mkdir()
            destination = Path(tmp) / 'public'
            with self.assertRaises(RuntimeError):
                assets.select(source, destination, 'image')
            self.assertFalse(destination.exists())
