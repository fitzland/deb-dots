#!/bin/bash

# Update your system
sudo nala update && sudo nala upgrade -y

# Install required packages
sudo nala install -y wget gpg apt-transport-https

# Import Microsoft GPG Key
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | \
    sudo gpg --dearmor -o /usr/share/keyrings/packages.microsoft.gpg

# Add Microsoft VSCode APT Repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] \
https://packages.microsoft.com/repos/code stable main" | \
    sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

# Update APT Cache
sudo nala update

# Install Visual Studio Code
sudo nala install -y code

echo "Microsoft Visual Studio Code has been Installed!"
