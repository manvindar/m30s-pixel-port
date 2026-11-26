"""Capability-driven backend behaviour on the mint kernel (4.14.113-a17-mint): the tables and lists below are the live values read from the
SM-M307F (cpufreq tables, noop/cfq on sda-sde, performance/schedutil, cubic/reno, Mali DVFS table, no input_boost_m30s module)."""
import os
import unittest

from test_backend import Fixture

LIVE_LITTLE = ('1742000 1638000 1534000 1456000 1326000 1222000 1118000 1053000 910000 806000 702000 598000 403000', '403000', '1742000')
LIVE_BIG = ('2314000 2210000 2184000 2080000 1976000 1898000 1768000 1664000 1508000 1456000 1352000 1248000 1144000 1040000 936000', '936000', '2314000')
P0 = 'sys/devices/system/cpu/cpufreq/policy0/'
P4 = 'sys/devices/system/cpu/cpufreq/policy4/'
GPU = 'sys/devices/platform/11500000.mali/'
DISKS = ['sd' + c for c in 'abcde']


def sched(disk):
    return 'sys/block/%s/queue/scheduler' % disk


def readahead(disk):
    return 'sys/block/%s/queue/read_ahead_kb' % disk


class MintKernel(Fixture):
    LITTLE, BIG, GOVERNORS, TOUCH = LIVE_LITTLE, LIVE_BIG, 'performance schedutil', False

    def state(self, request=None):
        text = self.run_backend(request)
        return dict(line.split('=', 1) for line in text.splitlines() if '=' in line)

    def assertUnchanged(self, request):
        before = self.snapshot()
        state = self.state(request)
        self.assertIn('Rejected', state['status'], request)
        self.assertEqual(before, self.snapshot(), request)


class AdvertisedLists(MintKernel):
    def test_lists_equal_the_live_kernel(self):
        s = self.state()
        self.assertEqual(s['governors'], 'performance,schedutil')
        self.assertEqual(s['io_scheds'], 'noop,cfq')
        self.assertEqual(s['io_sched'], 'cfq')
        self.assertEqual(s['io_devices'], ','.join(DISKS))
        self.assertEqual(s['tcp_ccs'], 'cubic,reno')
        self.assertEqual(s['tcp_cc'], 'cubic')
        self.assertEqual(s['little_freqs'], ','.join(LIVE_LITTLE[0].split()))
        self.assertEqual(s['big_freqs'], ','.join(LIVE_BIG[0].split()))
        self.assertEqual(s['gpu_freqs'], '1053000,949000,839000,764000,683000,572000,546000,455000,385000,338000,260000')
        self.assertEqual(s['gpu_max'], '-1')
        self.assertEqual(s['read_ahead_kb'], '128')

    def test_no_touch_boost_module_is_reported_and_not_invented(self):
        s = self.state()
        self.assertEqual(s['touch_supported'], '0')
        self.assertNotIn('touch_enabled', s)
        self.assertEqual(s['profiles'], 'battery,balanced')

    def test_listing_does_not_write_anything(self):
        before = self.snapshot()
        self.state()
        self.assertEqual(before, self.snapshot())

    def test_usb_disk_is_not_listed_or_tuned(self):
        self.add_disk('sdf', 'sys/devices/platform/usb/host1/target1:0:0/1:0:0:0/block/')
        self.assertEqual(self.state()['io_devices'], ','.join(DISKS))
        self.state('io_sched=noop\n')
        self.assertEqual(self.read(sched('sdf')), 'noop [cfq]')

    def test_governor_offered_by_one_cluster_only_is_not_offered(self):
        self.put(P4 + 'scaling_available_governors', 'performance schedutil conservative')
        self.assertEqual(self.state()['governors'], 'performance,schedutil')
        self.assertUnchanged('governor=conservative\n')

    def test_governor_offered_by_both_clusters_is_accepted(self):
        for p in (P0, P4):
            self.put(p + 'scaling_available_governors', 'performance schedutil conservative')
        s = self.state('governor=conservative\n')
        self.assertIn('Applied governor', s['status'])
        self.assertEqual(self.read(P0 + 'scaling_governor'), 'conservative')
        self.assertEqual(self.read(P4 + 'scaling_governor'), 'conservative')


class Governors(MintKernel):
    def test_performance_then_schedutil_on_both_clusters(self):
        self.state('governor=performance\n')
        self.assertEqual((self.read(P0 + 'scaling_governor'), self.read(P4 + 'scaling_governor')), ('performance', 'performance'))
        self.state('governor=schedutil\n')
        self.assertEqual((self.read(P0 + 'scaling_governor'), self.read(P4 + 'scaling_governor')), ('schedutil', 'schedutil'))

    def test_unlisted_or_malformed_governor_never_writes(self):
        for request in ('governor=schedplus\n', 'governor=interactive\n', 'governor=performance schedutil\n', 'governor=\n',
                        'governor=performance;touch /tmp/x\n', 'governor=$(id)\n'):
            with self.subTest(request=request):
                self.assertUnchanged(request)

    def test_failure_on_second_cluster_restores_the_first(self):
        if os.geteuid() == 0:
            self.skipTest('read-only files are writable for root')
        os.chmod(self.root / (P4 + 'scaling_governor'), 0o444)
        self.assertIn('Rejected', self.state('governor=performance\n')['status'])
        self.assertEqual(self.read(P0 + 'scaling_governor'), 'schedutil')


class IoScheduler(MintKernel):
    def test_noop_then_cfq_on_every_ufs_disk(self):
        s = self.state('io_sched=noop\n')
        self.assertIn('Applied io_sched', s['status'])
        self.assertEqual([self.read(sched(d)) for d in DISKS], ['noop'] * 5)
        (self.root / 'private/config').unlink()   # the saved request would be restored first, on a plain file that drops the list
        for d in DISKS:   # a real queue/scheduler file keeps offering both after a write; a plain file does not
            self.put(sched(d), '[noop] cfq')
        self.state('io_sched=cfq\n')
        self.assertEqual([self.read(sched(d)) for d in DISKS], ['cfq'] * 5)

    def test_schedulers_that_are_not_advertised_never_write(self):
        for request in ('io_sched=bfq\n', 'io_sched=deadline\n', 'io_sched=kyber\n', 'io_sched=none\n', 'io_sched=noop cfq\n',
                        'io_sched=cfq;touch /tmp/x\n', 'io_sched=../../noop\n', 'io_sched=\n'):
            with self.subTest(request=request):
                self.assertUnchanged(request)

    def test_list_is_what_every_disk_offers(self):
        self.put(sched('sdc'), 'noop [cfq] deadline')
        self.assertEqual(self.state()['io_scheds'], 'noop,cfq')
        self.assertUnchanged('io_sched=deadline\n')

    def test_scheduler_offered_by_all_disks_is_accepted(self):
        for d in DISKS:
            self.put(sched(d), 'noop [cfq] deadline')
        s = self.state('io_sched=deadline\n')
        self.assertIn('Applied io_sched', s['status'])
        self.assertEqual([self.read(sched(d)) for d in DISKS], ['deadline'] * 5)

    def test_failure_on_one_disk_restores_the_others(self):
        if os.geteuid() == 0:
            self.skipTest('read-only files are writable for root')
        os.chmod(self.root / sched('sdd'), 0o444)
        self.assertIn('Rejected', self.state('io_sched=noop\n')['status'])
        for d in ('sda', 'sdb', 'sdc', 'sde'):
            self.assertEqual(self.read(sched(d)), 'cfq')

    def test_disk_without_a_scheduler_node_is_not_tuned(self):
        os.remove(self.root / sched('sde'))
        self.assertEqual(self.state()['io_devices'], ','.join(DISKS[:4]))
        self.assertIn('Applied io_sched', self.state('io_sched=noop\n')['status'])
        self.assertEqual(self.read(readahead('sde')), '128')

    def test_missing_read_ahead_node_rejects_before_any_write(self):
        os.remove(self.root / readahead('sdc'))
        self.assertUnchanged('read_ahead_kb=256\n')

    def test_no_ufs_disk_hides_the_feature_and_rejects(self):
        for d in DISKS:
            (self.root / 'sys/block' / d).unlink()
        s = self.state()
        self.assertEqual(s['io_devices'], '')
        self.assertNotIn('io_scheds', s)
        self.assertUnchanged('io_sched=noop\n')
        self.assertUnchanged('read_ahead_kb=256\n')

    def test_read_ahead_offered_sizes_only(self):
        self.state('read_ahead_kb=256\n')
        self.assertEqual([self.read(readahead(d)) for d in DISKS], ['256'] * 5)
        for request in ('read_ahead_kb=300\n', 'read_ahead_kb=0\n', 'read_ahead_kb=4096\n', 'read_ahead_kb=-128\n', 'read_ahead_kb=128;x\n'):
            with self.subTest(request=request):
                self.assertUnchanged(request)

    def test_mixed_state_is_reported(self):
        self.put(readahead('sdb'), '256')
        self.assertEqual(self.state()['read_ahead_kb'], 'mixed')


class TcpCongestion(MintKernel):
    NODE = 'proc/sys/net/ipv4/tcp_congestion_control'

    def test_reno_then_cubic_with_readback(self):
        self.assertIn('Applied tcp_cc', self.state('tcp_cc=reno\n')['status'])
        self.assertEqual(self.read(self.NODE), 'reno')
        self.state('tcp_cc=cubic\n')
        self.assertEqual(self.read(self.NODE), 'cubic')

    def test_unavailable_algorithms_never_write(self):
        for request in ('tcp_cc=bbr\n', 'tcp_cc=bic\n', 'tcp_cc=cubic reno\n', 'tcp_cc=reno;touch /tmp/x\n', 'tcp_cc=\n', 'tcp_cc=../x\n'):
            with self.subTest(request=request):
                self.assertUnchanged(request)

    def test_a_loaded_module_appears_in_the_list(self):
        self.put('proc/sys/net/ipv4/tcp_available_congestion_control', 'cubic reno bbr')
        self.assertEqual(self.state()['tcp_ccs'], 'cubic,reno,bbr')
        self.assertIn('Applied tcp_cc', self.state('tcp_cc=bbr\n')['status'])


class GpuLimit(MintKernel):
    def test_limit_to_a_table_step_then_unlock(self):
        self.assertIn('Applied gpu_max', self.state('gpu_max=683000\n')['status'])
        self.assertEqual(self.read(GPU + 'dvfs_max_lock'), '683000')
        s = self.state('gpu_max=-1\n')
        self.assertEqual(self.read(GPU + 'dvfs_max_lock'), '0')      # on the phone writing -1 does nothing, writing 0 releases the lock
        self.assertEqual(s['gpu_max'], '-1')

    def test_values_outside_the_table_never_write(self):
        for request in ('gpu_max=900000\n', 'gpu_max=0\n', 'gpu_max=-2\n', 'gpu_max=683000;x\n', 'gpu_max=\n', 'gpu_freq=683000\n', 'oc_gpu=940000\n'):
            with self.subTest(request=request):
                self.assertUnchanged(request)

    def test_step_below_the_minimum_lock_is_rejected(self):
        self.put(GPU + 'dvfs_min_lock', '546000')
        self.assertUnchanged('gpu_max=455000\n')
        self.assertIn('Applied gpu_max', self.state('gpu_max=546000\n')['status'])

    def test_gpu_without_dvfs_table_has_no_limit_controls(self):
        os.remove(self.root / (GPU + 'dvfs_table'))
        s = self.state()
        self.assertNotIn('gpu_freqs', s)
        self.assertEqual(s['gpu_khz'], '683000')
        self.assertUnchanged('gpu_max=683000\n')

    def test_no_gpu_node_publishes_no_gpu_keys(self):
        for name in os.listdir(self.root / GPU):
            os.remove(self.root / GPU / name)
        s = self.state()
        self.assertNotIn('gpu_khz', s)
        self.assertNotIn('gpu_freqs', s)


class ProfilesFollowTheTables(MintKernel):
    def test_battery_uses_the_largest_step_within_77_percent(self):
        s = self.state('perf_profile=battery\n')
        self.assertIn('Applied battery', s['status'])
        self.assertEqual(self.read(P0 + 'scaling_max_freq'), '1326000')
        self.assertEqual(self.read(P4 + 'scaling_max_freq'), '1768000')
        self.assertEqual(s['profile_battery'], '1326000,1768000')
        self.assertEqual(s['profile_balanced'], '1742000,2314000')

    def test_balanced_is_the_table_maximum(self):
        self.state('perf_profile=battery\n')
        self.state('perf_profile=balanced\n')
        self.assertEqual((self.read(P0 + 'scaling_max_freq'), self.read(P4 + 'scaling_max_freq')), ('1742000', '2314000'))

    def test_responsive_needs_the_touch_boost_module(self):
        self.assertUnchanged('perf_profile=performance\n')
        self.assertUnchanged('preset=performance\n')

    def test_touch_requests_are_rejected_without_the_module(self):
        for request in ('touch_enabled=1\n', 'touch_duration_ms=200\n'):
            with self.subTest(request=request):
                self.assertUnchanged(request)

    def test_profile_steps_come_from_whatever_tables_the_kernel_has(self):
        self.put(P0 + 'scaling_available_frequencies', '2000000 1500000 1000000')
        self.put(P0 + 'scaling_max_freq', '2000000')
        self.put(P0 + 'scaling_min_freq', '1000000')
        self.put(P4 + 'scaling_available_frequencies', '3000000 2400000 1200000')
        self.put(P4 + 'scaling_max_freq', '3000000')
        self.put(P4 + 'scaling_min_freq', '1200000')
        s = self.state('perf_profile=battery\n')
        self.assertEqual(self.read(P0 + 'scaling_max_freq'), '1500000')   # 77 percent of 2.0 GHz is 1.54 GHz
        self.assertEqual(self.read(P4 + 'scaling_max_freq'), '1200000')   # 77 percent of 3.0 GHz is 2.31 GHz: the 2.4 GHz step is above it
        self.assertEqual(s['profile_battery'], '1500000,1200000')
        self.assertEqual(s['profile_balanced'], '2000000,3000000')

    def test_cap_values_must_be_table_steps(self):
        self.assertIn('Applied cap_big', self.state('cap_big=1976000\n')['status'])
        for request in ('cap_big=1999000\n', 'cap_little=1700000\n', 'cap_big=9999999\n'):
            with self.subTest(request=request):
                self.assertUnchanged(request)


class WithTouchModule(MintKernel):
    TOUCH = True

    def test_stock_style_kernel_keeps_all_three_profiles(self):
        s = self.state()
        self.assertEqual(s['touch_supported'], '1')
        self.assertEqual(s['profiles'], 'battery,balanced,performance')
        self.assertEqual(s['touch_duration_ms'], '150')
        s = self.state('perf_profile=performance\n')
        self.assertIn('Applied performance', s['status'])
        self.assertEqual(self.read('sys/module/input_boost_m30s/parameters/duration_ms'), '300')


class SavedConfiguration(MintKernel):
    def test_saved_values_are_revalidated_and_reapplied_at_start(self):
        self.state('tcp_cc=reno\n')
        self.state('io_sched=noop\n')
        self.put('proc/sys/net/ipv4/tcp_congestion_control', 'cubic')
        for d in DISKS:
            self.put(sched(d), 'noop [cfq]')
        self.state()
        self.assertEqual(self.read('proc/sys/net/ipv4/tcp_congestion_control'), 'reno')
        self.assertEqual([self.read(sched(d)) for d in DISKS], ['noop'] * 5)

    def test_saved_values_the_kernel_does_not_offer_are_not_applied(self):
        self.put('private/config', 'tcp_cc=bbr\nio_sched=bfq\ngovernor=schedplus\ngpu_max=900000\nread_ahead_kb=300\n')
        before = self.snapshot()
        s = self.state()
        self.assertEqual(before, self.snapshot())
        self.assertIn('Could not restore', s['status'])

    def test_saved_touch_values_are_skipped_quietly_on_a_kernel_without_the_module(self):
        self.put('private/config', 'touch_enabled=1\ntouch_duration_ms=200\ncap_big=1768000\n')
        s = self.state()
        self.assertNotIn('Could not restore', s['status'])
        self.assertEqual(self.read(P4 + 'scaling_max_freq'), '1768000')


if __name__ == '__main__':
    unittest.main()
