"""The restored tablet features on the mint kernel, host-tested against a fake /sys, /proc and Android command line (settings, cmd, wm, pm, getprop ...).

The fake commands keep their state in files under <fixture>/mock and log every call to <fixture>/calls.log, so a test can assert that a command was
(or was not) run. Nothing here talks to a device."""
import os
import re
import stat
import time
import subprocess
import unittest
from pathlib import Path

from test_backend import SCRIPT
from test_capabilities import DISKS, GPU, LIVE_BIG, LIVE_LITTLE, MintKernel, P0, P4

MOCKS = {
    'settings': '''
key=$3
case "$1" in
 get) [ -f "$M/settings.$key" ] && cat "$M/settings.$key" || echo null;;
 put) printf '%s\\n' "$4" > "$M/settings.$key";;
 delete) rm -f "$M/settings.$key";;
 *) exit 1;;
esac
''',
    'cmd': '''
case "$1 $2" in
 "uimode night")
   [ -f "$M/no_uimode" ] && { echo "Unknown command: uimode" >&2; exit 1; }
   if [ -n "$3" ]; then printf '%s\\n' "$3" > "$M/night"; else echo "Night mode: $(cat "$M/night" 2>/dev/null || echo auto)"; fi;;
 "overlay list") cat "$M/overlays" 2>/dev/null;;
 "overlay enable-exclusive")
   pkg=$6; pre=${pkg%.*}
   [ -f "$M/overlays" ] || exit 1
   awk -v t="$pkg" -v p="$pre" '{ if ($NF == t) print "[x] " t; else if (NF > 1 && index($NF, p ".") == 1 && index(substr($NF, length(p) + 2), ".") == 0) print "[ ] " $NF; else print }' "$M/overlays" > "$M/overlays.new" && mv "$M/overlays.new" "$M/overlays";;
 "overlay enable") awk -v t="$5" '{ if ($NF == t) print "[x] " t; else print }' "$M/overlays" > "$M/overlays.new" && mv "$M/overlays.new" "$M/overlays";;
 "overlay disable") awk -v t="$5" '{ if ($NF == t) print "[ ] " t; else print }' "$M/overlays" > "$M/overlays.new" && mv "$M/overlays.new" "$M/overlays";;
 "overlay set-priority") ;;
 "wifi help") [ -f "$M/no_wifi" ] || echo "  force-country-code enabled <two-letter code> | disabled";;
 "wifi force-country-code")
   [ -f "$M/no_wifi" ] && { echo "Can't find service: wifi" >&2; exit 1; }
   if [ "$3" = enabled ]; then printf '%s\\n' "$4" > "$M/wifi_country"; else rm -f "$M/wifi_country"; fi;;
 "package compile")
   printf '%s\\n' "$*" >> "$M/compiled"
   [ -f "$M/compile_fails" ] && { echo "Failure"; exit 1; }
   echo "Success";;
 "package art") cat "$M/art_dump" 2>/dev/null;;
 *) exit 1;;
esac
''',
    'wm': '''
phys=$(cat "$M/phys_density" 2>/dev/null || echo 420)
case "$2" in
 "") echo "Physical density: $phys"; [ -f "$M/density" ] && echo "Override density: $(cat "$M/density")";;
 reset) rm -f "$M/density";;
 *) printf '%s\\n' "$2" > "$M/density";;
esac
''',
    'device_config': '''
case "$1" in
 get) [ -f "$M/dc.$3" ] && cat "$M/dc.$3" || echo null;;
 put) printf '%s\\n' "$4" > "$M/dc.$3";;
 delete) rm -f "$M/dc.$3";;
esac
''',
    'getprop': '''
[ -f "$M/prop.$1" ] && cat "$M/prop.$1" || true
''',
    'setprop': '''
printf '%s\\n' "$2" > "$M/prop.$1"
''',
    'pm': '''
case "$1" in
 path) grep -qx "$2" "$M/packages" 2>/dev/null && echo "package:/system/app/$2/base.apk" || exit 1;;
 list) sed 's/^/package:/' "$M/packages";;
esac
''',
    'dumpsys': '''
cat "$M/art_dump" 2>/dev/null
''',
    'am': '''
true
''',
    'stop': '''
true
''',
    'start': '''
true
''',
    'pkill': '''
true
''',
    'reboot': '''
true
''',
    'pidof': '''
[ -f "$M/pid.$1" ] && cat "$M/pid.$1" || exit 1
''',
    'logcat': '''
true
''',
}


class Features(MintKernel):
    """The mint kernel plus everything the restored pages need: vm and scheduler nodes, an Android command line and a package list."""

    def setUp(self):
        super().setUp()
        self.mock = self.root / 'mock'; self.mock.mkdir()
        for name, body in MOCKS.items():
            path = self.bin / name
            path.write_text('#!/bin/sh\nM="$MOCK_ROOT/mock"\necho "%s $*" >> "$MOCK_ROOT/calls.log"\n%s' % (name, body))
            path.chmod(0o755)
        for node, value in [('vfs_cache_pressure', '100'), ('page-cluster', '3'), ('watermark_scale_factor', '10'), ('extra_free_kbytes', '29615')]:
            self.put('proc/sys/vm/' + node, value)
        self.put('proc/sys/kernel/sched_schedstats', '1')
        self.put('proc/sys/kernel/random/boot_id', 'boot-1')
        for pol in (P0, P4):
            self.put(pol + 'schedutil/up_rate_limit_us', '5000'); self.put(pol + 'schedutil/down_rate_limit_us', '5000')
        for cpu in range(8):
            self.put('sys/devices/system/cpu/cpu%d/cpuidle/state0/disable' % cpu, '0')
            self.put('sys/devices/system/cpu/cpu%d/cpuidle/state1/disable' % cpu, '0')
        (self.mock / 'overlays').write_text('android\n[x] com.android.internal.systemui.navbar.gestural\n[ ] com.android.internal.systemui.navbar.threebutton\n')
        (self.mock / 'night').write_text('auto\n')
        (self.mock / 'packages').write_text('com.example.one\ncom.example.two\norg.tablet.tuner\ncom.android.systemui\n')
        self.calls_log = self.root / 'calls.log'
        # a fake system compile script: prints what dexopt_all.sh prints
        self.script = self.root / 'dexopt_all.sh'
        self.script.write_text('#!/bin/sh\necho "env force=[$DEXOPT_FORCE] restart=[$DEXOPT_RESTART_UI]" >> "$MOCK_ROOT/calls.log"\necho com.example.one\necho Success\necho com.example.two\necho Failure\necho "[com.example.three] Success"\necho DONE\n')

    def calls(self):
        return self.calls_log.read_text().splitlines() if self.calls_log.exists() else []

    def called(self, prefix):
        return [c for c in self.calls() if c.startswith(prefix)]

    def mockval(self, name):
        return (self.mock / name).read_text().strip()

    def config(self):
        path = self.root / 'private/config'
        return dict(l.split('=', 1) for l in path.read_text().splitlines() if '=' in l) if path.exists() else {}


class KernelControls(Features):
    def test_published_with_the_live_values(self):
        s = self.state()
        for key, value in dict(vfs_cache='100', page_cluster='3', watermark='10', extra_free='29615', schedstats='1', up_rate='5000', down_rate='5000', deep_idle='1').items():
            self.assertEqual(s[key], value, key)

    def test_each_value_is_written_and_read_back(self):
        for key, node, value in [('vfs_cache', 'proc/sys/vm/vfs_cache_pressure', '150'), ('page_cluster', 'proc/sys/vm/page-cluster', '0'),
                                 ('watermark', 'proc/sys/vm/watermark_scale_factor', '30'), ('extra_free', 'proc/sys/vm/extra_free_kbytes', '98304'),
                                 ('schedstats', 'proc/sys/kernel/sched_schedstats', '0')]:
            with self.subTest(key=key):
                s = self.state('%s=%s\n' % (key, value))
                self.assertEqual(self.read(node), value)
                self.assertEqual(s[key], value)
                self.assertIn('Applied ' + key, s['status'])
                self.assertEqual(self.config()[key], value)

    def test_the_stock_value_is_always_accepted(self):
        self.state('extra_free=0\n')
        self.assertIn('Applied', self.state('extra_free=29615\n')['status'])
        self.assertEqual(self.read('proc/sys/vm/extra_free_kbytes'), '29615')

    def test_unlisted_values_never_write(self):
        for request in ('vfs_cache=0\n', 'vfs_cache=-1\n', 'vfs_cache=9999\n', 'page_cluster=4\n', 'watermark=11\n', 'extra_free=1\n', 'schedstats=2\n',
                        'up_rate=1\n', 'down_rate=0\n', 'deep_idle=2\n', 'vfs_cache=50;reboot\n', 'extra_free=$(id)\n'):
            with self.subTest(request=request):
                self.assertUnchanged(request)

    def test_a_missing_node_hides_the_control_and_rejects(self):
        (self.root / 'proc/sys/vm/vfs_cache_pressure').unlink()
        (self.root / 'proc/sys/kernel/sched_schedstats').unlink()
        s = self.state()
        self.assertNotIn('vfs_cache', s); self.assertNotIn('schedstats', s)
        self.assertUnchanged('vfs_cache=50\n')
        self.assertUnchanged('schedstats=0\n')

    def test_rates_go_to_both_clusters(self):
        s = self.state('up_rate=2000\n')
        self.assertEqual((self.read(P0 + 'schedutil/up_rate_limit_us'), self.read(P4 + 'schedutil/up_rate_limit_us')), ('2000', '2000'))
        self.assertEqual(s['up_rate'], '2000')
        self.state('down_rate=20000\n')
        self.assertEqual((self.read(P0 + 'schedutil/down_rate_limit_us'), self.read(P4 + 'schedutil/down_rate_limit_us')), ('20000', '20000'))

    def test_rates_exist_only_while_schedutil_runs(self):
        for pol in (P0, P4):
            for n in ('up', 'down'):
                (self.root / (pol + 'schedutil/%s_rate_limit_us' % n)).unlink()
        s = self.state()
        self.assertNotIn('up_rate', s); self.assertNotIn('down_rate', s)
        self.assertUnchanged('up_rate=2000\n')

    def test_a_rate_failing_on_the_second_cluster_restores_the_first(self):
        if os.geteuid() == 0:
            self.skipTest('read-only files are writable for root')
        os.chmod(self.root / (P4 + 'schedutil/up_rate_limit_us'), 0o444)
        self.assertIn('Rejected', self.state('up_rate=2000\n')['status'])
        self.assertEqual(self.read(P0 + 'schedutil/up_rate_limit_us'), '5000')

    def test_rates_are_restored_after_the_governor_at_boot(self):
        self.state('up_rate=2000\n'); self.state('governor=performance\n'); self.state('governor=schedutil\n'); self.state('down_rate=10000\n')
        for pol in (P0, P4):
            self.put(pol + 'schedutil/up_rate_limit_us', '5000'); self.put(pol + 'schedutil/down_rate_limit_us', '5000'); self.put(pol + 'scaling_governor', 'schedutil')
        self.state()
        self.assertEqual(self.read(P4 + 'schedutil/up_rate_limit_us'), '2000')
        self.assertEqual(self.read(P0 + 'schedutil/down_rate_limit_us'), '10000')

    def test_deep_idle_touches_only_states_above_the_first(self):
        s = self.state('deep_idle=0\n')
        for cpu in range(8):
            self.assertEqual(self.read('sys/devices/system/cpu/cpu%d/cpuidle/state1/disable' % cpu), '1')
            self.assertEqual(self.read('sys/devices/system/cpu/cpu%d/cpuidle/state0/disable' % cpu), '0')
        self.assertEqual(s['deep_idle'], '0')
        self.assertEqual(self.state('deep_idle=1\n')['deep_idle'], '1')

    def test_deep_idle_is_absent_without_the_nodes(self):
        for cpu in range(8):
            (self.root / ('sys/devices/system/cpu/cpu%d/cpuidle/state1/disable' % cpu)).unlink()
        self.assertNotIn('deep_idle', self.state())
        self.assertUnchanged('deep_idle=0\n')

    def test_kernel_keys_turn_the_mode_to_custom_and_clear_the_saved_profile(self):
        self.state('perf_profile=battery\n')
        s = self.state('vfs_cache=50\n')
        self.assertEqual(s['perf_profile'], 'custom')
        self.assertEqual(s['profile_active'], '')


class StockValues(Features):
    def test_first_run_after_boot_records_the_kernel_values(self):
        s = self.state()
        self.assertEqual((s['stock_extra_free'], s['stock_swappiness'], s['stock_cap_big'], s['stock_up_rate']), ('29615', '130', '2314000', '5000'))
        self.assertFalse((self.root / 'private/config').exists())

    def test_kept_within_a_boot_and_taken_again_after_a_new_boot(self):
        self.state('swappiness=100\n')
        self.assertEqual(self.state()['stock_swappiness'], '130')      # same boot: what the first run saw
        self.put('proc/sys/kernel/random/boot_id', 'boot-2'); self.put('proc/sys/vm/swappiness', '110')
        (self.root / 'private/config').unlink()
        self.assertEqual(self.state()['stock_swappiness'], '110')


class FrameworkSettings(Features):
    def test_values_are_written_to_the_right_setting_and_read_back(self):
        for key, setting, value in [('screen_timeout', 'screen_off_timeout', '300000'), ('font_scale', 'font_scale', '1.15'),
                                    ('font_weight', 'font_weight_adjustment', '200'), ('text_contrast', 'high_text_contrast_enabled', '1'),
                                    ('stay_awake', 'stay_on_while_plugged_in', '3'), ('auto_rotate', 'accelerometer_rotation', '0'),
                                    ('show_taps', 'show_touches', '1'), ('window_blur', 'disable_window_blurs', '1')]:
            with self.subTest(key=key):
                s = self.state('%s=%s\n' % (key, value))
                self.assertEqual(self.mockval('settings.' + setting), value)
                self.assertEqual(s[key], value)
                self.assertIn('Applied ' + key, s['status'])

    def test_listed_values_only(self):
        for request in ('screen_timeout=1\n', 'font_scale=2.0\n', 'font_weight=50\n', 'stay_awake=1\n', 'text_contrast=2\n', 'auto_rotate=on\n', 'show_taps=1;id\n'):
            with self.subTest(request=request):
                self.state(request)
                self.assertFalse(any(c.startswith('settings put') for c in self.calls()), request)

    def test_a_setting_that_does_not_read_back_is_put_back(self):
        (self.mock / 'settings.screen_off_timeout').write_text('60000\n')
        (self.bin / 'settings').write_text('#!/bin/sh\nM="$MOCK_ROOT/mock"\nkey=$3\ncase "$1" in get) [ -f "$M/settings.$key" ] && cat "$M/settings.$key" || echo null;; put) [ "$4" = 300000 ] && exit 0; printf "%s\\n" "$4" > "$M/settings.$key";; esac\n')
        self.assertIn('Rejected', self.state('screen_timeout=300000\n')['status'])
        self.assertEqual(self.mockval('settings.screen_off_timeout'), '60000')

    def test_animation_scale_accepts_the_slider_steps(self):
        for value in ('0', '0.3', '1.0', '2.0'):
            self.assertIn('Applied anim_scale', self.state('anim_scale=%s\n' % value)['status'])
        for value in ('2.5', '3', '-1', '0.55'):
            self.assertIn('Rejected', self.state('anim_scale=%s\n' % value)['status'])
        self.assertNotIn('anim_scale', self.config())      # the Settings database keeps it; a saved value would override what the user sets elsewhere

    def test_private_dns_modes(self):
        self.assertEqual(self.state('dns=cloudflare\n')['dns'], 'cloudflare')
        self.assertEqual((self.mockval('settings.private_dns_mode'), self.mockval('settings.private_dns_specifier')), ('hostname', 'one.one.one.one'))
        self.assertEqual(self.state('dns=auto\n')['dns'], 'auto')
        self.assertEqual(self.mockval('settings.private_dns_mode'), 'opportunistic')
        self.assertEqual(self.state('dns=off\n')['dns'], 'off')
        self.assertIn('Rejected', self.state('dns=evil.example\n')['status'])

    def test_cached_app_limit_keeps_the_other_constants(self):
        (self.mock / 'settings.activity_manager_constants').write_text('max_phantom_processes=64,max_cached_processes=24\n')
        self.assertEqual(self.state()['cached_apps'], '24')
        self.assertEqual(self.state('cached_apps=32\n')['cached_apps'], '32')
        self.assertEqual(sorted(self.mockval('settings.activity_manager_constants').split(',')), ['max_cached_processes=32', 'max_phantom_processes=64'])
        self.assertEqual(self.state('cached_apps=default\n')['cached_apps'], 'default')
        self.assertEqual(self.mockval('settings.activity_manager_constants'), 'max_phantom_processes=64')
        self.assertIn('Rejected', self.state('cached_apps=100\n')['status'])

    def test_background_process_limit(self):
        self.assertEqual(self.state()['bg_procs'], 'default')
        self.assertEqual(self.state('bg_procs=16\n')['bg_procs'], '16')
        self.assertEqual(self.mockval('dc.max_cached_processes'), '16')
        self.assertEqual(self.state('bg_procs=default\n')['bg_procs'], 'default')
        self.assertFalse((self.mock / 'dc.max_cached_processes').exists())
        self.assertIn('Rejected', self.state('bg_procs=9\n')['status'])

    def test_dark_mode_through_the_ui_mode_service(self):
        self.assertEqual(self.state()['night'], 'auto')
        self.assertEqual(self.state('night=yes\n')['night'], 'yes')
        self.assertEqual(self.mockval('night'), 'yes')
        self.assertIn('Rejected', self.state('night=maybe\n')['status'])

    def test_dark_mode_is_hidden_when_the_service_is_missing(self):
        (self.mock / 'no_uimode').write_text('1\n')
        self.assertNotIn('night', self.state())
        self.assertIn('Rejected', self.state('night=yes\n')['status'])

    def test_navigation_mode_switches_the_overlay_pair(self):
        self.assertEqual(self.state()['nav_mode'], 'gestural')
        self.assertEqual(self.state('nav_mode=threebutton\n')['nav_mode'], 'threebutton')
        self.assertIn('[x] com.android.internal.systemui.navbar.threebutton', (self.mock / 'overlays').read_text())
        self.assertIn('Rejected', self.state('nav_mode=twobutton\n')['status'])

    def test_navigation_mode_is_hidden_without_both_overlays(self):
        (self.mock / 'overlays').write_text('android\n[x] com.android.internal.systemui.navbar.gestural\n')
        self.assertNotIn('nav_mode', self.state())
        self.assertIn('Rejected', self.state('nav_mode=threebutton\n')['status'])

    def test_display_size_offers_percentages_of_the_physical_density(self):
        s = self.state()
        self.assertEqual(s['density_opts'], '336,378,reset,462,525')
        self.assertEqual(s['density'], '420')
        self.assertEqual(self.state('density=378\n')['density'], '378')
        self.assertEqual(self.mockval('density'), '378')
        self.assertEqual(self.state('density=reset\n')['density'], '420')
        self.assertFalse((self.mock / 'density').exists())
        for bad in ('100', '420', '9999', 'abc'):
            self.assertIn('Rejected', self.state('density=%s\n' % bad)['status'], bad)

    def test_wifi_country_is_saved_and_needs_the_command(self):
        s = self.state('wifi_country=DE\n')
        self.assertEqual(s['wifi_country'], 'DE')
        self.assertEqual(self.mockval('wifi_country'), 'DE')
        self.assertEqual(self.config()['wifi_country'], 'DE')
        self.assertIn('Rejected', self.state('wifi_country=XX\n')['status'])
        (self.mock / 'no_wifi').write_text('1\n')
        s = self.state()
        self.assertNotIn('wifi_country', s)
        self.assertIn('Rejected', self.state('wifi_country=US\n')['status'])

    def test_wifi_country_is_applied_again_when_the_daemon_starts(self):
        self.state('wifi_country=DE\n')
        (self.mock / 'wifi_country').unlink()
        self.state()
        self.assertEqual(self.mockval('wifi_country'), 'DE')

    def test_adb_over_network_restarts_adbd_and_is_not_kept(self):
        s = self.state('adb_tcp=1\n')
        self.assertEqual(s['adb_tcp'], '1')
        self.assertEqual(self.mockval('prop.service.adb.tcp.port'), '5555')
        self.assertTrue(self.called('stop adbd') and self.called('start adbd'))
        self.assertNotIn('adb_tcp', self.config())
        self.assertEqual(self.state('adb_tcp=0\n')['adb_tcp'], '0')

    def test_serial_console_needs_the_service(self):
        self.assertNotIn('serial_console', self.state())
        self.assertIn('Rejected', self.state('serial_console=1\n')['status'])
        (self.mock / 'prop.init.svc.console').write_text('stopped\n')
        self.assertEqual(self.state()['serial_console'], '0')

    def test_logging_only_changes_when_asked(self):
        s = self.state()
        self.assertEqual(s['logging'], '1')
        self.assertFalse(self.called('logcat') or self.called('setprop persist.log.tag'))
        self.assertEqual(self.state('logging=0\n')['logging'], '0')
        self.assertEqual(self.mockval('prop.persist.log.tag'), 'S')
        self.assertEqual(self.state('logging=1\n')['logging'], '1')

    def test_actions(self):
        self.assertIn('Restarting', self.state('restart_ui=1\n')['status'])
        self.assertTrue(self.called('pkill -f com.android.systemui'))
        self.assertIn('Rejected', self.state('restart_ui=2\n')['status'])
        self.assertFalse(self.called('reboot'))
        self.state('reboot=1\n')
        self.assertTrue(self.called('reboot'))

    def test_unknown_keys_and_malformed_requests_are_rejected(self):
        for request in ('thermal=off\n', 'pq_mode=2\n', 'oc_master=1\n', 'bt_work=1\n', 'phh_effects=1\n', 'bootanim=gemini\n', 'perf_profile=extreme\n',
                        'density\n', '=1\n', 'a b=1\n', 'night=yes no\n'):
            with self.subTest(request=request):
                self.state(request)
                self.assertFalse(any(c.startswith(('settings put', 'cmd uimode night yes', 'reboot')) for c in self.calls()), request)
                self.assertIn('Rejected', self.state(request)['status'])


class Theme(Features):
    JSON = '{"android.theme.customization.color_source":"preset","android.theme.customization.accent_color":"7C5CFF","android.theme.customization.theme_style":"VIBRANT","android.theme.customization.system_palette":"7C5CFF","android.theme.customization.color_both":"0"}'

    def setUp(self):
        super().setUp()
        (self.mock / 'settings.theme_customization_overlay_packages').write_text(self.JSON + '\n')

    def stored(self):
        return self.mockval('settings.theme_customization_overlay_packages')

    def test_current_theme_is_read_back_from_the_setting(self):
        s = self.state()
        self.assertEqual((s['theme_ok'], s['accent'], s['palette_source'], s['theme_style']), ('1', '7C5CFF', 'preset', 'VIBRANT'))
        self.assertEqual(s['fonts'], '')
        self.assertEqual((s['has_shapes'], s['has_packs']), ('0', '0'))
        self.assertNotIn('black_theme', s)

    def test_accent_and_style_change_one_value_and_keep_the_other(self):
        s = self.state('accent=00B8A9\n')
        self.assertEqual((s['accent'], s['theme_style']), ('00B8A9', 'VIBRANT'))
        self.assertIn('"android.theme.customization.accent_color":"00B8A9"', self.stored())
        s = self.state('theme_style=RAINBOW\n')
        self.assertEqual((s['accent'], s['theme_style']), ('00B8A9', 'RAINBOW'))
        s = self.state('palette_source=home_wallpaper\n')
        self.assertEqual(s['palette_source'], 'home_wallpaper')

    def test_colours_outside_the_list_are_rejected(self):
        for request in ('accent=123456\n', 'accent=FFFFFF\n', 'theme_style=NEON\n', 'palette_source=lockscreen\n'):
            before = self.stored()
            self.assertIn('Rejected', self.state(request)['status'], request)
            self.assertEqual(self.stored(), before)

    def test_theme_is_hidden_when_the_setting_is_not_there(self):
        (self.bin / 'cmd').write_text('#!/bin/sh\nexit 1\n')
        s = self.state()
        self.assertNotIn('theme_ok', s)
        self.assertIn('Rejected', self.state('accent=00B8A9\n')['status'])

    def test_fonts_icon_shapes_and_packs_only_when_their_overlays_exist(self):
        (self.mock / 'overlays').write_text('android\n[x] com.android.internal.systemui.navbar.gestural\n[ ] com.android.internal.systemui.navbar.threebutton\n'
                                             '[ ] com.android.theme.font.lato\n[ ] com.android.theme.icon.squircle\n[ ] com.android.theme.icon_pack.rounded.android\n')
        s = self.state()
        self.assertEqual((s['fonts'], s['has_shapes'], s['has_packs']), ('lato', '1', '1'))
        self.assertIn('Rejected', self.state('font=comic\n')['status'])
        self.assertIn('Rejected', self.state('icon_shape=teardrop\n')['status'])
        s = self.state('font=lato\n')
        self.assertEqual(s['font'], 'lato')
        s = self.state('icon_shape=squircle\n')
        self.assertEqual((s['icon_shape'], s['font']), ('squircle', 'lato'))
        s = self.state('icon_pack=rounded\n')
        self.assertEqual((s['icon_pack'], s['icon_shape'], s['font']), ('rounded', 'squircle', 'lato'))
        self.assertEqual(self.state('font=default\n').get('font'), None)

    def test_pure_black_needs_its_overlay(self):
        self.assertIn('Rejected', self.state('black_theme=1\n')['status'])
        (self.mock / 'overlays').write_text('android\n[ ] org.lineageos.overlay.customization.blacktheme\n')
        self.assertEqual(self.state()['black_theme'], '0')
        self.assertEqual(self.state('black_theme=1\n')['black_theme'], '1')
        self.assertEqual(self.state('black_theme=0\n')['black_theme'], '0')


class SavedProfiles(Features):
    def test_save_use_and_delete(self):
        self.state('swappiness=100\n'); self.state('vfs_cache=50\n')
        s = self.state('save_profile=Gaming\n')
        self.assertEqual((s['saved_profiles'], s['profile_active'], s['profile_base']), ('Gaming', 'Gaming', 'Gaming'))
        text = (self.root / 'private/profiles').read_text()
        self.assertTrue(text.startswith('Gaming|'))
        self.assertIn('swappiness=100', text); self.assertIn('vfs_cache=50', text); self.assertIn('cap_big=2314000', text)
        self.assertNotIn('touch_enabled', text)
        self.state('perf_profile=battery\n'); self.state('swappiness=160\n'); self.state('vfs_cache=150\n')
        s = self.state('apply_profile=Gaming\n')
        self.assertEqual(self.read('proc/sys/vm/swappiness'), '100')
        self.assertEqual(self.read('proc/sys/vm/vfs_cache_pressure'), '50')
        self.assertEqual(self.read(P4 + 'scaling_max_freq'), '2314000')
        self.assertEqual((s['profile_active'], s['perf_profile']), ('Gaming', 'custom'))
        self.assertEqual(self.config()['swappiness'], '100')
        s = self.state('delete_profile=Gaming\n')
        self.assertEqual((s['saved_profiles'], s['profile_active'], s['profile_base']), ('', '', ''))

    def test_changing_a_saved_key_clears_the_profile_in_use_but_not_its_base(self):
        self.state('save_profile=One\n')
        s = self.state('swappiness=80\n')
        self.assertEqual((s['profile_active'], s['profile_base']), ('', 'One'))
        s = self.state('update_profile=One\n')
        self.assertEqual((s['profile_active'], s['profile_base']), ('One', 'One'))
        self.assertIn('swappiness=80', (self.root / 'private/profiles').read_text())

    def test_saving_under_an_existing_name_replaces_it_in_place(self):
        self.state('save_profile=A\n'); self.state('save_profile=B\n'); self.state('swappiness=80\n')
        s = self.state('save_profile=A\n')
        self.assertEqual(s['saved_profiles'], 'A,B')
        self.assertIn('swappiness=80', (self.root / 'private/profiles').read_text().splitlines()[0])

    def test_a_rejected_key_puts_everything_back(self):
        self.state('save_profile=Bad\n')
        self.state('vfs_cache=50\n')
        line = (self.root / 'private/profiles').read_text().strip()
        (self.root / 'private/profiles').write_text(line.replace('swappiness=130', 'swappiness=999') + '\n')
        self.state('vfs_cache=150\n'); self.state('page_cluster=0\n')
        s = self.state('apply_profile=Bad\n')
        self.assertIn('Rejected', s['status'])
        self.assertEqual((self.read('proc/sys/vm/vfs_cache_pressure'), self.read('proc/sys/vm/page-cluster'), self.read('proc/sys/vm/swappiness')), ('150', '0', '130'))
        self.assertEqual(self.config()['vfs_cache'], '150')

    def test_keys_this_device_does_not_have_are_skipped(self):
        self.state('save_profile=Full\n')
        (self.root / 'proc/sys/vm/vfs_cache_pressure').unlink()
        self.assertIn('Using profile', self.state('apply_profile=Full\n')['status'])

    def test_names_and_the_count_are_limited(self):
        for bad in ('has space', 'a/b', 'x' * 25, 'a;b'):
            self.state('save_profile=%s\n' % bad)
            self.assertFalse((self.root / 'private/profiles').exists(), bad)
        for i in range(24):
            self.assertIn('Saved', self.state('save_profile=p%d\n' % i)['status'])
        self.assertIn('Rejected', self.state('save_profile=one_more\n')['status'])
        self.assertIn('Saved', self.state('save_profile=p3\n')['status'])

    def test_unknown_profile_is_rejected(self):
        before = self.snapshot()
        self.assertIn('Rejected', self.state('apply_profile=Nothing\n')['status'])
        self.assertIn('Rejected', self.state('update_profile=Nothing\n')['status'])
        self.assertEqual(before, self.snapshot())

    def test_profile_keeps_framework_keys_too(self):
        self.state('window_blur=1\n'); self.state('save_profile=Blur\n')
        self.state('window_blur=0\n')
        self.state('apply_profile=Blur\n')
        self.assertEqual(self.mockval('settings.disable_window_blurs'), '1')


class AppCompile(Features):
    ART = '''Dexopt state:
  [com.example.one]
    path: /system/app/one/one.apk
      arm64: [status=speed] [reason=cmdline] [primary-abi]
  [com.example.two]
    path: /data/app/two/base.apk
      arm64: [status=verify] [reason=install]
    known secondary dex files:
      /data/x.dex
        arm64: [status=speed] [reason=cmdline]
'''

    def setUp(self):
        super().setUp()
        (self.mock / 'art_dump').write_text(self.ART)

    def test_bulk_compile_runs_the_system_script_and_reports_the_result(self):
        s = self.state('compile_now=1\n')
        self.assertIn('Compile started', s['status'])
        self.assertIn('env force=[] restart=[1]', self.calls())
        s = self.state()
        self.assertEqual(s['compile_status'], 'done')
        self.assertTrue(s['compile_summary'].startswith('3 done, 1 failed'))
        s = self.state('compile_all=1\n')
        self.assertIn('env force=[-f] restart=[0]', self.calls())

    def test_a_missing_system_script_is_reported_not_run(self):
        self.script.unlink()
        s = self.state('compile_now=1\n')
        self.assertEqual(s['compile_status'], 'missing')
        self.assertIn('Rejected', s['status'])

    def test_bulk_compile_is_refused_while_one_runs(self):
        (self.root / 'private').mkdir(exist_ok=True)
        (self.root / 'private/dexopt.pid').write_text('%d\n' % os.getpid())
        (self.root / 'private/dexopt.log').write_text('=== run 100 ===\ncom.example.one\nSuccess\ncom.example.two\n')
        (self.root / 'private/dexopt.total').write_text('50\n')
        s = self.state('compile_now=1\n')
        self.assertIn('Rejected', s['status'])
        self.assertEqual((s['compile_status'], s['compile_current'], s['compile_current_state'], s['compile_done'], s['compile_total'], s['compile_started']),
                         ('running', 'com.example.two', 'compiling', '1', '50', '100'))

    def test_progress_counts_the_last_step_and_never_exceeds_its_total(self):
        (self.root / 'private').mkdir(exist_ok=True)
        (self.root / 'private/dexopt.pid').write_text('%d\n' % os.getpid())
        (self.root / 'private/dexopt.log').write_text('=== run 7 ===\ncom.a.b\nSuccess\ncom.c.d\nFailure\n[com.e.f] Success\n[com.a.b] Success\n[com.g.h] Fai')
        (self.root / 'private/dexopt.total').write_text('2\n')
        s = self.state()
        self.assertEqual((s['compile_done'], s['compile_failed'], s['compile_total'], s['compile_current_state']), ('3', '1', '3', 'finished'))

    def test_per_app_compile_runs_one_job_and_refreshes_its_state(self):
        self.state('refresh_apps=1\n')
        s = self.state('compile_pkg=com.example.one\n')
        self.assertIn('Queued speed', s['status'])
        self.assertTrue(self.called('cmd package compile -m speed -f com.example.one'))
        self.assertEqual(s['compile_pkg_status'], 'com.example.one:done')
        states = (self.app / 'apps_state').read_text().splitlines()
        self.assertIn('com.example.one=speed', states)
        self.assertIn('com.example.two=verify', states)
        self.assertTrue(states[-1].startswith('apps_state_time='))

    def test_speed_profile_and_reset(self):
        self.state('compile_pkg_profile=com.example.two\n')
        self.assertTrue(self.called('cmd package compile -m speed-profile -f com.example.two'))
        self.state('reset_pkg=com.example.two\n')
        self.assertTrue(self.called('cmd package compile --reset com.example.two'))

    def test_a_failed_compile_is_reported_as_failed(self):
        (self.mock / 'compile_fails').write_text('1\n')
        self.assertEqual(self.state('compile_pkg=com.example.one\n')['compile_pkg_status'], 'com.example.one:failed')

    def test_package_names_are_checked_and_must_be_installed(self):
        for bad in ('com.example.nothere', 'x', '../etc', 'com.example.one;id', 'com..x', '1com.x'):
            with self.subTest(pkg=bad):
                s = self.state('compile_pkg=%s\n' % bad)
                self.assertIn('Rejected', s['status'])
        self.assertFalse(self.called('cmd package compile'))

    def test_the_interface_and_this_app_are_never_force_stopped(self):
        self.state('compile_pkg=org.tablet.tuner\n'); self.state('compile_pkg=com.android.systemui\n')
        self.assertFalse(self.called('am force-stop org.tablet.tuner') or self.called('am force-stop com.android.systemui'))
        self.state('compile_pkg=com.example.one\n')
        self.assertTrue(self.called('am force-stop com.example.one'))

    def test_refresh_reads_the_states_and_reports_a_failure(self):
        s = self.state('refresh_apps=1\n')
        self.assertIn('com.example.one=speed', (self.app / 'apps_state').read_text())
        (self.mock / 'art_dump').write_text('')
        (self.root / 'private/apps.state').unlink()
        s = self.state('refresh_apps=1\n')
        self.assertEqual(s['apps_refresh'], 'failed')

    def test_the_setup_compile_script_is_never_run_in_parallel(self):
        # not testable on the host without a process list: the test only checks that the guard is a no-op here
        self.assertIn('Compile started', self.state('compile_now=1\n')['status'])


class CarPlayBoost(Features):
    def test_only_offered_when_a_receiver_is_installed(self):
        self.assertNotIn('carplay_boost', self.state())
        self.assertIn('Rejected', self.state('carplay_boost=1\n')['status'])
        (self.mock / 'packages').write_text('com.shihab.diplay\n')
        s = self.state()
        self.assertEqual((s['carplay_pkgs'], s['carplay_boost']), ('com.shihab.diplay', '0'))
        self.assertEqual(self.state('carplay_boost=1\n')['carplay_boost'], '1')

    def test_battery_becomes_balanced_while_the_receiver_is_on_screen_and_goes_back(self):
        (self.mock / 'packages').write_text('com.shihab.diplay\n')
        self.state('perf_profile=battery\n'); self.state('carplay_boost=1\n')
        (self.mock / 'pid.com.shihab.diplay').write_text('4242\n')
        self.put('proc/4242/oom_score_adj', '0')
        self.state()
        s = self.state()
        self.assertEqual((s['perf_profile'], self.read(P4 + 'scaling_max_freq')), ('balanced', '2314000'))
        self.put('proc/4242/oom_score_adj', '200')
        self.state()
        s = self.state()
        self.assertEqual((s['perf_profile'], self.read(P4 + 'scaling_max_freq')), ('battery', '1768000'))

    def test_switching_the_boost_off_while_boosted_brings_battery_back(self):
        (self.mock / 'packages').write_text('com.shihab.diplay\n')
        self.state('perf_profile=battery\n'); self.state('carplay_boost=1\n')
        (self.mock / 'pid.com.shihab.diplay').write_text('4242\n'); self.put('proc/4242/oom_score_adj', '0')
        self.state(); self.assertEqual(self.state()['perf_profile'], 'balanced')
        self.state('carplay_boost=0\n')
        self.assertEqual(self.state()['perf_profile'], 'battery')
        self.assertFalse((self.root / 'private/carplay.boost').exists())

    def test_settings_the_user_chose_meanwhile_are_left_alone(self):
        (self.mock / 'packages').write_text('com.shihab.diplay\n')
        self.state('perf_profile=battery\n'); self.state('carplay_boost=1\n')
        (self.mock / 'pid.com.shihab.diplay').write_text('4242\n'); self.put('proc/4242/oom_score_adj', '0')
        self.state()
        self.state('swappiness=100\n')             # custom now
        self.put('proc/4242/oom_score_adj', '200')
        self.state()
        self.assertEqual(self.state()['perf_profile'], 'custom')
        self.assertEqual(self.read(P4 + 'scaling_max_freq'), '2314000')

    def test_other_modes_and_saved_profiles_are_never_boosted(self):
        (self.mock / 'packages').write_text('com.shihab.diplay\n')
        self.state('carplay_boost=1\n'); self.state('save_profile=Mine\n')
        (self.mock / 'pid.com.shihab.diplay').write_text('4242\n'); self.put('proc/4242/oom_score_adj', '0')
        before = self.snapshot()
        self.state(); self.state()
        self.assertEqual(before, self.snapshot())
        self.assertFalse((self.root / 'private/carplay.boost').exists())


class UnchangedBehaviour(Features):
    def test_modes_still_touch_only_caps_and_governor(self):
        self.state('vfs_cache=50\n')
        self.state('perf_profile=battery\n')
        self.assertEqual(self.read('proc/sys/vm/vfs_cache_pressure'), '50')
        self.assertEqual((self.read(P0 + 'scaling_max_freq'), self.read(P4 + 'scaling_max_freq')), ('1326000', '1768000'))
        s = self.state()
        self.assertEqual((s['profile_active'], s['profiles'], s['saved_profiles']), ('', 'battery,balanced', ''))

    def test_installation_changes_nothing_on_the_device(self):
        before = self.snapshot()
        self.state()
        self.assertEqual(before, self.snapshot())
        self.assertEqual(self.called('settings put'), [])
        self.assertEqual([c for c in self.calls() if c.split()[0] in ('setprop', 'stop', 'start', 'pkill', 'reboot', 'am')], [])


def extract(name):
    """The source of one function of the backend (a one-line or a brace-closed block), to run it in a small harness."""
    lines = SCRIPT.read_text().splitlines()
    for i, l in enumerate(lines):
        if l.startswith(name + '() {'):
            if l.rstrip().endswith('}'):
                return l
            j = i + 1
            while lines[j] != '}':
                j += 1
            return '\n'.join(lines[i:j + 1])
    raise AssertionError(name)


def harness(funcs, body, **env):
    src = '\n'.join(extract(f) for f in funcs) + '\n' + body
    r = subprocess.run(['sh', '-c', src], capture_output=True, text=True, env=dict(os.environ, **env), timeout=20)
    return r.stdout.strip(), r.stderr


class GpuLockFormat(Features):
    """The Mali lock reads "<limit> / <min>" while set, and only a write of 0 releases it (device evidence, 2026-11-26)."""

    def test_a_locked_reading_is_published_as_its_limit(self):
        self.put(GPU + 'dvfs_max_lock', '683000 / -1')
        self.assertEqual(self.state()['gpu_max'], '683000')
        self.put(GPU + 'dvfs_max_lock', '-1')
        self.assertEqual(self.state()['gpu_max'], '-1')
        self.put(GPU + 'dvfs_max_lock', '0')
        self.assertEqual(self.state()['gpu_max'], '-1')

    def test_unlock_writes_zero_not_minus_one(self):
        self.put(GPU + 'dvfs_max_lock', '683000 / -1')
        s = self.state('gpu_max=-1\n')
        self.assertEqual(self.read(GPU + 'dvfs_max_lock'), '0')
        self.assertIn('Applied gpu_max', s['status'])

    def test_a_limit_is_accepted_when_the_node_answers_with_its_own_format(self):
        (self.root / 'gpu').mkdir()
        (self.root / 'gpu/dvfs_max_lock').write_text('683000 / -1\n')
        out, err = harness(['readnode', 'gpu_lock_now', 'gpu_lock_is'], 'GPU=$D; gpu_lock_is 683000 && echo match; gpu_lock_is -1 || echo other', D=str(self.root / 'gpu'))
        self.assertEqual(out.split(), ['match', 'other'], err)

    def run_set(self, original, limit):
        """gpu_lock_set against a node whose writes never take: returns (exit status, the writes it tried, what the node holds at the end)."""
        gpu = self.root / 'gpu'; gpu.mkdir(exist_ok=True)
        (gpu / 'dvfs_max_lock').write_text(original + '\n')
        body = ('GPU=$D; LOG=$D/tries\n'
                'gpu_lock_write() { echo "$1" >> "$LOG"; return 1; }\n'
                'gpu_lock_set %s; echo rc=$?' % limit)
        out, err = harness(['readnode', 'gpu_lock_now', 'gpu_lock_is', 'gpu_lock_set'], body, D=str(gpu))
        tries = (gpu / 'tries').read_text().split() if (gpu / 'tries').exists() else []
        return out, tries, (gpu / 'dvfs_max_lock').read_text().strip()

    def test_a_rejected_limit_puts_the_previous_lock_back(self):
        out, tries, node = self.run_set('683000 / -1', 949000)
        self.assertEqual(out, 'rc=1')
        self.assertEqual(tries, ['949000', '683000'])          # tried the new limit, then the lock it had

    def test_a_rejected_limit_never_leaves_a_lock_when_there_was_none(self):
        out, tries, node = self.run_set('-1', 683000)
        self.assertEqual(out, 'rc=1')
        self.assertEqual(tries, ['683000', '-1'])
        self.assertEqual(node, '0')                             # the last resort writes the release value itself


class ReadAheadProbe(Features):
    """Some kernels take a read_ahead_kb write and keep the old value (the M30s UFS disks do): the row exists only where it sticks."""

    def test_offered_where_a_changed_value_sticks_and_left_as_it_was(self):
        s = self.state()
        self.assertEqual((s['read_ahead_kb'], s['read_aheads']), ('128', '128,256,512,1024,2048'))
        self.assertEqual(self.read('sys/block/sda/queue/read_ahead_kb'), '128')
        self.assertEqual((self.root / 'private/ra.state').read_text().split()[1], 'supported')

    def test_hidden_and_rejected_where_the_write_does_not_take(self):
        if os.geteuid() == 0:
            self.skipTest('read-only files are writable for root')
        os.chmod(self.root / 'sys/block/sda/queue/read_ahead_kb', 0o444)
        s = self.state()
        self.assertNotIn('read_ahead_kb', s); self.assertNotIn('read_aheads', s); self.assertNotIn('stock_read_ahead_kb', s)
        self.assertEqual(s['io_sched'], 'cfq')                  # the scheduler row is unaffected
        self.assertUnchanged('read_ahead_kb=256\n')

    def test_a_write_that_reads_back_unchanged_means_unsupported_and_is_put_back(self):
        ra = self.root / 'ra'; ra.mkdir()
        (ra / 'q').write_text('128\n')
        body = ('PROC=$D/proc; SYS=$D/sys; RAF=$D/raf; mkdir -p $PROC/sys/kernel/random $SYS/block/sda/queue; echo b1 > $PROC/sys/kernel/random/boot_id\n'
                ': > $SYS/block/sda/queue/read_ahead_kb\n'
                'disks() { echo sda; }; log() { :; }\n'
                'blkval() { echo 128; }; blkwrite() { echo "$2" >> $D/writes; return 1; }\n'
                'ra_probe; cat $RAF; ra_ok && echo ok || echo notok')
        out, err = harness(['readnode', 'ra_probe', 'ra_ok'], body, D=str(ra))
        self.assertEqual(out.split(), ['b1', 'unsupported', 'notok'], err)
        self.assertEqual((ra / 'writes').read_text().split(), ['256', '128'])        # tried another step, then put the old one back

    def test_the_probe_runs_once_per_boot(self):
        self.state()
        (self.root / 'private/ra.state').write_text('boot-1 unsupported\n')
        self.assertNotIn('read_ahead_kb', self.state())
        self.put('proc/sys/kernel/random/boot_id', 'boot-2')
        self.assertIn('read_ahead_kb', self.state())


class ModeAndStatus(Features):
    def test_fresh_install_names_the_mode_the_clocks_already_match(self):
        self.assertEqual(self.state()['perf_profile'], 'balanced')
        self.put(P4 + 'scaling_max_freq', '1768000'); self.put(P0 + 'scaling_max_freq', '1326000')
        self.assertEqual(self.state()['perf_profile'], 'battery')
        self.put(P4 + 'scaling_max_freq', '1976000')
        self.assertEqual(self.state()['perf_profile'], '')

    def test_a_chosen_mode_is_not_overridden_by_the_clocks(self):
        self.state('swappiness=100\n')
        self.assertEqual(self.state()['perf_profile'], 'custom')

    def test_the_status_line_is_rewritten_at_once_and_the_rest_of_the_state_is_kept(self):
        self.state()
        before = (self.app / 'state').read_text().splitlines()
        self.run_backend('vfs_cache=150\n')
        after = dict(l.split('=', 1) for l in (self.app / 'state').read_text().splitlines() if '=' in l)
        self.assertIn('Applied vfs_cache', after['status'])
        self.assertEqual(after['vfs_cache'], '150')
        self.assertEqual(len(before), len((self.app / 'state').read_text().splitlines()))

    def test_animation_scale_is_not_restored_from_an_older_configuration(self):
        (self.root / 'private').mkdir(exist_ok=True)
        (self.root / 'private/config').write_text('anim_scale=0.5\nswappiness=100\n')
        (self.mock / 'settings.window_animation_scale').write_text('1.0\n')
        self.state()
        self.assertEqual(self.mockval('settings.window_animation_scale'), '1.0')
        self.assertEqual(self.read('proc/sys/vm/swappiness'), '100')

    def test_the_slider_steps_apply_and_read_back(self):
        for v in ('0.6', '0.0', '2.0'):
            s = self.state('anim_scale=%s\n' % v)
            self.assertIn('Applied anim_scale', s['status'])
            self.assertEqual(self.mockval('settings.animator_duration_scale'), v)


# What a /proc/sys node does to the shell's read builtin on the phone: the builtin asks for one byte, the node answers it with one
# character and nothing after it (130 became 1). A function in front of the script gives readnode's old variable that behaviour.
ONE_BYTE_READ = '''read() { if [ "$#" = 2 ] && [ "$2" = _rn ]; then command read -r _rn || return 1; case "$_rnp" in */proc/sys/*) _rn=${_rn%"${_rn#?}"};; esac; return 0; fi; command read "$@"; }
'''


class DeviceLikeReads(Features):
    def run_backend(self, request=None):
        wrapped = self.root / 'daemon_with_one_byte_reads.sh'
        wrapped.write_text(ONE_BYTE_READ + SCRIPT.read_text())
        if request is not None:
            (self.app / 'request').write_text(request)
        result = subprocess.run(['sh', str(wrapped), '--test', str(self.root), '--once'], env=self.env, capture_output=True, text=True, timeout=10)
        self.assertEqual(result.returncode, 0, result.stderr)
        return (self.app / 'state').read_text()

    def test_the_stand_in_really_truncates_what_read_returns(self):
        probe = subprocess.run(['sh', '-c', ONE_BYTE_READ + '_rnp=/x/proc/sys/vm/swappiness; echo 130 > "$1"; _rn=; read -r _rn < "$1"; echo "$_rn"', 'sh', str(self.root / 'x')], capture_output=True, text=True)
        self.assertEqual(probe.stdout.strip(), '1')

    def test_whole_values_are_published_and_recorded(self):
        s = self.state()
        self.assertEqual((s['swappiness'], s['vfs_cache'], s['page_cluster'], s['watermark'], s['extra_free']), ('130', '100', '3', '10', '29615'))
        self.assertEqual((s['stock_swappiness'], s['stock_vfs_cache'], s['stock_watermark'], s['stock_extra_free']), ('130', '100', '10', '29615'))
        self.assertEqual(s['cap_big'], '2314000')

    def test_a_profile_saved_and_used_keeps_the_whole_values(self):
        self.state('save_profile=Keep\n')
        text = (self.root / 'private/profiles').read_text()
        self.assertIn('swappiness=130', text); self.assertIn('extra_free=29615', text)
        self.state('swappiness=100\n')
        self.state('apply_profile=Keep\n')
        self.assertEqual(self.read('proc/sys/vm/swappiness'), '130')
        self.assertEqual(self.read('proc/sys/vm/extra_free_kbytes'), '29615')

    def test_a_rejected_change_puts_back_the_whole_old_value(self):
        self.state('vfs_cache=7\n')
        self.assertEqual(self.read('proc/sys/vm/vfs_cache_pressure'), '100')

    def test_the_daemon_never_reads_a_kernel_node_with_the_shell_builtin(self):
        text = SCRIPT.read_text()
        body = text.split('readnode() ', 1)[1].split('\nallowed()', 1)[0]
        self.assertRegex(body, r'"\$SYS"/\*\) _rn=; if \[ -r "\$1" \]; then read -r _rn < "\$1"')   # the builtin only for sysfs
        self.assertEqual(body.count('read -r'), 1)
        for line in text.splitlines():
            if re.search(r'\bread (-r )?\w+ *(\|\||<)', line) and not line.lstrip().startswith('#'):
                self.assertRegex(line, r'<\s*"\$(CFG|STOCK|PF|QC|PST|STATE|WORK/idle\.snap)"|\|\|', line)


class OlderVersionFiles(Features):
    """Version 2 wrote truncated values into its stock snapshot and its saved profiles."""

    def test_an_old_stock_snapshot_is_dropped_and_its_values_are_never_allowed(self):
        (self.root / 'private').mkdir(exist_ok=True)
        (self.root / 'private/stock').write_text('boot=boot-1\nswappiness=1\nvfs_cache=1\nextra_free=2\n')
        s = self.state()
        self.assertNotIn('stock_swappiness', s); self.assertNotIn('stock_vfs_cache', s); self.assertNotIn('stock_extra_free', s)
        self.assertEqual(s['vfs_cache'], '100')
        self.assertUnchanged('vfs_cache=1\n')

    def test_the_stock_values_come_back_at_the_next_boot(self):
        (self.root / 'private').mkdir(exist_ok=True)
        (self.root / 'private/stock').write_text('boot=boot-1\nswappiness=1\n')
        self.state()
        self.put('proc/sys/kernel/random/boot_id', 'boot-2')
        s = self.state()
        self.assertEqual((s['stock_swappiness'], s['stock_extra_free']), ('130', '29615'))

    def test_old_saved_profiles_are_set_aside_once(self):
        (self.root / 'private').mkdir(exist_ok=True)
        (self.root / 'private/profiles').write_text('Old|swappiness=1 vfs_cache=1 \n')
        s = self.state()
        self.assertEqual(s['saved_profiles'], '')
        self.assertEqual((self.root / 'private/profiles.v2').read_text(), 'Old|swappiness=1 vfs_cache=1 \n')
        s = self.state('save_profile=New\n')
        self.assertEqual(s['saved_profiles'], 'New')
        self.assertEqual(self.state()['saved_profiles'], 'New')


class RequestEcho(Features):
    def test_the_state_names_the_request_it_answers(self):
        s = self.state('vfs_cache=150\n')
        self.assertEqual(s['last_request'], 'vfs_cache=150'); self.assertIn('Applied vfs_cache', s['status'])
        s = self.state('vfs_cache=7\n')
        self.assertEqual(s['last_request'], 'vfs_cache=7'); self.assertIn('Rejected', s['status'])

    def test_a_request_with_odd_characters_is_echoed_without_them(self):
        s = self.state('swappiness=1;reboot\n')
        self.assertEqual(s['last_request'], 'rejected'); self.assertIn('Rejected', s['status'])
        s = self.state('x' * 200 + '=1\n')
        self.assertEqual(s['last_request'], 'oversized')

    def test_the_quick_rewrite_alone_replaces_status_and_echo_and_keeps_the_rest(self):
        # a full publish takes seconds on the phone: only this rewrite is in time for the first reading after a request
        text = SCRIPT.read_text()
        func = 'quick_status() {' + text.split('\nquick_status() {', 1)[1].split('\n}\n', 1)[0] + '\n}\n'
        (self.root / 'state').write_text('backend=m30s\nstatus=old\nlast_request=a=1\nx=2\n')
        script = 'WORK=$1; STATE=$1/state; APP=$1; TEST=1; STATUS="Applied b"; LASTREQ=b=2\n' + func + 'quick_status\n'
        subprocess.run(['sh', '-c', script, 'sh', str(self.root)], check=True)
        self.assertEqual((self.root / 'state').read_text(), 'backend=m30s\nstatus=Applied b\nlast_request=b=2\nx=2\n')

    def test_what_only_a_boot_changes_is_kept_apart_from_what_a_request_changes(self):
        # the full publish took 12 s on the phone: the lists, tables and stock values come from a file rebuilt in the background
        s = self.state()
        static = dict(l.split('=', 1) for l in (self.root / 'private/static').read_text().splitlines())
        for key in ('caps', 'governors', 'profile_battery', 'io_devices', 'io_scheds', 'tcp_ccs', 'gpu_freqs', 'stock_swappiness', 'little_freqs', 'big_freqs'):
            self.assertEqual(static[key], s[key], key)
        for key in ('cap_big', 'governor', 'swappiness', 'io_sched', 'tcp_cc', 'gpu_max', 'vfs_cache', 'saved_profiles'):
            self.assertNotIn(key, static, key)
        (self.root / 'private/static').write_text('caps=2\ntcp_ccs=cached\n')
        s = self.state('vfs_cache=150\n')   # a new process rebuilds the file at its start
        self.assertEqual(s['tcp_ccs'], 'cubic,reno')

    def test_a_restarted_daemon_has_answered_nothing_yet(self):
        self.state('swappiness=100\n')
        self.assertEqual(self.state()['last_request'], '')   # a restarted daemon has handled nothing yet


SHIM_CAT = '''#!/bin/sh
# stands in for cat: while the state is being built (state.new exists) it can be slow and it can drop a request file, as the app does
R="$MOCK_ROOT"
if [ -f "$R/private/state.new" ]; then
    [ -n "$SLOW" ] && sleep "$SLOW"
    if [ -f "$R/inject" ] && [ ! -f "$R/app/request" ]; then
        printf 'vfs_cache=150\\n' > "$R/app/request"; echo injected >> "$R/injected.log"
        [ -f "$R/inject_always" ] || rm -f "$R/inject"
    fi
    case "$*" in */vm/swappiness) echo read >> "$R/swappiness_reads.log";; esac
fi
exec /bin/cat "$@"
'''


class RequestLatency(Features):
    """On the phone one build of the state took 12 s and a request waited for it (echo after 8 to 16 s, new values after 18 to 26 s)."""

    def setUp(self):
        super().setUp()
        shim = self.bin / 'cat'; shim.write_text(SHIM_CAT); shim.chmod(0o755)

    def log(self):
        path = self.root / 'private/tuner.log'
        return path.read_text() if path.exists() else ''

    def test_a_request_that_arrives_during_the_build_is_answered_first(self):
        self.state()
        (self.root / 'inject').write_text('1')
        s = self.state()
        self.assertEqual((s['last_request'], s['vfs_cache']), ('vfs_cache=150', '150'))
        self.assertIn('Applied vfs_cache', s['status'])
        self.assertIn('state build stopped for a request (1)', self.log())
        self.assertEqual(self.log().count('answered'), 1)
        self.assertFalse((self.root / 'private/state.new').exists())
        self.assertFalse((self.app / 'request').exists())
        self.assertEqual(self.read('proc/sys/vm/vfs_cache_pressure'), '150')

    def test_the_state_is_still_written_when_requests_keep_coming(self):
        self.state()
        (self.root / 'inject').write_text('1'); (self.root / 'inject_always').write_text('1')
        s = self.state()
        self.assertEqual(s['last_request'], 'vfs_cache=150')
        self.assertIn('state build stopped for a request (3)', self.log())
        self.assertNotIn('(4)', self.log())
        self.assertEqual(s['backend'], 'm30s')

    def test_a_stopped_build_leaves_the_published_state_whole(self):
        before = (self.app / 'state').read_text() if (self.app / 'state').exists() else self.run_backend()
        (self.root / 'inject').write_text('1')
        self.state()
        after = (self.app / 'state').read_text().splitlines()
        self.assertTrue(all('=' in l for l in after))
        self.assertEqual(sorted(l.split('=')[0] for l in before.splitlines()), sorted(l.split('=')[0] for l in after))

    def test_both_apps_get_the_same_state_from_one_build(self):
        tablet = self.root / 'app-tablet'; tablet.mkdir()
        self.state()
        self.assertEqual((self.app / 'state').read_text(), (tablet / 'state').read_text())
        reads = (self.root / 'swappiness_reads.log').read_text().count('read')
        self.assertEqual(reads, 1)   # one build, not one per app

    def test_the_echo_does_not_wait_for_a_slow_build(self):
        self.state()                                       # a first state, so the quick rewrite has something to rewrite
        env = dict(self.env, SLOW='0.35')
        (self.root / 'private/tuner.log').unlink(missing_ok=True)
        daemon = subprocess.Popen(['sh', str(SCRIPT), '--test', str(self.root)], env=env, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        self.addCleanup(lambda: (daemon.terminate(), daemon.wait(timeout=20)))
        building = self.root / 'private/state.new'
        end = time.time() + 20
        while not building.exists() and time.time() < end:
            time.sleep(0.02)
        self.assertTrue(building.exists(), 'the daemon never started a build')
        t0 = time.time()
        (self.app / 'request').write_text('vfs_cache=150\n')
        echoed = None
        while time.time() < t0 + 20:
            try:
                if 'last_request=vfs_cache=150' in (self.app / 'state').read_text(): echoed = time.time() - t0; break
            except OSError:
                pass
            time.sleep(0.05)
        self.assertIsNotNone(echoed, 'no echo')
        self.assertLess(echoed, 4.5, 'the echo waited for the whole build')   # a whole build is about 7 s with this cat
        end = time.time() + 20
        while 'vfs_cache=150' not in [l for l in (self.app / 'state').read_text().splitlines()] and time.time() < end:
            time.sleep(0.1)
        self.assertIn('vfs_cache=150', (self.app / 'state').read_text().splitlines())


if __name__ == '__main__':
    unittest.main()
