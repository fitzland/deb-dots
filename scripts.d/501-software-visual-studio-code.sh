#!/bin/bash

# Update your system
sudo nala update && sudo nala upgrade

# Install required packages
sudo nala install wget gpg apt-transport-https
sudo nala install wget gpg apt-transport-https
#sudo nala install dirmngr ca-certificates software-properties-common apt-transport-https curl -y

# Import Microsoft GPG Key
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
#curl -fSsL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/vscode.gpg >/dev/null

# Add Microsoft VSCode Apt Repository
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
#echo deb [arch=amd64 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main | sudo tee /etc/apt/sources.list.d/vscode.list

# Update APT Cache
sudo nala update

# Install Visual Studio Code
sudo nala install code -y

echo "Microsoft Visual Studio Code has been Installed!"
