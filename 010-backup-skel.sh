#!/bin/bash
#set -e
##################################################################################################################
# Author 	: 	Jeff Fitzhugh by way of Erik Dubois
##################################################################################################################
#
##################################################################################################################

echo "################################################################"
echo "###############       BACKUP  Config      ######################"
echo "################################################################"

rm -r skel-delta

mv ./skel-beta skel-delta
mv ./skel skel-beta

mkdir ./skel
cp -r $HOME/.config/autostart ./skel/config/
cp -r $HOME/.config/bspwm* ./skel/config/
cp -r $HOME/.config/gtk-2.0 ./skel/config/
cp -r $HOME/.config/gtk-3.0 ./skel/config/
cp -r $HOME/.config/gtk-4.0 ./skel/config/
cp -r $HOME/.config/i3* ./skel/config/
cp -r $HOME/.config/keepassxc ./skel/config/
cp -r $HOME/.config/nitrogen ./skel/config/
cp -r $HOME/.config/qt5ct ./skel/config/
cp -r $HOME/.config/Thunar ./skel/config/
cp -r $HOME/.Xresources.d ./skel/config/
cp $HOME/.bashrc ./skel/.bashrc-deb
cp $HOME/.Xresources ./skel/
cp $HOME/.face ./skel/
cp $HOME/.jwmrc ./skel/

echo "################################################################"
echo "#########   Config has been copied and loaded   ################"
echo "################################################################"
