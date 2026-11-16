#!/usr/bin/env python3
"""Stage the pinned shared health shim with Samsung's kernel percentage policy."""
import argparse
import hashlib
from pathlib import Path
import shutil

CORE_SHA256 = '56c363b62ea5f1d1052952d0c4be99bb67cda5141a9aea8ec4694886a63ccd97'
OLD = b'    static boolean correctLevel = true;'
NEW = b'    static boolean correctLevel = false; // Samsung reports scaled SOC in capacity; charge_full is nominal.'


def stage(source, destination):
    source, destination = Path(source), Path(destination)
    data = (source / 'src/HealthCore.java').read_bytes()
    if hashlib.sha256(data).hexdigest() != CORE_SHA256 or data.count(OLD) != 1:
        raise ValueError('Pinned health source changed; review Samsung policy before building')
    if destination.exists():
        raise ValueError('Health staging destination already exists')
    shutil.copytree(source, destination, ignore=shutil.ignore_patterns('out', '__pycache__'))
    (destination / 'src/HealthCore.java').write_bytes(data.replace(OLD, NEW))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source')
    parser.add_argument('destination')
    args = parser.parse_args()
    stage(args.source, args.destination)


if __name__ == '__main__':
    main()
