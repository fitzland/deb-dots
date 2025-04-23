#!/bin/bash

# Update your system
sudo apt update && sudo apt upgrade

# Install required packages
sudo apt-add-repository contrib non-free -y

# Import Microsoft GPG Key
curl -fSsL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/vscode.gpg >/dev/null

# Add Microsoft VSCode Apt Repository
echo deb [arch=amd64 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main | sudo tee /etc/apt/sources.list.d/vscode.list

# Update APT Cache
sudo apt update

# Install Visual Studio Code
sudo apt install code -y

echo "Microsoft Visual Studio Code has been Installed!"
