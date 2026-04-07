# LMDE + dwm — New Machine Restore Guide

Two repos restore your full setup:

| Repo | What it provides |
|------|-----------------|
| `fitzland/dwm-desktop` | dwm, st, slstatus (build from source) + all suckless configs |
| `fitzland/deb-dots` | Shell, GTK, terminals, and misc dotfiles |

---

## Step 1: Base System

Install LMDE, run updates, then:

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install git curl feh lightdm lightdm-gtk-greeter
```

---

## Step 2: Build Suckless Tools

Install build dependencies:

```bash
sudo apt install libx11-dev libxft-dev libxinerama-dev \
    libfreetype6-dev libfontconfig1-dev build-essential
```

Clone and build:

```bash
git clone https://github.com/fitzland/dwm-desktop ~/git/fitzland/dwm-desktop
cd ~/git/fitzland/dwm-desktop

cd suckless/dwm && make && sudo make install && cd ../..
cd suckless/st && make && sudo make install && cd ../..
cd suckless/slstatus && make && sudo make install && cd ../..

# Deploy suckless configs to ~/.config/suckless/
./deploy-config.sh
```

---

## Step 3: Dotfiles

```bash
git clone https://github.com/fitzland/deb-dots ~/git/fitzland/deb-dots
cd ~/git/fitzland/deb-dots
./000-restore-skel.sh
```

This restores: shell configs, X11, GTK/Qt theming, feh wallpaper, terminal configs (alacritty/kitty), KeePassXC, Thunar, and suckless deployed configs.

> To also restore i3 or bspwm configs, uncomment those lines in `000-restore-skel.sh`.

---

## Step 4: LightDM

Check `reference/lightdm.conf` in deb-dots for any custom settings, then apply manually:

```bash
sudo cp ~/git/fitzland/deb-dots/reference/lightdm.conf /etc/lightdm/lightdm.conf
sudo systemctl enable lightdm
```

---

## Step 5: Software

Use `reference/packages.txt` in deb-dots as a guide for reinstalling apps. The `scripts.d/` directory has modular installers for common software (see `002-software.sh` for a menu-driven installer).

---

## Day-to-Day Backup Workflow

```bash
# After changing any dotfiles:
cd ~/git/fitzland/deb-dots
./010-backup-skel.sh     # snapshots to skel/, rotates old versions
./up.sh                  # commit + push to GitHub

# After changing dwm/st/slstatus source or suckless configs:
cd ~/git/fitzland/dwm-desktop
./up.sh
```

---

## Notes

- **dwm binaries must be rebuilt** on each machine — source is in dwm-desktop, not binaries
- **Wallpaper**: `~/.fehbg` is restored; run `feh --bg-scale <wallpaper>` once to set initial wallpaper
- **SSH keys**: never stored in this repo — set up manually or restore from secure backup
- **KeePassXC**: config is safe to restore; your `.kdbx` database files live in Dropbox
- **lightdm config** is root-owned and stored in `reference/` only — apply manually
