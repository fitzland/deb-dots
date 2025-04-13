#!/bin/bash

# Update your system
sudo apt update && sudo apt upgrade

# Install required packages
sudo apt install software-properties-common apt-transport-https ca-certificates curl -y

# Import Google Chrome GPG Key
curl -fSsL https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor | sudo tee /usr/share/keyrings/google-chrome.gpg >> /dev/null

# Add Google Chrome APT Repository
echo deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main | sudo tee /etc/apt/sources.list.d/google-chrome.list

# Update APT Cache
sudo apt update

# Install Microsoft Edge Browser
sudo apt install google-chrome-stable -y

echo "Google Chrome Browser has been Installed!"
