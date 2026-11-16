#!/bin/sh
# Signing identity is operator-supplied and stays outside the repository.
set -eu
ROOT=$(CDPATH= cd -- "$(dirname "$0")" && pwd)
OUT=$1; KEY=$2
FLAVOR=${M30S_TUNER_FLAVOR:-m30s}
PACKAGE=org/m30s/tuner; APK_NAME=RomTuner-M30s.apk
if [ "$FLAVOR" = tablet ]; then ROOT=$ROOT/tablet; PACKAGE=org/tablet/tuner; APK_NAME=RomTuner-Tablet-M30s.apk; fi
SDK=${ANDROID_HOME:-$HOME/Library/Android/sdk}; BT=${BUILD_TOOLS:-$SDK/build-tools/35.0.0}; PL=$SDK/platforms/android-34/android.jar
mkdir -p "$OUT/classes" "$OUT/gen"
"$BT/aapt2" compile --dir "$ROOT/res" -o "$OUT/res.zip"
"$BT/aapt2" link -o "$OUT/base.apk" -I "$PL" --manifest "$ROOT/AndroidManifest.xml" --java "$OUT/gen" --min-sdk-version 29 --target-sdk-version 34 "$OUT/res.zip"
javac --release 8 -classpath "$PL" -d "$OUT/classes" "$ROOT"/src/"$PACKAGE"/*.java "$OUT/gen/$PACKAGE/R.java"
"$BT/d8" --lib "$PL" --min-api 29 --output "$OUT" "$OUT"/classes/"$PACKAGE"/*.class
cp "$OUT/base.apk" "$OUT/unsigned.apk"
(cd "$OUT" && zip -q unsigned.apk classes.dex)
"$BT/zipalign" -f 4 "$OUT/unsigned.apk" "$OUT/aligned.apk"
if [ -d "$KEY" ]; then
    "$BT/apksigner" sign --key "$KEY/platform.pk8" --cert "$KEY/platform.x509.pem" --out "$OUT/$APK_NAME" "$OUT/aligned.apk"
else
    "$BT/apksigner" sign --ks "$KEY" --ks-pass env:M30S_TUNER_KEY_PASSWORD --out "$OUT/$APK_NAME" "$OUT/aligned.apk"
fi
"$BT/apksigner" verify "$OUT/$APK_NAME"
