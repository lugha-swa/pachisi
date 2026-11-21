#!/bin/sh
# jenga-apk.sh -- hujenga ludo.apk. MSIMBO ni Swa pekee (bin/swa --arm64-maktaba);
# KUFUNGA na KUSAINI kwa muda hutumia aapt2, jar, zipalign na apksigner za
# Android SDK, mpaka zana za APK za Swa zikamilike. Hazitumiki kwenye CI ya Swa.
#   SWA=/njia/ya/swa/bin/swa sh gharama/jenga-apk.sh [weka]
set -eu
SWA=${SWA:-swa}
SDK=${ANDROID_HOME:-$HOME/Android/Sdk}
ZANA=$SDK/build-tools/36.0.0
JUKWAA=$SDK/platforms/android-36/android.jar

rm -rf jengo/apk jengo/*.apk
mkdir -p jengo/apk/lib/arm64-v8a
"$SWA" --arm64-maktaba msimbo/ludo.swa > jengo/apk/lib/arm64-v8a/libswa.so
"$ZANA/aapt2" link -o jengo/msingi.apk --manifest AndroidManifest.xml -I "$JUKWAA"
jar -u -0 -M -f jengo/msingi.apk -C jengo/apk lib
"$ZANA/zipalign" -P 16 -f 4 jengo/msingi.apk jengo/imepangwa.apk
"$ZANA/apksigner" sign --ks .funguo/majaribio.keystore --ks-pass file:.funguo/neno \
    --ks-key-alias ludo --out jengo/ludo.apk jengo/imepangwa.apk
"$ZANA/apksigner" verify jengo/ludo.apk
echo "jengo/ludo.apk iko tayari"
if [ "${1:-}" = "weka" ]; then adb install -r jengo/ludo.apk; fi
