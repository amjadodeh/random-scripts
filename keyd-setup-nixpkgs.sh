#!/bin/bash

sh <(curl -L https://nixos.org/nix/install) --daemon --yes

nix-env -iA nixpkgs.keyd

echo "[Unit]
Description=key remapping daemon
Requires=local-fs.target
After=local-fs.target

[Service]
Type=simple
ExecStart=/usr/bin/keyd

[Install]
WantedBy=sysinit.target
" | sudo tee /usr/lib/systemd/system/keyd.service

systemctl enable --now keyd.service

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

systemctl restart keyd.service

echo "Done! Please restart your applications for this to take effect."

