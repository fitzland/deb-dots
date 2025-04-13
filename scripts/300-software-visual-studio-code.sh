#!/bin/bash
#set -e

###############################################################################
#
#   DECLARATION OF FUNCTIONS
#
###############################################################################


func_install() {
	if apt search $1 &> /dev/null; then
		tput setaf 2
  		echo "###############################################################################"
  		echo "################## The package "$1" is already installed"
      	echo "###############################################################################"
      	echo
		tput sgr0
	else
    	tput setaf 3
    	echo "###############################################################################"
    	echo "##################  Installing package "  $1
    	echo "###############################################################################"
    	echo
    	tput sgr0
    	sudo apt install -y $1
    fi
}

func_category() {
	tput setaf 5;
	echo "################################################################"
	echo "Installing software for category " $1
	echo "################################################################"
	echo;tput sgr0
}

###############################################################################

func_category Additional-distro-specific

list=(
alacritty
arandr
dmenu
dunst
feh
flameshot
#gmrun
gtk-engine-murrine
i3blocks
imagemagick
jq
lxappearance
lxsession
#micro
net-tools
nitrogen
picom
playerctl
polybar
ranger
rofi
ttf-font-awesome
volumeicon
w3m
wmname
xsettingsd
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	func_install $name
done
#echo "Fixing hardcoded icon paths for applications - Wait for it"
#sudo hardcode-fixer

###############################################################################

tput setaf 11;
echo "################################################################"
echo "Software has been installed"
echo "################################################################"
echo;tput sgr0
