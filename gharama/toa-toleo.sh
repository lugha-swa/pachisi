#!/bin/sh
# toa-toleo.sh -- huchapisha toleo kwenye GitHub Releases ya lugha-swa/pachisi.
# Programu huangalia .../releases/latest/download/toleo.txt kila inapofunguliwa;
# likiwa kubwa kuliko TOLEO_LA_PROGRAMU yake, hutoa ofa ya kupakua Pachisi.apk.
#
#   SWA=/njia/ya/swa/bin/swa sh gharama/toa-toleo.sh
#
# Kabla: ongeza TOLEO_LA_PROGRAMU kwenye msimbo/mtandao.swa na uweke commit.
set -eu
sh gharama/jenga-apk.sh
TOLEO=$(sed -n 's/^n32 TOLEO_LA_PROGRAMU = \([0-9]*\);.*/\1/p' msimbo/mtandao.swa)
mkdir -p jengo/toleo
cp jengo/pachisi.apk jengo/toleo/Pachisi.apk
printf '%s\n' "$TOLEO" > jengo/toleo/toleo.txt
gh release create "v0.0.$TOLEO" jengo/toleo/Pachisi.apk jengo/toleo/toleo.txt \
    --repo lugha-swa/pachisi --title "Pachisi 0.0.$TOLEO" --notes-file hati/mabadiliko.md
rm -rf jengo/toleo
