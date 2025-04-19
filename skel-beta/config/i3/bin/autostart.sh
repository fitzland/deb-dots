# Autostart applications

# num lock activated
numlockx on &

#set compose key
setxkbmap -option compose:rctrl &

#get auth work with polkit agent
/usr/bin/lxpolkit &
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# bar start
#~/.config/i3/polybar-i3 &

# wallpaper
#feh --bg-fill ~/.config/backgrounds/wallhaven-578rw7_3440x1440.png &
~/.fehbg

# compositor and notifications
picom --animations -b &

# notifications
dunst &

# bluetooth app
blueman-applet &

# sxhkd
sxhkd -c ~/.config/i3/sxhkd/sxhkdrc &
