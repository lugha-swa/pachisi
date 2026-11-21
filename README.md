# Pachisi ya Swa

Pachisi kwa Android, imeandikwa kwa [Swa](https://github.com/lugha-swa/swa). Hakuna Java: `NativeActivity` ya Android hupakia `libswa.so` (kutoka `bin/swa --arm64-maktaba`) na kuita `anza`; ubao huchorwa moja kwa moja kwenye pikseli za dirisha.

Pachisi for Android, written in Swa. No Java: Android's `NativeActivity` loads `libswa.so` and calls `anza`; the board is drawn straight into the window's pixels.

```sh
SWA=/njia/ya/swa/bin/swa sh gharama/jenga-apk.sh weka   # jenga, saini, weka kwenye simu (adb)
```

Kufunga na kusaini APK kwa sasa hutumia `aapt2`, `jar`, `zipalign` na `apksigner` za Android SDK, mpaka zana za APK za Swa zikamilike.
