#!/bin/bash

# Update your system
sudo apt update && sudo apt upgrade

# Install required packages
sudo apt install software-properties-common apt-transport-https ca-certificates curl -y

# Import XanMod GPG Key
curl -fSsL https://dl.xanmod.org/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/xanmod.gpg > /dev/null

# Add XanMod APT Repository
echo 'deb [signed-by=/usr/share/keyrings/xanmod.gpg] http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-kernel.list

# Update APT Cache
sudo apt update

# Prepare XanMod Kernel Check Script
wget https://dl.xanmod.org/check_x86-64_psabi.sh
chmod +x check_x86-64_psabi.sh

# Run XanMod Kernel Check Script
./check_x86-64_psabi.sh

echo "You may now install the correct XanMod Kernel!"
