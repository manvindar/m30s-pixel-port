import hashlib,tempfile,unittest
from pathlib import Path
from unittest.mock import patch
from verified_input import obtain
class CacheTests(unittest.TestCase):
    def test_valid_cached_file_avoids_network(self):
        with tempfile.TemporaryDirectory() as d:
            p=Path(d)/'input.zip';p.write_bytes(b'pinned');h=hashlib.sha256(b'pinned').hexdigest()
            with patch('verified_input.subprocess.run') as run:self.assertEqual(obtain('https://example.invalid',h,p),p);run.assert_not_called()
    def test_corrupted_cache_rejected(self):
        with tempfile.TemporaryDirectory() as d:
            p=Path(d)/'input.zip';p.write_bytes(b'corrupt')
            with patch('verified_input.subprocess.run') as run,self.assertRaisesRegex(ValueError,'checksum'):obtain('https://example.invalid','0'*64,p)
            run.assert_not_called()
    def test_new_download_verified_before_atomic_promotion(self):
        with tempfile.TemporaryDirectory() as d:
            p=Path(d)/'input.zip';h=hashlib.sha256(b'pinned').hexdigest()
            def download(args,check):Path(args[-2]).write_bytes(b'pinned')
            with patch('verified_input.subprocess.run',side_effect=download):obtain('https://example.invalid',h,p)
            self.assertEqual(p.read_bytes(),b'pinned');self.assertFalse(p.with_name(p.name+'.partial').exists())
    def test_bad_download_never_becomes_cache_entry(self):
        with tempfile.TemporaryDirectory() as d:
            p=Path(d)/'input.zip'
            def download(args,check):Path(args[-2]).write_bytes(b'wrong')
            with patch('verified_input.subprocess.run',side_effect=download),self.assertRaisesRegex(ValueError,'checksum'):obtain('https://example.invalid','0'*64,p)
            self.assertFalse(p.exists())
if __name__=='__main__':unittest.main()
