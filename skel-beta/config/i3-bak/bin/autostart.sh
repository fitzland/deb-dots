#!/usr/bin/env bash

## Copyright (C) 2020-2022 Aditya Shakya <adi1090x@gmail.com>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3
## Autostart Programs

# Set display from arandr saved script
sh ~/.screenlayout/monitor.sh &

# Kill already running process
_ps=(picom dunst ksuperkey mpd xfce-polkit xfce4-power-manager)
for _prs in "${_ps[@]}"; do
	if [[ `pidof ${_prs}` ]]; then
		killall -9 ${_prs}
	fi
done

# num lock activated
exec --no-startup-id numlockx on

# Set Compose key
setxkbmap -option compose:rctrl &

# Fix cursor
xsetroot -cursor_name left_ptr

# Polkit agent
/usr/lib/xfce-polkit/xfce-polkit &

# Launch keybindings daemon
sxhkd -c $HOME/.config/i3/sxhkdrc &

# Enable power management
xfce4-power-manager &

# Start dropbox
exec dropbox &

# set wallpaper
exec --no-startup-id sleep 2 && nitrogen --restore
#exec --no-startup-id feh --bg-fill /usr/share/endeavouros/backgrounds/endeavouros_i3.png
#hsetroot -cover ~/.config/i3/wallpapers/default.png
feh --no-xinerama --no-fehbg --bg-scale /usr/share/backgrounds/endeavouros-hal.png

# Lauch notification daemon
~/.config/i3/bin/i3dunst.sh

# Lauch polybar
#~/.config/i3/bin/i3bar.sh

# Lauch compositor
#~/.config/i3/bin/i3comp.sh

# Start mpd
# exec mpd &
