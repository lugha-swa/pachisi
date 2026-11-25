"""ikoni.py -- huchora ikoni ya Pachisi na picha za Google Play kutoka rangi za
mandhari ya Shanga (msimbo/skrini.swa). Endesha kutoka mzizi wa mradi:

    python3 gharama/ikoni.py

Matokeo: res/mipmap-xxxhdpi/ic_launcher_fg.png (ikoni ya rangi, 432 px),
res/mipmap-xxxhdpi/ic_launcher_mono.png (ikoni ya rangi moja kwa simu
zinazopaka ikoni rangi ya mandhari), hati/play/ikoni-512.png na
hati/play/picha-kuu.png (1024 x 500). Nembo ni ile ya chora_nembo: pauni nne
kwa msalaba, ushanga wa dhahabu katikati.

Ikoni ya simu haina usuli: safu ya nyuma ni wazi (res/values/rangi.xml), kwa
hiyo nembo hukaa yenyewe juu ya mandhari ya skrini ya nyumbani, giza au angavu.
Nembo hujaza eneo salama la ikoni inayobadilika (duara la 66% katikati).
"""
from PIL import Image, ImageDraw, ImageFont

USIKU = (16, 22, 34)
KADI = (25, 33, 50)
KRIMU = (244, 238, 226)
DHAHABU = (240, 184, 82)
WACHEZAJI = [(214, 72, 58), (34, 150, 100), (238, 170, 40), (60, 104, 200)]
K = 4  # kuchora kwa ukubwa mara 4, kisha kupunguza: kingo laini


def pauni(d, cx, cy, r, rangi):
    d.ellipse((cx - r, cy - r, cx + r, cy + r), fill=KRIMU)
    u = max(2, r // 6)
    d.ellipse((cx - r + u, cy - r + u, cx + r - u, cy + r - u), fill=rangi)


def nembo(d, cx, cy, r):
    # msalaba kama chora_nembo: juu kijani, kushoto nyekundu, kulia manjano, chini bluu
    p = r * 3 // 5
    pauni(d, cx, cy - r, p, WACHEZAJI[1])
    pauni(d, cx - r, cy, p, WACHEZAJI[0])
    pauni(d, cx + r, cy, p, WACHEZAJI[2])
    pauni(d, cx, cy + r, p, WACHEZAJI[3])
    b = r // 4
    d.ellipse((cx - b, cy - b, cx + b, cy + b), fill=DHAHABU)


def picha(upana, urefu, mandhari):
    im = Image.new("RGBA", (upana * K, urefu * K), mandhari)
    return im, ImageDraw.Draw(im)


def hifadhi(im, upana, urefu, njia):
    im.resize((upana, urefu), Image.LANCZOS).save(njia)
    print(njia)


# ikoni inayobadilika: nembo inafika ukingo wa eneo salama (nusu-kipenyo 142)
im, d = picha(432, 432, (0, 0, 0, 0))
nembo(d, 216 * K, 216 * K, 88 * K)
hifadhi(im, 432, 432, "res/mipmap-xxxhdpi/ic_launcher_fg.png")

# rangi moja: mfumo hutumia uwazi tu, kwa hiyo pauni ni pete (si diski) ili
# umbo libaki kusomeka bila rangi
im, d = picha(432, 432, (0, 0, 0, 0))
r, p = 88 * K, 88 * K * 3 // 5
for dx, dy in ((0, -r), (-r, 0), (r, 0), (0, r)):
    cx, cy = 216 * K + dx, 216 * K + dy
    d.ellipse((cx - p, cy - p, cx + p, cy + p), fill="white")
    n = p * 2 // 3
    d.ellipse((cx - n, cy - n, cx + n, cy + n), fill=(0, 0, 0, 0))
b = r // 4
d.ellipse((216 * K - b, 216 * K - b, 216 * K + b, 216 * K + b), fill="white")
hifadhi(im, 432, 432, "res/mipmap-xxxhdpi/ic_launcher_mono.png")

# ikoni ya duka (512, Play huzungusha pembe zenyewe)
im, d = picha(512, 512, USIKU)
nembo(d, 256 * K, 256 * K, 118 * K)
hifadhi(im, 512, 512, "hati/play/ikoni-512.png")

# picha kuu ya duka: nembo kushoto, jina na studio kulia
im, d = picha(1024, 500, USIKU)
d.rounded_rectangle((60 * K, 70 * K, 420 * K, 430 * K), radius=72 * K, fill=KADI)
nembo(d, 240 * K, 250 * K, 92 * K)
kichwa = ImageFont.truetype("assets/fonti/SourceSerif4-Semibold.ttf", 120 * K)
mwili = ImageFont.truetype("assets/fonti/Inter-Medium.ttf", 34 * K)
d.text((480 * K, 250 * K), "Pachisi", font=kichwa, fill=KRIMU, anchor="ls")
d.text((484 * K, 320 * K), "KAJARA STUDIO", font=mwili, fill=DHAHABU, anchor="ls")
y = 380 * K
for i, rangi in enumerate(WACHEZAJI * 3):
    x = (494 + i * 36) * K
    d.ellipse((x - 9 * K, y - 9 * K, x + 9 * K, y + 9 * K), fill=rangi)
hifadhi(im, 1024, 500, "hati/play/picha-kuu.png")
