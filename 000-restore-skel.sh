#!/bin/bash
#set -e
##################################################################################################################
# Author    :   Jeff Fitzhugh by way of Erik Dubois
##################################################################################################################
#
# Restore script for LMDE + dwm setup.
# Copies dotfiles from skel/ into $HOME.
#
# Before running: make sure suckless tools are built and installed from dwm-desktop repo.
# See RESTORE.md for full new-machine setup instructions.
#
# Legacy WM configs (i3, bspwm) are preserved in the repo but commented out below.
# Uncomment those sections if you're setting up an i3 or bspwm machine.
##################################################################################################################

echo "################################################################"
echo "###############       RESTORE Config      ######################"
echo "################################################################"

# ── Shell ─────────────────────────────────────────────────────────────────────
[ -f ./skel/.bashrc-deb ]       && cp ./skel/.bashrc-deb       $HOME/.bashrc
[ -f ./skel/.bashrc-personal ]  && cp ./skel/.bashrc-personal  $HOME/
[ -f ./skel/.bash_profile ]     && cp ./skel/.bash_profile      $HOME/
[ -f ./skel/.dircolors ]        && cp ./skel/.dircolors         $HOME/
[ -f ./skel/.nanorc ]           && cp ./skel/.nanorc            $HOME/
[ -f ./skel/.vimrc ]            && cp ./skel/.vimrc             $HOME/

# ── X11 / Display ─────────────────────────────────────────────────────────────
[ -f ./skel/.Xresources ]       && cp ./skel/.Xresources        $HOME/
[ -f ./skel/.xsessionrc ]       && cp ./skel/.xsessionrc        $HOME/
[ -d ./skel/.Xresources.d ]     && cp -r ./skel/.Xresources.d   $HOME/

# ── Identity / Git ────────────────────────────────────────────────────────────
[ -f ./skel/.face ]             && cp ./skel/.face              $HOME/
[ -f ./skel/.gitconfig ]        && cp ./skel/.gitconfig         $HOME/

# ── GTK / Qt Theming ──────────────────────────────────────────────────────────
[ -f ./skel/.gtkrc-2.0 ]        && cp ./skel/.gtkrc-2.0        $HOME/
[ -d ./skel/config/gtk-2.0 ]    && cp -r ./skel/config/gtk-2.0 $HOME/.config/
[ -d ./skel/config/gtk-3.0 ]    && cp -r ./skel/config/gtk-3.0 $HOME/.config/
[ -d ./skel/config/gtk-4.0 ]    && cp -r ./skel/config/gtk-4.0 $HOME/.config/
[ -d ./skel/config/qt5ct ]      && cp -r ./skel/config/qt5ct   $HOME/.config/

# ── Wallpaper (feh) ───────────────────────────────────────────────────────────
[ -f ./skel/.fehbg ]            && cp ./skel/.fehbg             $HOME/

# ── Terminals (WM-agnostic) ───────────────────────────────────────────────────
[ -d ./skel/config/alacritty ]  && cp -r ./skel/config/alacritty $HOME/.config/
[ -d ./skel/config/kitty ]      && cp -r ./skel/config/kitty     $HOME/.config/

# ── App Configs ───────────────────────────────────────────────────────────────
[ -d ./skel/config/keepassxc ]  && cp -r ./skel/config/keepassxc $HOME/.config/
[ -d ./skel/config/Thunar ]     && cp -r ./skel/config/Thunar     $HOME/.config/

# ── Suckless deployed configs ─────────────────────────────────────────────────
[ -d ./skel/config/suckless ]   && cp -r ./skel/config/suckless* $HOME/.config/

# ── Legacy WM Configs (uncomment to restore i3/bspwm setup) ──────────────────
# [ -d ./skel/config/autostart ] && cp -r ./skel/config/autostart $HOME/.config/
# [ -d ./skel/config/bspwm ]     && cp -r ./skel/config/bspwm*    $HOME/.config/
# [ -d ./skel/config/i3 ]        && cp -r ./skel/config/i3*        $HOME/.config/
# [ -f ./skel/.jwmrc ]           && cp ./skel/.jwmrc               $HOME/

echo "################################################################"
echo "#########   Config has been copied and loaded   ################"
echo "################################################################"
