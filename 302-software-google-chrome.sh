#!/bin/bash
#set -e


###############################################################################
#
#   DECLARATION OF FUNCTIONS
#
###############################################################################


func_install() {
   	tput setaf 3
    	echo "###############################################################################"
    	echo "##################  Installing package "  $1
    	echo "###############################################################################"
    	echo
    	tput sgr0
    	sudo apt install -y $1 
}

###############################################################################
echo "Installation of Google Chrome Stable"
###############################################################################

list=(
wget
)

count=0

for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package num.  "$count " " $name;tput sgr0;
	func_install $name
done

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo apt install ./google-chrome-stable_current_amd64.deb

sudo rm google-chrome-stable_current_amd64.deb

###############################################################################

tput setaf 11;
echo "################################################################"
echo "Software has been installed"
echo "################################################################"
echo;tput sgr0
