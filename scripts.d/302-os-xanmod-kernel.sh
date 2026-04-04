#!/bin/bash

# Update your system
sudo apt update && sudo apt upgrade

# Install required packages
#sudo apt install software-properties-common apt-transport-https ca-certificates curl -y # debian
sudo apt install dirmngr lsb-release ca-certificates software-properties-common apt-transport-https dkms curl -y # linux mint

# Import XanMod GPG Key
#curl -fSsL https://dl.xanmod.org/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/xanmod.gpg > /dev/null # debian
curl -fsSL https://dl.xanmod.org/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/xanmod.gpg > /dev/null # linux mint

# Add XanMod APT Repository
echo 'deb [signed-by=/usr/share/keyrings/xanmod.gpg] http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-kernel.list # debian or linux mint

# Update APT Cache
sudo apt upgrade

# Prepare XanMod Kernel Check Script
wget https://dl.xanmod.org/check_x86-64_psabi.sh
chmod +x check_x86-64_psabi.sh

# Run XanMod Kernel Check Script
./check_x86-64_psabi.sh

echo "You may now install the correct XanMod Kernel!"
