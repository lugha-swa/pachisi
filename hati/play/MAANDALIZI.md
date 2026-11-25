# Maandalizi ya Google Play

Kila kinachoweza kufanywa kabla ya kununua akaunti ya Play Console kimo hapa.
Baada ya kununua, hatua zilizobaki ni za kubandika na kupakia tu.

## 1. Kilicho tayari kwenye mradi

| Kitu | Mahali |
|---|---|
| Toleo la Play (bila kujisasisha, bila `REQUEST_INSTALL_PACKAGES`) | `sh gharama/jenga-apk.sh play` -> `jengo/pachisi.aab` |
| Ikoni ya programu (inayobadilika, pamoja na monochrome) | `res/` |
| Ikoni ya duka 512 x 512 | `hati/play/ikoni-512.png` |
| Picha kuu 1024 x 500 | `hati/play/picha-kuu.png` |
| Sera ya faragha (lugha mbili) | `hati/faragha.md` |
| targetSdk 36, arm64 pekee, kurasa za 16 KB | `AndroidManifest.xml`, `libswa.so` (LOAD align 0x10000) |

Kujenga `.aab` kunahitaji bundletool (haijasakinishwa bado):

    # https://github.com/google/bundletool/releases -- bundletool-all-1.17.2.jar
    SWA=~/Projects/compilers/swa-pamoja/bin/swa \
    BUNDLETOOL=~/.local/share/bundletool/bundletool-all-1.17.2.jar \
    sh gharama/jenga-apk.sh play

Bado kinahitajika: picha za skrini 2 hadi 8 kutoka kwenye simu (pembeni 1080 x
1920 au zaidi): menyu, mchezo, chumba cha Wi-Fi, matokeo; giza na angavu.

## 2. Uamuzi wa kudumu kabla ya kupakia mara ya kwanza

- **Jina la kifurushi**: `com.kajara.pachisi` (limechaguliwa 2026-11-25).
  Haliwezi kubadilishwa baada ya kupakia; likibadilishwa, nakala zilizopo huwa
  programu nyingine. Jina la mchezo dukani na kwenye simu linabaki "Pachisi"
  (jina la jadi lisilo na mmiliki; "Parcheesi" ni alama ya biashara ya Hasbro).
- **Ufunguo**: `.funguo/majaribio.keystore` (RSA 2048, hadi 2054, alias `ludo`)
  ndio ufunguo wa programu kwa nakala zote. Kwenye Play App Signing chagua
  "Use existing app signing key" na upakie ufunguo huu kwa zana ya PEPK
  inayotolewa na Console. Hivyo nakala ya Play, ya GitHub na ya mwenyeji
  husasishana bila kufuta programu. Hifadhi nakala ya `.funguo/` nje ya
  kompyuta hii: ukipotea, kila mtu atalazimika kufuta na kusakinisha upya.
- **Kujisasisha**: sera ya Play inakataza programu ya Play kujisasisha nje ya
  Play, kwa hiyo toleo la Play huzima sasisho la mwenyeji na la GitHub
  (`SASISHO_HURU = 0`). Mchezo, vyumba na sauti hubaki sawa.

## 3. Hatua za Console (baada ya kununua, USD 25 mara moja)

1. Thibitisha utambulisho (kitambulisho cha serikali; akaunti ya mtu binafsi).
2. Create app: jina "Pachisi", lugha ya msingi English (US), Game, Free.
3. **Majaribio ya lazima kwa akaunti mpya ya mtu binafsi**: closed testing
   yenye wanaojaribu angalau 12 kwa siku 14 mfululizo kabla ya kuomba
   production. Marafiki wanaocheza nawe wanafaa: ongeza barua pepe zao
   kwenye orodha ya wanaojaribu.
4. Jaza fomu za App content kwa majibu ya sehemu ya 5 na 6.
5. Store listing: maandishi ya sehemu ya 4, ikoni, picha kuu, picha za skrini.
6. Pakia `jengo/pachisi.aab` kwenye closed testing track.

## 4. Maandishi ya duka

**English (US)**

- Title (30): `Pachisi - Kajara Studio`
- Short description (80): `The classic race board game. Play the computer, pass the phone, or Wi-Fi rooms.`
- Full description:

  > Pachisi is the classic cross-and-circle race game, rebuilt from scratch by
  > Kajara Studio. Roll two dice, bring your four pawns out of the nest, race
  > them around the board and home before everyone else.
  >
  > - Play against the computer, pass one phone around, or host a Wi-Fi room
  >   for up to four friends: no internet needed, a hotspot is enough.
  > - Voice chat inside the room, straight from phone to phone.
  > - The game goes on after the first winner, so every place from 1st to 4th
  >   is played out. Live progress in percent for every player.
  > - House rules: enter on 5 or 6, capture and home bonuses, blockades, safe
  >   squares, the triple-doubles penalty, 2 to 4 pawns each.
  > - Pick your colour. Dark and light themes that follow your phone.
  > - English and Kiswahili.
  > - No ads, no accounts, no tracking. Your records stay on your phone.

**Kiswahili** (ongeza kama tafsiri kwenye Console)

- Jina: `Pachisi - Kajara Studio`
- Maelezo mafupi: `Mchezo wa jadi wa mbio za ubaoni. Cheza na kompyuta, simu moja au chumba cha Wi-Fi.`
- Maelezo kamili:

  > Pachisi ni mchezo wa jadi wa mbio za msalaba, uliojengwa upya na Kajara
  > Studio. Rusha kete mbili, toa pauni zako nne kiotani, zikimbize kuzunguka
  > ubao na kuzifikisha nyumbani kabla ya wengine.
  >
  > - Cheza na kompyuta, pasianeni simu moja, au unda chumba cha Wi-Fi kwa
  >   marafiki hadi wanne: hakuna intaneti, hotspot inatosha.
  > - Ongeeni kwa sauti ndani ya chumba, moja kwa moja simu hadi simu.
  > - Mchezo huendelea baada ya mshindi wa kwanza: kila nafasi kutoka ya 1
  >   hadi ya 4 huchezwa. Asilimia ya safari ya kila mchezaji.
  > - Sheria za nyumbani: kuingia kwa 5 au 6, zawadi za kula na kufika,
  >   vizuizi, seli salama, adhabu ya pacha tatu, pauni 2 hadi 4.
  > - Chagua rangi yako. Mandhari ya giza na angavu kufuata simu yako.
  > - Kiswahili na Kiingereza.
  > - Hakuna matangazo, akaunti wala ufuatiliaji. Rekodi zako hubaki kwenye simu.

- Category: Board. Tags: Board games, Classic, Multiplayer.
- Contact email: barua pepe ya msanidi (itaonekana hadharani; tumia ya studio).
- Privacy policy URL: `https://github.com/lugha-swa/pachisi/blob/main/hati/faragha.md`
  (repo ikiwa ya umma).

## 5. Data safety

- Data inayotumwa kwa msanidi au seva: **hakuna**.
- **Audio -- Voice or sound recordings**: inahamishwa kutoka kwenye simu (simu
  hadi simu ndani ya chumba), kwa hiyo jibu **Collected: Yes**, **Shared: No**,
  **Processed ephemerally: Yes**, **Required: No (optional)**, **Purpose: App
  functionality**.
- Jina la mchezaji linatumwa kwa wachezaji wa chumba tu: **Personal info -- Name:
  Collected: Yes, ephemeral, optional, App functionality**.
- Encrypted in transit: **No** (mtandao wa ndani, TCP bila TLS). Ni jibu la
  kweli; usichague Yes.
- Users can request deletion: hakuna data kwa msanidi; data ya simu hufutika
  programu ikifutwa.

## 6. Content rating (IARC) na mengineyo

- Vurugu, lugha chafu, ngono, dawa: hapana.
- Kamari halisi au ya kuigiza: hapana (kete ni sehemu ya mchezo wa ubao,
  hakuna dau wala zawadi).
- Watumiaji huwasiliana: **ndiyo** (sauti kati ya wachezaji wa chumba kimoja
  cha Wi-Fi). Hakuna kushiriki eneo.
- Target audience: **13+**. Chini ya 13 kungeleta masharti ya Families
  ambayo hayahitajiki.
- Ads: hapana. In-app purchases: hapana.
- Ruhusa nyeti: `RECORD_AUDIO` -- elezea "voice chat inside local Wi-Fi rooms,
  only while the player turns the microphone on".
