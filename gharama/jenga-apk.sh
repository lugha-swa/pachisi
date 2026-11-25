#!/bin/sh
# jenga-apk.sh -- hujenga pachisi.apk. MSIMBO ni Swa pekee (bin/swa --arm64-maktaba);
# KUFUNGA na KUSAINI kwa muda hutumia aapt2, jar, zipalign na apksigner za
# Android SDK, mpaka zana za APK za Swa zikamilike. Hazitumiki kwenye CI ya Swa.
#   SWA=/njia/ya/swa/bin/swa sh gharama/jenga-apk.sh [weka]
set -eu
SWA=${SWA:-swa}
SDK=${ANDROID_HOME:-$HOME/Android/Sdk}
ZANA=$SDK/build-tools/36.0.0
JUKWAA=$SDK/platforms/android-36/android.jar

# toleo moja kwa programu na kwa mtandao (mteja hulinganisha na mwenyeji)
TOLEO=$(sed -n 's/^n32 TOLEO_LA_PROGRAMU = \([0-9]*\);.*/\1/p' msimbo/mtandao.swa)
[ -n "$TOLEO" ] || { echo "TOLEO_LA_PROGRAMU haipo kwenye msimbo/mtandao.swa" >&2; exit 1; }

rm -rf jengo/apk jengo/*.apk
mkdir -p jengo/apk/lib/arm64-v8a
"$SWA" --arm64-maktaba msimbo/pachisi.swa > jengo/apk/lib/arm64-v8a/libswa.so
"$ZANA/aapt2" link -o jengo/msingi.apk --manifest AndroidManifest.xml -I "$JUKWAA" -A assets -0 ttf \
    --version-code "$TOLEO" --version-name "0.0.$TOLEO"
jar -u -0 -M -f jengo/msingi.apk -C jengo/apk lib
"$ZANA/zipalign" -P 16 -f 4 jengo/msingi.apk jengo/imepangwa.apk
"$ZANA/apksigner" sign --ks .funguo/majaribio.keystore --ks-pass file:.funguo/neno \
    --ks-key-alias ludo --out jengo/pachisi.apk jengo/imepangwa.apk
"$ZANA/apksigner" verify jengo/pachisi.apk
rm -f jengo/msingi.apk jengo/imepangwa.apk
echo "jengo/pachisi.apk (toleo $TOLEO) iko tayari"
if [ "${1:-}" = "weka" ]; then adb install -r jengo/pachisi.apk; fi
