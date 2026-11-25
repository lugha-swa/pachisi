#!/bin/sh
# jenga-apk.sh -- hujenga Pachisi. MSIMBO ni Swa pekee (bin/swa --arm64-maktaba);
# KUFUNGA na KUSAINI kwa muda hutumia aapt2, jar, zipalign, apksigner (na
# bundletool kwa Play) za Android SDK, mpaka zana za APK za Swa zikamilike.
#
#   SWA=/njia/ya/swa/bin/swa sh gharama/jenga-apk.sh [weka]
#       jengo/pachisi.apk -- nakala huru: husasishwa kutoka kwa mwenyeji wa
#       chumba na kutoka GitHub Releases
#   SWA=... BUNDLETOOL=/njia/bundletool.jar sh gharama/jenga-apk.sh play
#       jengo/pachisi.aab -- ya Google Play: bila kujisasisha (sera ya Play),
#       bila ruhusa ya REQUEST_INSTALL_PACKAGES
#
# Nakala zote husainiwa kwa ufunguo mmoja (.funguo), ili sasisho kutoka chanzo
# chochote likubalike juu ya nakala iliyopo (Play App Signing hupewa ufunguo
# huo huo; ona hati/play/MAANDALIZI.md).
set -eu
SWA=${SWA:-swa}
SDK=${ANDROID_HOME:-$HOME/Android/Sdk}
ZANA=$SDK/build-tools/36.0.0
JUKWAA=$SDK/platforms/android-36/android.jar
NAMNA=${1:-huru}

# toleo moja kwa programu na kwa mtandao (mteja hulinganisha na mwenyeji)
TOLEO=$(sed -n 's/^n32 TOLEO_LA_PROGRAMU = \([0-9]*\);.*/\1/p' msimbo/mtandao.swa)
[ -n "$TOLEO" ] || { echo "TOLEO_LA_PROGRAMU haipo kwenye msimbo/mtandao.swa" >&2; exit 1; }

rm -rf jengo/apk jengo/chanzo jengo/res.zip jengo/*.apk jengo/*.aab jengo/*.idsig jengo/base
mkdir -p jengo/apk/lib/arm64-v8a jengo/chanzo

# chanzo cha toleo hili: Play huzima kujisasisha kwenye msimbo na manifest
cp -r msimbo jengo/chanzo/msimbo
cp AndroidManifest.xml jengo/chanzo/AndroidManifest.xml
if [ "$NAMNA" = "play" ]; then
    sed -i 's/^n32 SASISHO_HURU = 1;/n32 SASISHO_HURU = 0;/' jengo/chanzo/msimbo/sasisho.swa
    grep -q '^n32 SASISHO_HURU = 0;' jengo/chanzo/msimbo/sasisho.swa
    sed -i '/<!-- huru: /,/REQUEST_INSTALL_PACKAGES/d; /DOWNLOAD_WITHOUT_NOTIFICATION/d' jengo/chanzo/AndroidManifest.xml
    ! grep -q 'REQUEST_INSTALL_PACKAGES' jengo/chanzo/AndroidManifest.xml
fi
(cd jengo/chanzo && "$SWA" --arm64-maktaba msimbo/pachisi.swa) > jengo/apk/lib/arm64-v8a/libswa.so

"$ZANA/aapt2" compile --dir res -o jengo/res.zip
UNGANISHA="--manifest jengo/chanzo/AndroidManifest.xml -I $JUKWAA -A assets -0 ttf
    --version-code $TOLEO --version-name 0.0.$TOLEO jengo/res.zip"

if [ "$NAMNA" = "play" ]; then
    : "${BUNDLETOOL:?weka BUNDLETOOL=/njia/ya/bundletool-all.jar}"
    # moduli ya msingi: aapt2 kwa umbo la proto, kisha mpangilio wa bundletool
    "$ZANA/aapt2" link --proto-format -o jengo/proto.apk $UNGANISHA
    mkdir -p jengo/base/manifest
    (cd jengo/base && unzip -q ../proto.apk)
    mv jengo/base/AndroidManifest.xml jengo/base/manifest/
    cp -r jengo/apk/lib jengo/base/lib
    (cd jengo/base && zip -q -r -0 ../base.zip .)
    java -jar "$BUNDLETOOL" build-bundle --modules=jengo/base.zip --output=jengo/pachisi.aab
    jarsigner -keystore .funguo/majaribio.keystore -storepass:file .funguo/neno \
        -sigalg SHA256withRSA -digestalg SHA-256 jengo/pachisi.aab ludo >/dev/null
    jarsigner -verify jengo/pachisi.aab >/dev/null
    rm -rf jengo/proto.apk jengo/base jengo/base.zip jengo/res.zip jengo/chanzo jengo/apk
    echo "jengo/pachisi.aab (toleo $TOLEO, Play) iko tayari"
    exit 0
fi

"$ZANA/aapt2" link -o jengo/msingi.apk $UNGANISHA
jar -u -0 -M -f jengo/msingi.apk -C jengo/apk lib
"$ZANA/zipalign" -P 16 -f 4 jengo/msingi.apk jengo/imepangwa.apk
"$ZANA/apksigner" sign --ks .funguo/majaribio.keystore --ks-pass file:.funguo/neno \
    --ks-key-alias ludo --v4-signing-enabled false --out jengo/pachisi.apk jengo/imepangwa.apk
"$ZANA/apksigner" verify jengo/pachisi.apk
rm -rf jengo/msingi.apk jengo/imepangwa.apk jengo/res.zip jengo/chanzo jengo/apk
echo "jengo/pachisi.apk (toleo $TOLEO) iko tayari"
if [ "$NAMNA" = "weka" ]; then adb install -r jengo/pachisi.apk; fi
