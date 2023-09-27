#!/bin/bash

sh <(curl -L https://nixos.org/nix/install) --no-daemon --yes

. $HOME/.nix-profile/etc/profile.d/nix.sh

nix-env -iA nixpkgs.keyd

echo "[Unit]
Description=key remapping daemon
Requires=local-fs.target
After=local-fs.target

[Service]
Type=simple
ExecStart=$HOME/.nix-profile/bin/keyd

[Install]
WantedBy=sysinit.target
" | sudo tee /usr/lib/systemd/system/keyd.service

systemctl enable --now keyd.service

sudo mkdir -p /etc/keyd/

KEYD_COMPOSE_PATH=$(sudo find / -name 'keyd.compose' | grep "/nix/store/.*$(keyd -v | grep -oP 'v\K[0-9.]+')/share/keyd/keyd.compose")

ln -s $KEYD_COMPOSE_PATH ~/.XCompose

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

