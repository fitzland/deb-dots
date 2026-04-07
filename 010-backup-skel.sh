#!/bin/bash
#set -e
##################################################################################################################
# Author    :   Jeff Fitzhugh by way of Erik Dubois (Thanks for helping us learn.)
##################################################################################################################
#
# Backup script for LMDE + dwm setup.
# Backs up dotfiles from $HOME into skel/, rotates old versions (delta/beta/current).
# Push to GitHub with up.sh after running this.
#
# For suckless (dwm/st/slstatus) source and configs, see: git/fitzland/dwm-desktop
##################################################################################################################

echo "################################################################"
echo "###############       BACKUP  Config      ######################"
echo "################################################################"

# Rotate snapshots: keep last 3 versions
rm -rf skel-delta
mv ./skel-beta skel-delta 2>/dev/null
mv ./skel skel-beta 2>/dev/null

mkdir -p ./skel/config
mkdir -p ./reference

# ── Shell ─────────────────────────────────────────────────────────────────────
cp $HOME/.bashrc           ./skel/.bashrc-deb
cp $HOME/.bashrc-personal  ./skel/.bashrc-personal  2>/dev/null
cp $HOME/.bash_profile     ./skel/.bash_profile      2>/dev/null
cp $HOME/.dircolors        ./skel/.dircolors         2>/dev/null
cp $HOME/.nanorc           ./skel/.nanorc            2>/dev/null
cp $HOME/.vimrc            ./skel/.vimrc             2>/dev/null

# ── X11 / Display ─────────────────────────────────────────────────────────────
cp $HOME/.Xresources       ./skel/
cp $HOME/.xsessionrc       ./skel/.xsessionrc        2>/dev/null
[ -d $HOME/.Xresources.d ] && cp -r $HOME/.Xresources.d ./skel/

# ── Identity / Git ────────────────────────────────────────────────────────────
cp $HOME/.face             ./skel/
cp $HOME/.gitconfig        ./skel/.gitconfig         2>/dev/null

# ── GTK / Qt Theming ──────────────────────────────────────────────────────────
cp $HOME/.gtkrc-2.0        ./skel/.gtkrc-2.0         2>/dev/null
[ -d $HOME/.config/gtk-2.0 ] && cp -r $HOME/.config/gtk-2.0 ./skel/config/
[ -d $HOME/.config/gtk-3.0 ] && cp -r $HOME/.config/gtk-3.0 ./skel/config/
[ -d $HOME/.config/gtk-4.0 ] && cp -r $HOME/.config/gtk-4.0 ./skel/config/
[ -d $HOME/.config/qt5ct ]   && cp -r $HOME/.config/qt5ct   ./skel/config/

# ── Wallpaper (feh) ───────────────────────────────────────────────────────────
cp $HOME/.fehbg            ./skel/.fehbg             2>/dev/null

# ── Terminals (WM-agnostic) ───────────────────────────────────────────────────
[ -d $HOME/.config/alacritty ] && cp -r $HOME/.config/alacritty ./skel/config/
[ -d $HOME/.config/kitty ]     && cp -r $HOME/.config/kitty     ./skel/config/

# ── App Configs ───────────────────────────────────────────────────────────────
[ -d $HOME/.config/keepassxc ] && cp -r $HOME/.config/keepassxc ./skel/config/
[ -d $HOME/.config/Thunar ]    && cp -r $HOME/.config/Thunar    ./skel/config/

# ── Suckless deployed configs (source lives in dwm-desktop repo) ──────────────
[ -d $HOME/.config/suckless ] && cp -r $HOME/.config/suckless* ./skel/config/

# ── Legacy WM Configs (backed up for future reference, not restored by default) ──
[ -d $HOME/.config/autostart ] && cp -r $HOME/.config/autostart ./skel/config/
[ -d $HOME/.config/bspwm ]     && cp -r $HOME/.config/bspwm*    ./skel/config/ 2>/dev/null
[ -d $HOME/.config/i3 ]        && cp -r $HOME/.config/i3*        ./skel/config/ 2>/dev/null

# ── Reference files (not restored automatically) ──────────────────────────────
# Copy lightdm config for reference (root-owned, manually apply on new machine)
[ -f /etc/lightdm/lightdm.conf ] && cp /etc/lightdm/lightdm.conf ./reference/lightdm.conf 2>/dev/null

# Snapshot installed packages for reference
apt list --installed 2>/dev/null | grep -v "^Listing" > ./reference/packages.txt

# Font and theme manifests (too large for git; lists only)
ls $HOME/.local/share/fonts  > ./reference/fonts-list.txt  2>/dev/null
ls $HOME/.local/share/themes > ./reference/themes-list.txt 2>/dev/null
ls $HOME/.icons              > ./reference/icons-list.txt  2>/dev/null

echo "################################################################"
echo "#########   Config has been copied and loaded   ################"
echo "################################################################"
