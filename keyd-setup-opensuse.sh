#!/bin/bash

sudo zypper in -y keyd

systemctl enable --now keyd.service

sudo mkdir -p /etc/keyd/

if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
echo "[ids]

*

[main]

leftalt = layer(alt)

[alt]

a = macro(C-S-u 0101 space)
d = macro(C-S-u 1e0d space)
h = macro(C-S-u 1e25 space)
i = macro(C-S-u 012b space)
s = macro(C-S-u 1e63 space)
t = macro(C-S-u 1e6d space)
u = macro(C-S-u 016b space)
z = macro(C-S-u 1e93 space)
l = macro(C-S-u 02bf space)
j = macro(C-S-u 02be space)
esc = ~

[alt+shift]

a = macro(C-S-u 0100 space)
d = macro(C-S-u 1e0c space)
h = macro(C-S-u 1e24 space)
i = macro(C-S-u 012a space)
s = macro(C-S-u 1e62 space)
t = macro(C-S-u 1e6c space)
u = macro(C-S-u 016a space)
z = macro(C-S-u 1e92 space)
l = macro(C-S-u 02bf space)
j = macro(C-S-u 02be space)
" | sudo tee /etc/keyd/default.conf
else
echo "[ids]

*

[main]

leftalt = layer(alt)

[alt]

a = ā
d = ḍ
h = ḥ
i = ī
s = ṣ
t = ṭ
u = ū
z = ẓ
l = ʿ
j = ʾ
esc = ~

[alt+shift]

a = Ā
d = Ḍ
h = Ḥ
i = Ī
s = Ṣ
t = Ṭ
u = Ū
z = Ẓ
l = ʿ
j = ʾ
" | sudo tee /etc/keyd/default.conf
fi

systemctl restart keyd.service

