#!/bin/bash

# Update your system
sudo apt update && sudo apt upgrade

# Install required packages
sudo apt install ca-certificates software-properties-common apt-transport-https curl -y

# Create a directory to store APT repository keys if it doesn't exist:
sudo install -d -m 0755 /etc/apt/keyrings
sudo apt install wget

# Import Mozilla APT Repository signing Key
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null

# Add Mozilla Apt Repository
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null

# Prioritize Mozilla Packages
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla

# Update APT Cache
sudo apt update

# Install Visual Studio Code
sudo apt install firefox-devedition -y

echo "Mozilla Firefox Developer Edition has been Installed!"
