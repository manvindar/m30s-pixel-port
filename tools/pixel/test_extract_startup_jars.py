import importlib.util
import json
import lzma
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from unittest.mock import patch
import zipfile

spec = importlib.util.spec_from_file_location('startup_extract', Path(__file__).with_name('extract_startup_jars.py'))
m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)

class StartupExtraction(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(); self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name)
        self.build = dict(source_commit=m.SOURCE, actions_run=f'https://github.com/manvindar/m30s-pixel-port/actions/runs/{m.RUN}', experimental_dirty_flash=True, graphics_acceptance=False, system_bytes=m.RAW_BYTES)
        self.meta = dict(id=m.RUN, head_sha=m.SOURCE, status='completed', conclusion='success', path='.github/workflows/build-image.yml')
        self.receipt = self.root/'build-receipt.json'; self.receipt.write_text(json.dumps(self.build))
        self.packed = self.root/'system-a17-pixel.img.xz.part-00'; self.packed.write_bytes(lzma.compress(b'image'))
        self.patch_receipt = patch.object(m, 'BUILD_RECEIPT', m.digest(self.receipt)); self.patch_receipt.start(); self.addCleanup(self.patch_receipt.stop)
        self.patch_packed = patch.object(m, 'PACKED', m.digest(self.packed)); self.patch_packed.start(); self.addCleanup(self.patch_packed.stop)
        (self.root/'SHA256SUMS').write_text(f'{m.PACKED}  {self.packed.name}\n')

    def jar(self, name='services.jar', dex=b'dex\n041\0'+b'\0'*104):
        p=self.root/name
        with zipfile.ZipFile(p,'w') as z:z.writestr('classes.dex',dex)
        return p

    def test_exact_identity(self):
        self.assertEqual(self.packed,m.identities(self.root,self.meta))

    def test_wrong_run_source_or_failed_candidate_rejected(self):
        for key,value in [('id',1),('head_sha','wrong'),('conclusion','failure'),('path','other.yml')]:
            with self.subTest(key=key),self.assertRaises(ValueError):m.identities(self.root,dict(self.meta,**{key:value}))

    def test_receipt_byte_drift_rejected(self):
        self.receipt.write_text(self.receipt.read_text()+' ')
        with self.assertRaisesRegex(ValueError,'receipt hash'):m.identities(self.root,self.meta)

    def test_corrupt_or_extra_compressed_part_rejected(self):
        self.packed.write_bytes(b'corrupted')
        with self.assertRaisesRegex(ValueError,'Compressed'):m.identities(self.root,self.meta)
        (self.root/'system-a17-pixel.img.xz.part-01').write_bytes(b'part')
        with self.assertRaisesRegex(ValueError,'part set'):m.identities(self.root,self.meta)

    def test_raw_size_and_hash_enforced(self):
        target=self.root/'raw'
        with patch.object(m,'RAW_BYTES',5),patch.object(m,'RAW',__import__('hashlib').sha256(b'image').hexdigest()):m.expand(self.packed,target)
        target.unlink()
        with patch.object(m,'RAW_BYTES',4),self.assertRaisesRegex(ValueError,'exceeds'):m.expand(self.packed,target)
        target.unlink()
        with patch.object(m,'RAW_BYTES',5),patch.object(m,'RAW','wrong'),self.assertRaisesRegex(ValueError,'identity'):m.expand(self.packed,target)

    def test_dex_identity_and_malformed_header(self):
        jar=self.jar();self.assertEqual('classes.dex',m.jar_identity(jar)['dex_members'][0]['member'])
        bad=self.jar('bad.jar',b'wrong'+b'\0'*112)
        with self.assertRaisesRegex(ValueError,'DEX header'):m.jar_identity(bad)

    def test_duplicate_and_oversize_dex_rejected(self):
        jar=self.jar()
        with zipfile.ZipFile(jar,'a') as z:z.writestr('classes.dex',b'dex\n041\0'+b'\0'*104)
        with self.assertRaisesRegex(ValueError,'Duplicate'):m.jar_identity(jar)
        jar=self.jar('large.jar')
        with patch.object(m,'JAR_CAP',1),self.assertRaisesRegex(ValueError,'JAR size'):m.jar_identity(jar)

    def test_real_ext4_roundtrip_and_services_hash_guard(self):
        e2=next((p for p in ('/opt/homebrew/opt/e2fsprogs/sbin','/usr/sbin','/sbin') if Path(p,'mke2fs').exists()),None)
        if not e2:self.skipTest('ext4 host tools unavailable')
        import os
        jar=self.jar();framework=self.jar('framework.jar');image=self.root/'system.img'
        with image.open('wb') as f:f.truncate(8*1024**2)
        subprocess.run([e2+'/mke2fs','-q','-F','-t','ext4',str(image)],check=True)
        commands=self.root/'cmds';commands.write_text(f'write {framework} /framework.jar\nwrite {jar} /services.jar\n')
        subprocess.run([e2+'/debugfs','-w','-f',str(commands),str(image)],check=True,capture_output=True)
        out=self.root/'out';out.mkdir()
        with patch.dict(os.environ,PATH=e2+os.pathsep+os.environ['PATH']),patch.object(m,'MEMBERS',('/framework.jar','/services.jar')),patch.object(m,'SERVICES',m.digest(jar)):
            self.assertEqual(2,len(m.extract(image,out)))
        out2=self.root/'wrong';out2.mkdir()
        with patch.dict(os.environ,PATH=e2+os.pathsep+os.environ['PATH']),patch.object(m,'MEMBERS',('/services.jar',)),patch.object(m,'SERVICES','wrong'),self.assertRaisesRegex(ValueError,'services identity'):m.extract(image,out2)
        with patch.dict(os.environ,PATH=e2+os.pathsep+os.environ['PATH']),patch.object(m,'MEMBERS',('/missing.jar',)),self.assertRaises((ValueError,RuntimeError)):m.extract(image,out2)

if __name__=='__main__':unittest.main()
