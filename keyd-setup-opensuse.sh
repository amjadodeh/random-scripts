#!/bin/bash

sudo zypper in -y keyd

systemctl enable --now keyd.service

sudo mkdir -p /etc/keyd/

echo "[ids]

*

[main]

leftalt = layer(alt)

[alt]

a = macro(C-S-u 0101 space)
d = macro(C-S-u 1E0D space)
h = macro(C-S-u 1E25 space)
i = macro(C-S-u 012B space)
s = macro(C-S-u 1E63 space)
t = macro(C-S-u 1E6D space)
u = macro(C-S-u 016B space)
z = macro(C-S-u 1E93 space)
l = macro(C-S-u 02BF space)
j = macro(C-S-u 02BE space)
esc = ~

[alt+shift]

a = macro(C-S-u 0100 space)
d = macro(C-S-u 1E0C space)
h = macro(C-S-u 1E24 space)
i = macro(C-S-u 012A space)
s = macro(C-S-u 1E62 space)
t = macro(C-S-u 1E6C space)
u = macro(C-S-u 016A space)
z = macro(C-S-u 1E92 space)
l = macro(C-S-u 02BF space)
j = macro(C-S-u 02BE space)
" | sudo tee /etc/keyd/default.conf

systemctl restart keyd.service

