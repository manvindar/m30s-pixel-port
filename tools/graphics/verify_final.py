#!/usr/bin/env python3
"""Fail-closed final-image checks for a narrowly pinned legacy graphics donor.
Scans all final native files, APK/JAR/ZIP native members and every APEX payload.
This verifies static linkage coverage; it does not establish device runtime ABI.
"""
import argparse
import json
from pathlib import Path
import shutil
import tempfile
import zipfile
from common import apex_manifest, digest, elf, extract_fs, unpack_apex


def missing_symbols(imports, providers):
    available = set().union(*(p['exports'] for p in providers))
    return sorted(imports - available)


def unproven_flag_provider_imports(imports):
    # Actual old/new vtables differ by one pointer-sized slot in both ABIs.
    # Export-name closure cannot establish this interface's calling convention.
    return sorted(name for name in imports if 'libui5flags' in name)


def unresolved_mapper_interface(imports, exports):
    # New Gralloc4/5 virtual lock slot10 has five arguments; donor requires seven.
    # Inline getGrallocMapper/getInstance can bypass direct lock-symbol coverage.
    exposed = ('13GrallocMapper', '14Gralloc4Mapper', '14Gralloc5Mapper',
               'SingletonINS_19GraphicBufferMapper', 'getGrallocMapper')
    return sorted(name for name in imports | exports if any(token in name for token in exposed))


def compatibility_failed(receipt):
    # Every failure category remains a publication blocker, even while collecting
    # independent caller evidence after a donor-linkage failure.
    return any(receipt[key] for key in ('donor_failures', 'consumer_failures',
                                       'flag_provider_consumers', 'mapper_callsite_candidates'))


class ImageInventory:
    def __init__(self, root, scratch):
        self.root, self.scratch = Path(root), Path(scratch)
        self.contexts = {'system': {'root': self.root, 'provide': [], 'require': []}}
        self.virtual = {}
        self.metadata = {}
        self.natives = []
        self.archives = []
        self.packages = []
        self.counts = {}
        self._register('system')
        for package in sorted(self.root.rglob('*')):
            if package.suffix not in ('.apex', '.capex') or not package.is_file():
                continue
            location = self.scratch / ('apex-' + str(len(self.packages)))
            _, payload, manifest_file = unpack_apex(package, location)
            manifest = apex_manifest(manifest_file)
            name = manifest['name']
            if name in self.contexts:
                raise RuntimeError('Duplicate final APEX namespace: ' + name)
            payload_root = extract_fs(payload, location / 'payload')
            self.contexts[name] = dict(manifest, root=payload_root)
            self.packages.append({'name': name, 'file': str(package.relative_to(self.root)),
                                  'sha256': digest(package), 'manifest': manifest})
            self._register(name)
        # APKs and other ZIP/JAR native members are consumers too.
        for context, data in self.contexts.items():
            for archive in sorted(data['root'].rglob('*')):
                if not archive.is_file() or archive.is_symlink() or archive.suffix not in ('.apk', '.jar', '.zip'):
                    continue
                if not zipfile.is_zipfile(archive):
                    raise RuntimeError('Invalid staged archive: ' + str(archive))
                members = 0
                with zipfile.ZipFile(archive) as z:
                    for member in z.infolist():
                        if member.is_dir():
                            continue
                        with z.open(member) as source:
                            if source.read(4) != b'\x7fELF':
                                continue
                        file = self.scratch / 'zip-native' / str(len(self.natives))
                        file.parent.mkdir(parents=True, exist_ok=True)
                        with z.open(member) as source, file.open('wb') as dest:
                            shutil.copyfileobj(source, dest)
                        item = elf(file)
                        if item is None:
                            raise RuntimeError('Invalid extracted ELF')
                        virtual = self._prefix(context) + '/' + str(archive.relative_to(data['root'])) + '!' + member.filename
                        self.natives.append((context, virtual, item))
                        members += 1
                self.archives.append({'context': context, 'file': str(archive.relative_to(data['root'])), 'native_members': members})
        if not self.packages or not self.archives:
            raise RuntimeError('Incomplete final image inventory')

    @staticmethod
    def _prefix(context):
        return '' if context == 'system' else '/apex/' + context

    def _register(self, context):
        root = self.contexts[context]['root']
        count = 0
        for path in sorted(root.rglob('*')):
            virtual = self._prefix(context) + '/' + str(path.relative_to(root))
            if path.is_symlink():
                target = path.readlink()
                if not target.is_absolute():
                    # Normalize virtual relative symlinks without host filesystem lookup.
                    import posixpath
                    target = Path(posixpath.normpath(str(Path(virtual).parent / target)))
                self.virtual[virtual] = str(target)
            elif path.is_file():
                self.virtual[virtual] = path
                item = elf(path)
                if item is not None:
                    self.metadata[virtual] = item
                    self.natives.append((context, virtual, item)); count += 1
        self.counts[context] = count
        if context == 'system' and count == 0:
            raise RuntimeError('Empty native system inventory')

    def get(self, virtual):
        seen = set()
        while virtual in self.virtual and isinstance(self.virtual[virtual], str):
            if virtual in seen:
                raise RuntimeError('Native symlink loop: ' + virtual)
            seen.add(virtual); virtual = self.virtual[virtual]
        return (virtual, self.metadata.get(virtual))

    def own(self, context, name, abi):
        directory = 'lib64' if abi == 'arm64' else 'lib'
        roots = ['/system/' + directory, '/system/system_ext/' + directory, '/system/product/' + directory] if context == 'system' else [self._prefix(context) + '/' + directory]
        if context == 'com.android.runtime':
            roots.append(self._prefix(context) + '/' + directory + '/bionic')
        for base in roots:
            virtual, item = self.get(base + '/' + name)
            if item and item['abi'] == abi:
                actual_context = virtual.split('/')[2] if virtual.startswith('/apex/') else 'system'
                return actual_context, virtual, item
        return None

    def resolve(self, context, name, abi):
        own = self.own(context, name, abi)
        if own:
            return own
        if context != 'system' and name not in self.contexts[context]['require']:
            raise RuntimeError(f'{context}/{abi}: dependency {name} absent locally and not required by APEX manifest')
        # External libraries can be reached only through explicitly exported APEX names,
        # or the system namespace selected by the manifest requirement.
        system = self.own('system', name, abi)
        if system:
            return system
        providers = []
        for candidate, data in self.contexts.items():
            if candidate != context and name in data['provide']:
                library = self.own(candidate, name, abi)
                if library:
                    providers.append(library)
        if len(providers) != 1:
            raise RuntimeError(f'{context}/{abi}: unresolved or ambiguous external dependency {name}: {len(providers)} providers')
        return providers[0]

    def closure(self, context, virtual, item):
        visited, providers, edges = set(), [], []
        def visit(ctx, path, metadata):
            if path in visited:
                return
            visited.add(path); providers.append(metadata)
            for name in metadata['needed']:
                dst_context, destination, target = self.resolve(ctx, name, metadata['abi'])
                edges.append({'from': path, 'needed': name, 'to': destination, 'namespace': dst_context})
                visit(dst_context, destination, target)
        visit(context, virtual, item)
        return providers, edges


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('image'); parser.add_argument('stage'); parser.add_argument('receipt')
    args = parser.parse_args()
    stage = Path(args.stage)
    donor = json.loads((stage / 'donor-receipt.json').read_text())
    for record in donor['files']:
        if digest(stage / record['relative_path']) != record['sha256']:
            raise RuntimeError('Donor stage hash changed')
    repack = json.loads((stage / 'codec-repack-receipt.json').read_text())
    receipt = {'input': donor['input'], 'donor_files': donor['files'], 'codec_repack': repack,
               'image_sha256': digest(args.image), 'consumer_failures': [], 'linkage': [], 'flag_provider_consumers': [], 'mapper_callsite_candidates': [],
               'device_validation': False, 'donor_failures': [],
               'limitations': ['Static ELF symbol and declared namespace checks do not prove runtime behavior or C++ object layout compatibility']}
    with tempfile.TemporaryDirectory(prefix='verify-final-graphics-') as scratch:
        tmp = Path(scratch)
        root = extract_fs(args.image, tmp / 'system')
        inventory = ImageInventory(root, tmp)
        # Require final Pixel package coverage; empty rdump or a missing staged partition fails.
        for partition in ('product', 'system_ext'):
            apps = list((root / 'system' / partition).rglob('*.apk'))
            if not apps:
                raise RuntimeError('Missing final Pixel/native coverage partition: ' + partition)
        evidence_dir = stage / 'abi-consumers'; evidence_dir.mkdir(exist_ok=True)
        evidence_bytes = 0
        def retain_provider(metadata):
            nonlocal evidence_bytes
            source = Path(metadata['source_path']); identity = digest(source); size = source.stat().st_size
            record = {'sha256': identity, 'bytes': size, 'exports': sorted(metadata['exports']), 'imports': sorted(metadata['imports']), 'needed': metadata['needed']}
            copy = evidence_dir / (identity + '.elf')
            if copy.is_file():
                record['evidence_file'] = str(copy.relative_to(stage))
            elif evidence_bytes + size <= 64 * 1024 ** 2:
                shutil.copyfile(source, copy); evidence_bytes += size
                record['evidence_file'] = str(copy.relative_to(stage))
            else:
                record['evidence_limit'] = '64MiB cap; missing evidence is not a pass'
            return record
        changed = {}
        for abi, directory in [('arm64', 'lib64'), ('arm32', 'lib')]:
            changed[abi] = set()
            for context, final_context in [('system', 'system'), ('codec', 'com.android.media.swcodec')]:
                latest = elf(stage / 'latest' / context / directory / 'libui.so')
                patched = stage / 'patched' / context / directory / 'libui.so'
                desired = elf(patched)
                if latest is None or desired is None or latest['abi'] != abi or desired['abi'] != abi:
                    raise RuntimeError('Invalid graphics reference ABI')
                changed[abi].update(latest['exports'] - desired['exports'])
                result = inventory.own(final_context, 'libui.so', abi)
                if result is None:
                    raise RuntimeError('Final graphics library missing')
                ctx, virtual, metadata = result
                actual = inventory.virtual[virtual]
                if digest(actual) != digest(patched):
                    raise RuntimeError('Final patched libui readback mismatch')
                try:
                    providers, edges = inventory.closure(ctx, virtual, metadata)
                    absent = missing_symbols(metadata['imports'], providers)
                    if absent:
                        receipt['donor_failures'].append({'context': ctx, 'abi': abi, 'file': virtual,
                            'missing': absent, 'edges': edges, 'providers': [retain_provider(p) for p in providers]})
                    # Each newly added interface must resolve every import too.
                    for edge in edges:
                        if 'android.hardware.graphics.' not in edge['needed']:
                            continue
                        target = inventory.metadata[edge['to']]
                        dep_providers, _ = inventory.closure(edge['namespace'], edge['to'], target)
                        missing = missing_symbols(target['imports'], dep_providers)
                        if missing:
                            receipt['donor_failures'].append({'context': edge['namespace'], 'abi': abi,
                                'file': edge['to'], 'missing': missing,
                                'providers': [retain_provider(p) for p in dep_providers]})
                except RuntimeError as error:
                    receipt['donor_failures'].append({'context': ctx, 'abi': abi, 'file': virtual,
                        'error': str(error), 'library': retain_provider(metadata)})
                    edges = []
                receipt['linkage'].append({'context': context, 'abi': abi, 'libui_sha256': digest(actual), 'edges': edges})
                if context == 'codec':
                    bind = root / 'system/etc/bpf.a17' / ('libui_swcodec64.so' if abi == 'arm64' else 'libui_swcodec32.so')
                    if not bind.is_file() or digest(bind) != digest(patched):
                        raise RuntimeError('Codec bind copy differs from verified APEX payload')
        receipt['tethering'] = []
        for tool, target in [('netbpfload', 'system/bin/netbpfload.a17'),
                             ('netd_updatable', 'system/etc/bpf.a17/libnetd_updatable.so'),
                             ('service_connectivity', 'system/etc/bpf.a17/libservice-connectivity.so')]:
            record = json.loads((stage / ('tethering-' + tool + '-receipt.json')).read_text())
            if digest(root / target) != record['output_sha256']:
                raise RuntimeError('Final measured tethering patch readback mismatch: ' + tool)
            receipt['tethering'].append(record)
        bluetooth = json.loads((stage / 'bluetooth-receipt.json').read_text())
        if digest(root / 'system/etc/bpf.a17/libbluetooth_jni.so') != bluetooth['output_sha256']:
            raise RuntimeError('Final measured Bluetooth patch readback mismatch')
        receipt['bluetooth'] = bluetooth
        runtime_budget = json.loads((stage / 'runtime-budget-receipt.json').read_text())
        actual_runtime = root / 'system/lib64/libandroid_runtime.so'
        if digest(actual_runtime) != runtime_budget['output_sha256']:
            raise RuntimeError('Final JNI-anchored runtime patch readback mismatch')
        receipt['runtime_budget'] = runtime_budget
        codec = [p for p in inventory.packages if p['name'] == 'com.android.media.swcodec']
        if len(codec) != 1 or codec[0]['sha256'] != repack['output_package_sha256']:
            raise RuntimeError('Final codec APEX differs from signed/readback-verified package')
        verified_ui_hashes = {record['libui_sha256'] for record in receipt['linkage']}
        # All native files and packaged natives, not just base system + codec.
        for context, virtual, metadata in inventory.natives:
            abi = metadata['abi']
            if abi not in changed:
                continue
            mapper = unresolved_mapper_interface(metadata.get('abi_imports', metadata['imports']), metadata['exports'])
            if mapper:
                source = Path(metadata['source_path'])
                identity = digest(source)
                if identity not in verified_ui_hashes:
                    size = source.stat().st_size
                    item = {'context': context, 'file': virtual, 'abi': abi, 'sha256': identity,
                            'bytes': size, 'interface_symbols': mapper, 'status': 'unreviewed-call-sites'}
                    copy = evidence_dir / (identity + '.elf')
                    if copy.is_file():
                        item['evidence_file'] = str(copy.relative_to(stage))
                    elif evidence_bytes + size <= 64 * 1024 ** 2:
                        shutil.copyfile(source, copy); evidence_bytes += size
                        item['evidence_file'] = str(copy.relative_to(stage))
                    else:
                        item['evidence_limit'] = '64MiB cap; missing code evidence is not a pass'
                    receipt['mapper_callsite_candidates'].append(item)
            uncertain = unproven_flag_provider_imports(metadata.get('abi_imports', metadata['imports']))
            if uncertain:
                receipt['flag_provider_consumers'].append({'context': context, 'file': virtual, 'imports': uncertain})
            affected_imports = metadata['imports'] & changed[abi]
            if not affected_imports:
                continue
            try:
                providers, _ = inventory.closure(context, virtual, metadata)
                absent = missing_symbols(affected_imports, providers)
            except RuntimeError as error:
                receipt['consumer_failures'].append({'context': context, 'file': virtual, 'error': str(error)})
                continue
            if absent:
                receipt['consumer_failures'].append({'context': context, 'file': virtual, 'missing': absent})
        receipt.update(native_files_scanned=len(inventory.natives), contexts=inventory.counts,
                       archives=inventory.archives, apex_packages=inventory.packages,
                       missing_exports={a: sorted(v) for a, v in changed.items()})
        if compatibility_failed(receipt):
            Path(args.receipt).write_text(json.dumps(receipt, indent=2) + '\n')
            raise RuntimeError('Donor linkage or final consumer graphics compatibility failed; complete retained evidence required')
    receipt['status'] = 'pass'
    Path(args.receipt).write_text(json.dumps(receipt, indent=2) + '\n')
    print('Final graphics coverage passed:', receipt['native_files_scanned'], 'native files, both ABIs, all APEX/APK consumers')


if __name__ == '__main__':
    try:
        main()
    except Exception as error:
        import sys
        if len(sys.argv) == 4:
            target = Path(sys.argv[3])
            partial = json.loads(target.read_text()) if target.is_file() else {}
            partial.update(status='failure', error=str(error), device_validation=False)
            target.write_text(json.dumps(partial, indent=2) + '\n')
        raise
