#!/bin/bash

sudo zypper in -y keyd

sudo mkdir -p /etc/keyd/

ln -s /usr/share/keyd/keyd.compose ~/.XCompose

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

systemctl enable --now keyd.service

echo "Done! Please restart your applications for this to take effect."

