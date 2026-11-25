#!/usr/bin/env python3
import ast
import os
import shutil
from pathlib import Path
import shlex
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[2]
SCRIPTS = ROOT / "tools/img/scripts"
DEXOPT = Path(os.environ.get("STARTUP_DEXOPT_TEST_SOURCE", str(SCRIPTS / "dexopt_all.sh")))

class StartupScriptsTest(unittest.TestCase):
    def run_script(self, source, extra_env=None):
        with tempfile.TemporaryDirectory() as temp:
            tmp = Path(temp)
            log = tmp / "commands"
            for name in ("pm", "cmd", "killall", "sleep", "settings", "appops", "renice", "pidof"):
                command = tmp / name
                command.write_text('#!/bin/sh\nprintf "%s" "' + name + '" >> "$STARTUP_COMMAND_LOG"\n'
                                   'for arg; do printf " <%s>" "$arg" >> "$STARTUP_COMMAND_LOG"; done\n'
                                   'printf "\\n" >> "$STARTUP_COMMAND_LOG"\n'
                                   '[ "$1" = get ] && echo "${SETUP_COMPLETE:-1}"\n'
                                   '[ "$0" = "' + str(tmp / "pidof") + '" ] && echo 123\n'
                                   'exit 0\n')
                command.chmod(0o755)
            env = dict(os.environ, PATH=str(tmp) + os.pathsep + os.environ["PATH"],
                       STARTUP_COMMAND_LOG=str(log))
            env.pop("DEXOPT_FORCE", None)
            env.pop("DEXOPT_RESTART_UI", None)
            env.update(extra_env or {})
            result = subprocess.run(["sh", str(source)], env=env, capture_output=True, text=True, timeout=15)
            self.assertEqual(result.returncode, 0, result.stderr)
            return log.read_text().splitlines() if log.exists() else []

    def test_automatic_compile_never_restarts_visible_ui(self):
        calls = self.run_script(DEXOPT, {"DEXOPT_FORCE": ""})
        self.assertFalse([x for x in calls if x.startswith("killall")], calls)
        compile_calls = [x for x in calls if x.startswith("cmd")]
        self.assertTrue(any("<package> <compile> <-m> <speed> <com.android.systemui>" in x
                            for x in compile_calls))
        self.assertTrue(any("<package> <compile> <-m> <speed> <-a>" in x
                            for x in compile_calls))

    def test_explicit_manual_compile_can_restart_ui_once(self):
        calls = self.run_script(DEXOPT, {"DEXOPT_FORCE": "", "DEXOPT_RESTART_UI": "1"})
        self.assertEqual([x for x in calls if x.startswith("killall")],
                         ["killall <com.android.systemui> <com.google.android.apps.nexuslauncher>"])

    def test_forced_compile_keeps_existing_no_restart_behavior(self):
        calls = self.run_script(DEXOPT, {"DEXOPT_RESTART_UI": "1"})
        self.assertFalse([x for x in calls if x.startswith("killall")])
        self.assertTrue(any("<-f>" in x for x in calls if x.startswith("cmd")))

    def run_firstboot(self, setup_complete, steps="120"):
        with tempfile.TemporaryDirectory() as d:
            calls = self.run_script(SCRIPTS / "firstboot_dexopt.sh", {
                "FIRSTBOOT_DIR": d, "CPUCTL_DEX2OAT": d, "DEXOPT_ALL": str(DEXOPT), "SETUP_COMPLETE": setup_complete, "SETUP_WAIT_STEPS": steps})
            self.assertTrue((Path(d) / ".dexopt_done").exists())
            self.shares = (Path(d) / "cpu.shares").read_text() if (Path(d) / "cpu.shares").exists() else None
            return calls, (Path(d) / "dexopt.log").read_text()

    def test_firstboot_compiles_at_once_when_setup_is_complete(self):
        calls, log = self.run_firstboot("1")
        self.assertIn("pass 1 (setup wait steps: 0)", log)
        self.assertEqual([x for x in calls if x.startswith("sleep")].count("sleep <10>"), 0)
        self.assertTrue(any("<com.android.systemui>" in x for x in calls if x.startswith("cmd")))

    def test_firstboot_waits_for_setup_then_gives_up_after_the_limit(self):
        calls, log = self.run_firstboot("0", steps="7")
        self.assertIn("pass 1 (setup wait steps: 7)", log)
        self.assertEqual(calls.count("sleep <10>"), 7)
        self.assertIn("sleep <2700>", calls)
        self.assertTrue(any(x.startswith("renice <-n> <19> <-p> <123>") for x in calls))

    def test_firstboot_restores_cpu_shares_after_each_pass(self):
        with tempfile.TemporaryDirectory() as d:
            (Path(d) / "cpu.shares").write_text("1024\n")
            self.run_script(SCRIPTS / "firstboot_dexopt.sh", {
                "FIRSTBOOT_DIR": d, "CPUCTL_DEX2OAT": d, "DEXOPT_ALL": str(DEXOPT), "SETUP_WAIT_STEPS": "1"})
            self.assertEqual((Path(d) / "cpu.shares").read_text(), "1024\n")

    def test_firstboot_keeps_location_grants_once(self):
        calls, _ = self.run_firstboot("1")
        self.assertEqual(len([x for x in calls if x.startswith("appops <reset>")]), 1)

    def test_sensor_init_passes_no_shell_variable_to_init(self):
        text = (ROOT / "tools/img/rc/06_nosensorhog.rc").read_text()
        service = next(line for line in text.splitlines() if line.startswith("service nosensorhog "))
        self.assertEqual(shlex.split(service),
                         ["service", "nosensorhog", "/system/bin/sh", "/system/bin/nosensorhog.sh"])
        self.assertIn("    user shell", text)
        self.assertIn("    group shell", text)
        self.assertIn("    seclabel u:r:shell:s0", text)

    def test_sensor_loop_keeps_exact_three_existing_components(self):
        calls = self.run_script(SCRIPTS / "nosensorhog.sh")
        self.assertEqual(calls, [
            "sleep <30>",
            "pm <disable> <com.google.android.gms/com.google.android.gms.personalsafety.service.PSAService>",
            "pm <disable> <com.google.android.gms/com.google.android.gms.personalsafety.service.PersonalSafetyService>",
            "pm <disable> <com.google.android.gms/com.google.android.gms.personalsafety.service.SndDetectionService>",
        ])

    def image_puts(self, text):
        puts = {}
        for node in ast.walk(ast.parse(text)):
            if (isinstance(node, ast.Call) and isinstance(node.func, ast.Name)
                    and node.func.id == "put" and len(node.args) >= 3
                    and isinstance(node.args[1], ast.Constant)):
                puts[node.args[1].value] = (ast.unparse(node.args[0]), ast.literal_eval(node.args[2]))
        return puts

    def assert_startup_wiring(self, text):
        puts = self.image_puts(text)
        self.assertEqual(puts["/system/bin/nosensorhog.sh"],
                         ("os.path.join(HERE, 'scripts', 'nosensorhog.sh')", "755"))
        self.assertEqual(puts["/system/bin/dexopt_all.sh"],
                         ("os.path.join(HERE, 'scripts', 'dexopt_all.sh')", "755"))
        self.assertEqual(puts["/system/bin/odex_bind.sh"],
                         ("os.path.join(HERE, 'scripts', 'odex_bind.sh')", "755"))
        self.assertEqual(puts["/system/bin/firstboot_dexopt.sh"],
                         ("os.path.join(HERE, 'scripts', 'firstboot_dexopt.sh')", "755"))

    def test_checked_in_builder_stages_local_startup_scripts(self):
        self.assert_startup_wiring((ROOT / "tools/img/build_a17.py").read_text())

    def test_generator_emits_actual_startup_wiring(self):
        tablet = Path(os.environ.get("STARTUP_TEST_TABLET_REPO",
                                     str(ROOT.parent / "tb-x606v-android17")))
        with tempfile.TemporaryDirectory() as temp:
            generator = Path(temp) / "make_build_a17.py"
            shutil.copyfile(ROOT / "tools/img/make_build_a17.py", generator)
            result = subprocess.run(["python3", str(generator), str(tablet)],
                                    capture_output=True, text=True, timeout=15)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assert_startup_wiring((Path(temp) / "build_a17.py").read_text())

    def test_odex_bind_skips_apps_with_baked_oat(self):
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            for app, baked in (("Baked", True), ("Plain", False)):
                (root / "app" / app / "oat" / "arm64").mkdir(parents=True)
                if baked: (root / "app" / app / "oat" / "arm64" / f"{app}.odex").write_text("x")
            text = (SCRIPTS / "odex_bind.sh").read_text().replace("/data/odex", str(root / "odex")).replace("/system/app/*", str(root / "app") + "/*")
            text = "\n".join(l for l in text.splitlines() if not l.startswith(("chown", "  chown")))
            text = text.replace("mount -o bind", "echo bind").replace("grep -q", "false && grep -q")
            out = subprocess.run(["sh", "-c", text], capture_output=True, text=True).stdout
            self.assertIn("Plain/oat", out); self.assertNotIn("Baked/oat", out)

    def test_manual_precompile_declares_explicit_ui_restart(self):
        text = (ROOT / "tools/img/rc/04_precompile.rc").read_text()
        service = next(line for line in text.splitlines() if line.startswith("service precompile "))
        self.assertIn("DEXOPT_RESTART_UI=1", service)
        self.assertIn("DEXOPT_FORCE=", service)

if __name__ == "__main__":
    unittest.main()
