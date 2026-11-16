#!/usr/bin/env python3
"""Extract two exact flashed-candidate JARs; no image build or device access."""
import json
import lzma
from pathlib import Path
import re
import sys
import zipfile
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'graphics'))
from common import digest, dump, run

RUN = 43807393475
SOURCE = '9597e5744b2fa5761e6c9a50a7593b147b0219d1'
PACKED = 'b9726348dc73085022ab837e378c95f94dda2311edfa4a3bc24686e1637ade1d'
RAW = 'e2f65fbceee11413d143cb7c09cb3d9691bc57bc2b19302cc4b8405a96eeb4a6'
SERVICES = 'e0763c2a8e1f8b10d56c22e12dfd7312eb98505313c5a01f53eaebf0a19cf07d'
BUILD_RECEIPT = '9b1b69bc388808503cea5ac839700edd7c28d9af0660f08ed0ebc52fff6d7271'
RAW_BYTES = 5033164800
JAR_CAP = 64 * 1024**2
TOTAL_CAP = 128 * 1024**2
MEMBERS = ('/system/framework/framework.jar', '/system/framework/services.jar')

def require(condition, message):
    if not condition:
        raise ValueError(message)

def identities(candidate, metadata):
    require(metadata['id'] == RUN and metadata['head_sha'] == SOURCE, 'Wrong candidate identity')
    require(metadata['status'] == 'completed' and metadata['conclusion'] == 'success', 'Candidate not successful')
    require(metadata['path'] == '.github/workflows/build-image.yml', 'Wrong workflow')
    receipt = candidate / 'build-receipt.json'
    require(digest(receipt) == BUILD_RECEIPT, 'Build receipt hash mismatch')
    build = json.loads(receipt.read_text())
    require(build['source_commit'] == SOURCE and build['actions_run'] == f'https://github.com/manvindar/m30s-pixel-port/actions/runs/{RUN}', 'Wrong build receipt identity')
    require(build['experimental_dirty_flash'] is True and build['graphics_acceptance'] is False, 'Wrong experimental receipt')
    require(build['system_bytes'] == RAW_BYTES, 'Wrong image size receipt')
    parts = sorted(candidate.glob('system-a17-pixel.img.xz.part-*'))
    require([p.name for p in parts] == ['system-a17-pixel.img.xz.part-00'], 'Wrong compressed part set')
    sums = dict((name.lstrip('*'), sha) for sha, name in (line.split(maxsplit=1) for line in (candidate/'SHA256SUMS').read_text().splitlines()))
    require(sums.get(parts[0].name) == PACKED and digest(parts[0]) == PACKED, 'Compressed image hash mismatch')
    return parts[0]

def expand(packed, target):
    size = 0
    with lzma.open(packed, 'rb') as src, target.open('xb') as dst:
        for block in iter(lambda: src.read(8 * 1024**2), b''):
            size += len(block)
            require(size <= RAW_BYTES, 'Image exceeds exact size')
            dst.write(block)
    require(size == RAW_BYTES and digest(target) == RAW, 'Raw image identity mismatch')

def jar_identity(path):
    require(path.is_file() and not path.is_symlink() and 0 < path.stat().st_size <= JAR_CAP, 'Invalid JAR size/type')
    dex = []
    total = 0
    with zipfile.ZipFile(path) as z:
        names = z.namelist()
        require(len(names) == len(set(names)), 'Duplicate ZIP member')
        for info in z.infolist():
            if not re.fullmatch(r'classes(?:[2-9]|[1-9][0-9]+)?\.dex', info.filename):
                continue
            require(112 <= info.file_size <= JAR_CAP, 'Invalid DEX size')
            total += info.file_size
            require(total <= TOTAL_CAP, 'DEX expansion cap exceeded')
            data = z.read(info)
            require(data[:4] == b'dex\n' and data[4:7] in (b'035', b'037', b'038', b'039', b'040', b'041') and data[7] == 0, 'Invalid DEX header')
            import hashlib
            dex.append({'member': info.filename, 'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()})
    require(dex and dex[0]['member'] == 'classes.dex', 'Missing primary DEX')
    return {'bytes': path.stat().st_size, 'sha256': digest(path), 'dex_members': dex}

def extract(image, out):
    files = []
    total = 0
    for member in MEMBERS:
        st = run('debugfs', '-R', f'stat {member}', image)
        size = re.search(r'\bSize:\s*(\d+)', st)
        require(size is not None and 'Type: regular' in st, 'Missing/nonregular JAR: ' + member)
        length = int(size[1]); total += length
        require(0 < length <= JAR_CAP and total <= TOTAL_CAP, 'JAR extraction cap exceeded')
        target = out / Path(member).name
        dump(image, member, target)
        require(target.stat().st_size == length, 'Extraction size mismatch')
        item = jar_identity(target)
        if member.endswith('/services.jar'):
            require(item['sha256'] == SERVICES, 'Installed services identity mismatch')
        files.append({'image_path': member, **item})
    return files

def main():
    candidate, metadata, output = map(Path, sys.argv[1:])
    output.mkdir(exist_ok=False)
    receipt = {'candidate_run': RUN, 'source_commit': SOURCE, 'acceptance': False, 'device_actions': False, 'status': 'failed'}
    image = output.parent / 'startup-extraction-system.img'
    try:
        packed = identities(candidate, json.loads(metadata.read_text()))
        expand(packed, image)
        receipt.update(parent_compressed_sha256=PACKED, parent_raw_sha256=RAW, parent_raw_bytes=RAW_BYTES)
        receipt['files'] = extract(image, output)
        receipt['status'] = 'exact-two-jar-extraction-pass'
        receipt['limitations'] = ['Static input evidence only; historical enqueue origin not observed', 'DEX header/member identity checks are not semantic verification', 'No deferred-broadcast patch or runtime validation']
    except Exception as error:
        receipt['error'] = str(error)
        raise
    finally:
        (output/'receipt.json').write_text(json.dumps(receipt, indent=2)+'\n')
        image.unlink(missing_ok=True)

if __name__ == '__main__':
    main()
