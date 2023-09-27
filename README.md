
# [random-scripts](https://github.com/amjadodeh/random-scripts)

some random scripts. 

## Custom keyd Setup (Automated)

### Distros:

- openSUSE Leap and Tumbleweed: `bash <(curl -sL https://bit.ly/keyd-setup-opensuse)`
- Any other Non-NixOS distributions (uses nixpkgs): `bash <(curl -sL https://bit.ly/keyd-setup-nixpkgs)`

NOTE: This requires curl to run (obviously)
**WARNING: This may overwrite your current keyd config.**

## Custom keyd Setup (Manual)

### openSUSE:

```bash
# Install keyd
sudo zypper install keyd

# Make directory for config files if it doesn't already exist
sudo mkdir -p /etc/keyd/

# Add unicode support for current user by symlinking /usr/share/keyd/keyd.compose to ~/.XCompose
ln -s /usr/share/keyd/keyd.compose ~/.XCompose

# Create file 'default.conf' in keyd config directory if it doesn't already exist and write to that file
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

# Enable and start keyd daemon
systemctl enable --now keyd.service

# Thats it! You may have to restart your applications for this to take effect.
```

### Using Nix Package Manager (on non-NixOS):

**REQUIREMENTS:**
- curl must be installed
- systemd init system
- SELinux must be disabled

```bash
# Install Nix package manager using the recommended multi-user installation script (assuming its not already installed)
sh <(curl -L https://nixos.org/nix/install) --daemon

# Update environment to allow for Nix to work in active shell
. /etc/profile.d/nix.sh

# Install keyd via the Nix package manager
nix-env -iA nixpkgs.keyd

# Create systemd service file for keyd
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

# Make directory for config files if it doesn't already exist
sudo mkdir -p /etc/keyd/

# Find path for keyd.compose
KEYD_COMPOSE_PATH=$(sudo find / -name 'keyd.compose' | grep 'share/keyd/keyd.compose')

# Add unicode support for current user by symlinking path of keyd.compose to ~/.XCompose
ln -s $KEYD_COMPOSE_PATH ~/.XCompose

# Create file 'default.conf' in keyd config directory if it doesn't already exist and write to that file
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

# Enable and start keyd daemon
systemctl enable --now keyd.service

# Thats it! You may have to restart your applications for this to take effect.
```

