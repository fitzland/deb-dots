#!/bin/bash

# Update your system
sudo apt update 
sudo apt install extrepo -y

# Install required packages
sudo sed -i 's/# - non-free/- non-free/' /etc/extrepo/config.yaml
sudo extrepo enable google_chrome
sudo apt update

# Install Google Chrome Browser
sudo apt install google-chrome-stable -y

sudo rm -f /etc/apt/sources.list.d/google-chrome*.list
sudo apt update

google-chrome-stable --version

echo "Google Chrome Browser has been Installed!"
