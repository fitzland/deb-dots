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
echo "Installation of sound software"
###############################################################################

list=(
#curl
)

count=0

for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package num.  "$count " " $name;tput sgr0;
	func_install $name
done

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 4773BD5E130D1D45

sudo echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt update

sudo apt install -y spotify-client

###############################################################################

tput setaf 11;
echo "################################################################"
echo "Software has been installed"
echo "################################################################"
echo;tput sgr0
