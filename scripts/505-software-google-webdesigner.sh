#!/bin/bash

# Update your system
sudo apt update && sudo apt upgrade

# Install required packages
sudo apt install curl software-properties-common apt-transport-https ca-certificates -y

# Import Web Designer GPG Key
curl -fSsL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /usr/share/keyrings/google-web-designer.gpg > /dev/null

# Add Web Designer Apt Repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-web-designer.gpg] http://dl.google.com/linux/webdesigner/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-web-designer.list

# Update APT Cache
sudo apt update

# Install Visual Studio Code
sudo apt install google-webdesigner -y

echo "Google Web Designer has been Installed!"
