#!/bin/bash

# This function will be executed when the script receives the TERM signal
cleanup() {
    echo "DWM is quitting, terminating child processes..."
    # Kills all children of this script.
    pkill -P $$
}

# 'trap' registers the 'cleanup' function to run upon receiving a TERM signal
trap 'cleanup' TERM

# Set display from arandr saved script
sh ~/.screenlayout/monitor.sh &

slstatus &

# polkit
lxpolkit &

# background
feh --no-xinerama --bg-fill ~/.config/suckless/wallpaper/wide/dwm.png &

# sxhkd
# (re)load sxhkd for keybinds
if hash sxhkd >/dev/null 2>&1; then
	pkill sxhkd
	sleep 0.5
	sxhkd -c "$HOME/.config/suckless/sxhkd/sxhkdrc" &
fi

# Compose key
setxkbmap -option compose:rctrl

# Fix cursor
xsetroot -cursor_name left_ptr

# Network Applet
nm-applet --indicator &

# bluetooth applet
blueman-applet &

dunst -config ~/.config/suckless/dunst/dunstrc &
picom --config ~/.config/suckless/picom/picom.conf -b &

# dropbox
~/.dropbox-dist/dropboxd &

wmname LG3D &
export _JAVA_AWT_WM_NONREPARENTING=1

# 'wait' is essential. It makes the script pause here and wait for a signal.
# Without it, the script would finish immediately, and the trap would be useless.
wait
