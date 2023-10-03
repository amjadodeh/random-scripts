
# [random-scripts](https://github.com/amjadodeh/random-scripts)

some random scripts. 

## Custom keyd Setup (Automated)

### Distros:

- Debian / Debian-based / Ubuntu-based (via nixpkgs): `bash <(curl -sL https://bit.ly/keyd-setup-nixpkgs)`
- Fedora (via nixpkgs): `bash <(curl -sL https://bit.ly/keyd-setup-nixpkgs)`
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
- /etc/sudoers exists

```bash
# Install Nix package manager using the single-user installation script (assuming its not already installed)
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# Update environment to allow for Nix to work in active shell
. $HOME/.nix-profile/etc/profile.d/nix.sh

# Install keyd via the Nix package manager
nix-env -iA nixpkgs.keyd

# Allow for current user to run keyd with sudo without password by appending a line to /etc/sudoers
echo "$USER ALL=(ALL) NOPASSWD: $HOME/.nix-profile/bin/keyd" | sudo tee -a /etc/sudoers

# Make directory in .config for systemd user services if it doesn't already exist
mkdir -p $HOME/.config/systemd/user/

# Create systemd user service file for keyd
echo "[Unit]
Description=key remapping daemon

[Service]
Type=simple
ExecStart=/usr/bin/sudo $HOME/.nix-profile/bin/keyd

[Install]
WantedBy=default.target
" | sudo tee $HOME/.config/systemd/user/keyd.service

# Make directory for keyd config files if it doesn't already exist
sudo mkdir -p /etc/keyd/

# Find path for keyd.compose
KEYD_COMPOSE_PATH=$(sudo find / -name 'keyd.compose' | grep "/nix/store/.*$($HOME/.nix-profile/bin/keyd -v | grep -oP 'v\K[0-9.]+')/share/keyd/keyd.compose")

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
systemctl --user enable --now keyd.service

# Thats it! You should now restart your system for changes to take effect.
```

