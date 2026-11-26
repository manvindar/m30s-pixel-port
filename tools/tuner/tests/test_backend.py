import os
from pathlib import Path
import subprocess
import tempfile
import unittest

SCRIPT = Path(__file__).resolve().parents[1] / 'device/m30s_tunerd.sh'


class Fixture(unittest.TestCase):
    """A fake /sys and /proc tree for the backend (--test mode). Subclasses pick the tables."""
    LITTLE = ('1742000 1326000 403000', '403000', '1742000')
    BIG = ('2314000 1768000 936000', '936000', '2314000')
    GOVERNORS = 'schedutil performance'
    TOUCH = True

    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name)
        self.app = self.root / 'app'; self.app.mkdir()
        for cluster, (freqs, minf, maxf) in [('0', self.LITTLE), ('4', self.BIG)]:
            prefix = 'sys/devices/system/cpu/cpufreq/policy' + cluster + '/'
            for name, value in {'scaling_available_frequencies': freqs, 'scaling_min_freq': minf,
                                'scaling_max_freq': maxf, 'scaling_available_governors': self.GOVERNORS,
                                'scaling_governor': 'schedutil', 'scaling_cur_freq': minf}.items():
                self.put(prefix + name, value)
        if self.TOUCH:
            for name, value in [('duration_ms', '150'), ('enabled', 'Y')]:
                self.put('sys/module/input_boost_m30s/parameters/' + name, value)
        self.put('proc/sys/vm/swappiness', '130')
        self.put('proc/meminfo', 'MemAvailable: 123456 kB')
        self.put('sys/devices/platform/11500000.mali/clock', '683000')
        self.put('sys/class/thermal/thermal_zone0/temp', '46000')
        self.put('sys/class/power_supply/battery/capacity', '100')
        self.put('sys/class/thermal/thermal_zone0/mode', 'enabled')
        self.put('proc/sys/net/ipv4/tcp_available_congestion_control', 'cubic reno')
        self.put('proc/sys/net/ipv4/tcp_congestion_control', 'cubic')
        gpu = 'sys/devices/platform/11500000.mali/'
        self.put(gpu + 'dvfs_table', ' 1053000 949000 839000 764000 683000 572000 546000 455000 385000 338000 260000 ')
        self.put(gpu + 'dvfs_max_lock', '-1')
        self.put(gpu + 'dvfs_min_lock', '-1')
        for disk in 'abcde':
            self.add_disk('sd' + disk, 'sys/devices/platform/11120000.ufs/host0/target0:0:0/0:0:0:%d/block/' % ('abcde'.index(disk)))
        self.bin = self.root / 'bin'; self.bin.mkdir()
        mock = self.bin / 'settings'
        mock.write_text('''#!/bin/sh
key=$3
case "$1" in
 get) [ -f "$MOCK_ROOT/settings.$key" ] && cat "$MOCK_ROOT/settings.$key" || echo 0.5;;
 put) printf '%s\\n' "$4" > "$MOCK_ROOT/settings.$key";;
 *) exit 1;;
esac
''')
        mock.chmod(0o755)
        self.env = dict(os.environ, PATH=str(self.bin) + ':' + os.environ['PATH'], MOCK_ROOT=str(self.root))

    def add_disk(self, name, parent, scheduler='noop [cfq]'):
        """A block device in the device tree with /sys/block/<name> linking to it, as on the phone."""
        real = self.root / parent / name
        for node, value in (('queue/scheduler', scheduler), ('queue/read_ahead_kb', '128')):
            (real / node).parent.mkdir(parents=True, exist_ok=True); (real / node).write_text(value + '\n')
        (self.root / 'sys/block').mkdir(parents=True, exist_ok=True)
        link = self.root / 'sys/block' / name
        if not link.exists(): link.symlink_to(real)

    def put(self, name, value):
        path = self.root / name; path.parent.mkdir(parents=True, exist_ok=True); path.write_text(value + '\n')

    def read(self, name):
        return (self.root / name).read_text().strip()

    def run_backend(self, request=None):
        if request is not None:
            (self.app / 'request').write_text(request)
        result = subprocess.run(['sh', str(SCRIPT), '--test', str(self.root), '--once'], env=self.env,
                                capture_output=True, text=True, timeout=10)
        self.assertEqual(result.returncode, 0, result.stderr)
        return (self.app / 'state').read_text()

    def snapshot(self):
        return {p: p.read_bytes() for top in ['sys', 'proc'] for p in (self.root / top).rglob('*') if p.is_file()}


class BackendTests(Fixture):
    def test_installation_does_not_apply_defaults(self):
        before = {p: p.read_bytes() for p in (self.root / 'sys').rglob('*') if p.is_file()}
        state = self.run_backend()
        self.assertIn('backend=m30s', state)
        self.assertIn('gpu_khz=683000', state)
        self.assertEqual(before, {p: p.read_bytes() for p in before})
        self.assertFalse((self.root / 'private/config').exists())

    def test_battery_profile_maps_correct_clusters_and_keeps_thermal(self):
        state = self.run_backend('perf_profile=battery\n')
        self.assertIn('Applied battery', state)
        self.assertEqual(self.read('sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq'), '1326000')
        self.assertEqual(self.read('sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq'), '1768000')
        self.assertEqual(self.read('sys/class/thermal/thermal_zone0/mode'), 'enabled')
        self.assertEqual(self.read('sys/module/input_boost_m30s/parameters/duration_ms'), '100')

    def test_responsive_profile_stock_caps_and_bounded_boost(self):
        state = self.run_backend('perf_profile=performance\n')
        self.assertIn('perf_profile=performance', state)
        self.assertEqual(self.read('sys/devices/system/cpu/cpufreq/policy4/scaling_governor'), 'schedutil')
        self.assertEqual(self.read('sys/module/input_boost_m30s/parameters/duration_ms'), '300')
        self.assertEqual(self.read('sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq'), '2314000')

    def test_unsupported_and_injected_values_never_write(self):
        for request in ['cap_big=9999999\n', 'touch_duration_ms=501\n', 'touch_duration_ms=-1\n',
                        'governor=schedplus\n', 'thermal=off\n', 'gpu_freq=900000\n',
                        'swappiness=201\n', 'swappiness=1;touch /tmp/tuner-injected\n',
                        'touch_enabled=1\nswappiness=0\n']:
            with self.subTest(request=request):
                before = {p: p.read_bytes() for top in ['sys', 'proc'] for p in (self.root / top).rglob('*') if p.is_file()}
                state = self.run_backend(request)
                self.assertIn('Rejected', state)
                self.assertEqual(before, {p: p.read_bytes() for p in before})

    def test_cap_below_current_minimum_rejected(self):
        self.put('sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq', '2314000')
        state = self.run_backend('cap_big=936000\n')
        self.assertIn('Rejected', state)
        self.assertEqual(self.read('sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq'), '2314000')

    def test_partial_profile_failure_restores_first_cluster(self):
        self.put('sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq', '2314000')
        state = self.run_backend('perf_profile=battery\n')
        self.assertIn('Rejected or restored failed profile', state)
        self.assertEqual(self.read('sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq'), '1742000')
        self.assertEqual(self.read('sys/module/input_boost_m30s/parameters/duration_ms'), '150')

    def test_missing_touch_provider_skips_boost_but_applies_clock_profile(self):
        for name in ('enabled', 'duration_ms'):
            (self.root / 'sys/module/input_boost_m30s/parameters' / name).unlink()
        state = self.run_backend('perf_profile=battery\n')
        self.assertIn('Applied battery', state)
        self.assertIn('touch_supported=0', state)
        self.assertEqual(self.read('sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq'), '1326000')

    def test_animation_and_swappiness_readback(self):
        self.assertIn('Applied anim_scale', self.run_backend('anim_scale=1.0\n'))
        for name in ['window_animation_scale', 'transition_animation_scale', 'animator_duration_scale']:
            self.assertEqual(self.read('settings.' + name), '1.0')
        self.assertIn('swappiness=100', self.run_backend('swappiness=100\n'))

    def test_saved_request_revalidated_at_restart(self):
        self.run_backend('touch_duration_ms=200\n')
        self.put('sys/module/input_boost_m30s/parameters/duration_ms', '150')
        self.run_backend()
        self.assertEqual(self.read('sys/module/input_boost_m30s/parameters/duration_ms'), '200')
        self.put('private/config', 'touch_duration_ms=999999\nthermal=off')
        self.run_backend()
        self.assertEqual(self.read('sys/module/input_boost_m30s/parameters/duration_ms'), '200')
        self.assertEqual(self.read('sys/class/thermal/thermal_zone0/mode'), 'enabled')

    def test_stale_lock_is_retired_on_restart(self):
        self.put('private/lock/pid', '99999999')
        self.assertIn('backend=m30s', self.run_backend())
        self.assertFalse((self.root / 'private/lock').exists())

    def test_state_symlink_replaced_without_modifying_target(self):
        other = self.root / 'other'; other.write_text('preserve')
        (self.app / 'state').symlink_to(other)
        self.run_backend()
        self.assertEqual(other.read_text(), 'preserve')
        self.assertFalse((self.app / 'state').is_symlink())

    def test_request_symlink_is_not_followed(self):
        other = self.root / 'other'; other.write_text('swappiness=0\n')
        (self.app / 'request').symlink_to(other)
        self.run_backend()
        self.assertEqual(self.read('proc/sys/vm/swappiness'), '130')

    def test_tablet_preset_and_both_clients_share_backend(self):
        tablet = self.root / 'app-tablet'; tablet.mkdir()
        (tablet / 'request').write_text('preset=battery\n')
        self.run_backend()
        state = (tablet / 'state').read_text()
        self.assertIn('preset=battery', state)
        self.assertIn('cap_big=1768000', state)
        self.assertIn('touch_enabled=1', state)
        state = self.run_backend()
        self.assertIn('perf_profile=battery', state)
        self.assertIn('big_freqs=2314000,1768000,936000', state)

    def test_tablet_app_alone_works_without_the_compact_app(self):
        import shutil
        shutil.rmtree(self.app)
        tablet = self.root / 'app-tablet'; tablet.mkdir()
        (tablet / 'request').write_text('touch_duration_ms=200\n')
        self.run_backend_tablet()
        self.assertIn('Applied touch_duration_ms', (tablet / 'state').read_text())
        self.assertEqual(self.read('sys/module/input_boost_m30s/parameters/duration_ms'), '200')

    def run_backend_tablet(self):
        result = subprocess.run(['sh', str(SCRIPT), '--test', str(self.root), '--once'], env=self.env,
                                capture_output=True, text=True, timeout=10)
        self.assertEqual(result.returncode, 0, result.stderr)

    def test_tablet_unsupported_extreme_rejected(self):
        before = self.read('sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq')
        self.assertIn('Rejected', self.run_backend('preset=extreme\n'))
        self.assertEqual(self.read('sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq'), before)
        self.assertEqual(self.read('sys/class/thermal/thermal_zone0/mode'), 'enabled')


if __name__ == '__main__':
    unittest.main()
