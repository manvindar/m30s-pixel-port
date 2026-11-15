#!/usr/bin/env python3
"""Extract the pinned permission target and resource facts without changing it."""
import json
import os
from pathlib import Path
import shutil
import sys
import tempfile
import zipfile
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'graphics'))
from common import digest, dump, extract_fs, run, unpack_apex
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'downloads'))
from verified_input import obtain


def main():
    pins = json.loads(Path('docs/A17-UPSTREAM.json').read_text())['gsi']
    out = Path('safety-target-evidence'); out.mkdir(exist_ok=False)
    archive = Path('download-cache/gsi/gsi.zip')
    obtain(pins['url'], pins['sha256'], archive)
    with tempfile.TemporaryDirectory() as scratch:
        tmp = Path(scratch)
        image = tmp / 'system.img'
        with zipfile.ZipFile(archive) as z:
            names = [n for n in z.namelist() if Path(n).name == 'system.img']
            if len(names) != 1: raise RuntimeError('Ambiguous GSI image')
            with z.open(names[0]) as src, image.open('wb') as dst: shutil.copyfileobj(src, dst)
        if image.open('rb').read(4) == bytes.fromhex('3aff26ed'): raise RuntimeError('Unexpected sparse input')
        module = dump(image, '/system/apex/com.android.permission.capex', tmp / 'permission.capex')
        _, payload, manifest = unpack_apex(module, tmp / 'module')
        root = extract_fs(payload, tmp / 'payload')
        matches = list(root.rglob('SafetyCenterResources.apk'))
        if len(matches) != 1: raise RuntimeError('Missing/ambiguous SafetyCenter APK')
        target = out / 'SafetyCenterResources.apk'; shutil.copyfile(matches[0], target)
        bt = Path(os.environ['ANDROID_HOME']) / 'build-tools/35.0.0'
        for name, cmd in [('signer.txt', [bt/'apksigner','verify','--verbose','--print-certs',target]),
                          ('manifest.txt',[bt/'aapt2','dump','xmltree','--file','AndroidManifest.xml',target]),
                          ('resources.txt',[bt/'aapt2','dump','resources',target])]:
            (out/name).write_text(run(*cmd))
        records=[]
        with zipfile.ZipFile(target) as z:
            for name in z.namelist():
                if name.startswith('res/raw') and 'safety_center_config' in name:
                    dest=out/name;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_bytes(z.read(name))
                    records.append({'member':name,'sha256':digest(dest),'bytes':dest.stat().st_size})
        if not records: raise RuntimeError('Missing safety configurations')
        parsers=[]; total=target.stat().st_size
        for path in sorted((root/'javalib').glob('*.jar')):
            total += path.stat().st_size
            if total > 32*1024**2: raise RuntimeError('Permission evidence exceeds 32MiB bound')
            dest=out/'javalib'/path.name;dest.parent.mkdir(exist_ok=True);shutil.copyfile(path,dest)
            parsers.append({'file':str(dest.relative_to(out)),'sha256':digest(dest),'bytes':dest.stat().st_size})
        receipt={'input':pins,'permission_capex_sha256':digest(module),'permission_payload_sha256':digest(payload),
                 'target_sha256':digest(target),'target_bytes':target.stat().st_size,'target_source_path':str(matches[0].relative_to(root)),
                 'configs':records,'parser_jars':parsers,'validation':'Strict extraction, pinned GSI checksum, target signer/manifest/resource transcript; compatibility not yet accepted'}
        (out/'receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')


if __name__ == '__main__': main()
