#!/bin/bash

# Update your system
sudo nala update && sudo nala upgrade

# Install required packages
sudo nala install software-properties-common apt-transport-https ca-certificates curl -y

# Import Microsoft GPG Key
curl -fSsL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft-edge.gpg > /dev/null

# Add Microsoft Edge APT Repository
echo 'deb [signed-by=/usr/share/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main' | sudo tee /etc/apt/sources.list.d/microsoft-edge.list

# Update APT Cache
sudo nala update

# Install Microsoft Edge Browser
sudo nala install microsoft-edge-stable -y

echo "Microsoft Edge Browser has been Installed!"
