#!/usr/bin/env bash

## Copyright (C) 2020-2022 Aditya Shakya <adi1090x@gmail.com>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3
## Autostart Programs

# Set display from arandr saved script
sh ~/.screenlayout/monitor.sh &

# Kill already running process
_ps=(picom dunst lxpolkit mpd)
for _prs in "${_ps[@]}"; do
	if [[ `pidof ${_prs}` ]]; then
		killall -9 ${_prs}
	fi
done

# num lock activated
#exec --no-startup-id numlockx on

# Set Compose key
#setxkbmap -option compose:rctrl &

# Fix cursor
#xsetroot -cursor_name left_ptr

# polkit agent
if [[ ! `pidof lxpolkit` ]]; then
	/usr/bin/lxpolkit &
fi

# Launch keybindings daemon
sxhkd -c $HOME/.config/i3/sxhkdrc &

# Start dropbox
#exec dropbox start &

# set wallpaper
#exec --no-startup-id sleep 2 && nitrogen --restore

# Launch colors
#~/.config/i3/bin/i3colors.sh

# Launch notification daemon
#~/.config/i3/bin/i3dunst.sh

# Launch polybar
#~/.config/i3/bin/i3bar.sh

# Launch compositor
#~/.config/i3/bin/i3comp.sh
