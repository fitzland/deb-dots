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
echo "Installation of Dropbox"
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

cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

~/.dropbox-dist/dropboxd

###############################################################################

tput setaf 11;
echo "################################################################"
echo "Software has been installed"
echo "################################################################"
echo;tput sgr0
