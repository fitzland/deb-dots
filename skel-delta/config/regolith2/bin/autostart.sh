#!/usr/bin/env bash

## Copyright (C) 2020-2022 Aditya Shakya <adi1090x@gmail.com>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3
## Autostart Programs

# Set display from arandr saved script
sh ~/.screenlayout/monitor.sh &

# num lock activated
exec --no-startup-id numlockx on

# Set Compose key
setxkbmap -option compose:rctrl &

# Fix cursor
xsetroot -cursor_name left_ptr

# Launch keybindings daemon
#sxhkd -c $HOME/.config/regolith2/sxhkdrc &

# Start dropbox
exec dropbox &

# set wallpaper
#exec --no-startup-id sleep 2 && nitrogen --restore
#exec --no-startup-id feh --bg-fill /usr/share/endeavouros/backgrounds/endeavouros_i3.png
#hsetroot -cover ~/.config/i3/wallpapers/default.png
#feh --no-xinerama --no-fehbg --bg-scale /usr/share/backgrounds/endeavouros-hal.png

