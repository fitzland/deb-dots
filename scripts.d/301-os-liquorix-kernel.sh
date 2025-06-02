#!/bin/bash

# Update your system
sudo nala update && sudo nala upgrade

# Install required packages
sudo nala install lsb-release apt-transport-https curl -y

# Install Liquorix Kernel
curl 'https://liquorix.net/add-liquorix-repo.sh' | sudo bash

echo "You may now reboot your system to finalize Kernel installation!"
