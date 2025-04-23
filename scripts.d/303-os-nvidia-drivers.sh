#!/bin/bash

# Remove Previous Nvidia Drivers
sudo apt autoremove nvidia* --purge

# Update your system
sudo apt update && sudo apt upgrade

# Enable Contrib & Non-Free Repositories
sudo apt install software-properties-common -y

sudo add-apt-repository contrib non-free-firmware

# Import Nvidia GPG Key
sudo apt install dirmngr ca-certificates software-properties-common apt-transport-https dkms curl -y

curl -fSsL https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/3bf863cc.pub | sudo gpg --dearmor | sudo tee /usr/share/keyrings/nvidia-drivers.gpg > /dev/null 2>&1

# Import Nvidia APT Repository
echo 'deb [signed-by=/usr/share/keyrings/nvidia-drivers.gpg] https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/ /' | sudo tee /etc/apt/sources.list.d/nvidia-drivers.list

# Update APT Cache
sudo apt update

# Install Nvidia Drivers
sudo apt install nvidia-driver cuda nvidia-smi nvidia-settings -y

echo "Nvidia Drivers have been Installed!"
