# Android 17 experimental dirty-flash smoke test

Candidate: Actions run **43807393475**, source
`9597e5744b2fa5761e6c9a50a7593b147b0219d1`, unpublished experimental mode.
Full system readback matched
`e2f65fbceee11413d143cb7c09cb3d9691bc57bc2b19302cc4b8405a96eeb4a6`.
Boot and vendor whole-partition hashes matched their prewrite values.
The operation wrote only system; it did not wipe userdata or media.

| Check | Observed result |
| --- | --- |
| Android startup | Android 17, SDK 37, `sys.boot_completed=1` |
| Launcher | Home rendered and received focus |
| Settings | Opened and rendered; injected swipe scrolled the list |
| Browser | Chrome loaded and rendered `https://example.com` |
| Camera | AOSP Camera opened, camera service connected, preview rendered |
| Wi-Fi | Connected and Android reported validated internet |
| Bluetooth | ON, zero recorded Bluetooth crashes; pairing untested |
| Audio | Audio service and audio server running; audible playback untested |
| Sensors | Vendor sensor inventory available; accuracy untested |
| Battery | 89%, USB charging at observation |
| Telephony | Both SIM slots reported ABSENT; calls/data untested |
| Touch | Direct touch mapper present; injected UI navigation passed; physical touch unconfirmed |
| Stability during smoke | Same system-server PID remained alive; no new fatal crashes |

## Unresolved startup failure

The first system server crashed once during Package Manager initialization:

```text
FATAL EXCEPTION IN SYSTEM PROCESS: PackageManager
NullPointerException: IPackageManager.isProtectedBroadcast(String) on null
BroadcastController.broadcastIntentLockedTraced
BroadcastHelper.lambda$sendPreferredActivityChangedBroadcast$0
```

The replacement system server reached Home and stayed alive through the smoke
checks. This recovery does not establish that the startup race is fixed.
The installed `BroadcastHelper` posts the preferred-activity broadcast to the
Package Manager handler; its runnable calls ActivityManagerInternal.broadcastIntent
without a readiness guard. A framework fix needs to preserve post-startup delivery,
user targeting, registered-receiver flags and protected-broadcast checks. None of
those checks was bypassed or weakened in this trial.

REA's Android-method provider rejected the services JAR because it accepts
standalone APKs. Existing Android SDK `dexdump` was used for the exact installed
JAR instead. Private retained logs, screenshots, installed JAR identity and the
operator receipts remain in `dirty-flash-device/smoke-20261116`; account names,
network identifiers and device serial are omitted from this public note.

## Recovery fix verified by this trial

The first write lost USB connectivity. The guarded retry revalidated candidate,
rollback, recovery geometry, boot and vendor, then rewrote the complete system
from byte zero and passed full readback. `tools/flash` retains this behavior with
explicit operator-supplied device/provider identities and regression checks.
Rollback excludes the gzip carrier's trailing `dd` statistics and verifies the
reconstructed raw content, including the exact recovery prefix overlay.

This is a bounded smoke result, not whole-ROM compatibility or long-term runtime
acceptance. Ten static caller slices remain conditional and 27 remain unreviewed.
