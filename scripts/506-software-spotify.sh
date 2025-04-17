#!/bin/bash

# Update your system
sudo apt update && sudo apt upgrade

# Import Spotify GPG Key
curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg

# Add Spotify APT Repository
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

# Update APT Cache
sudo apt update

# Install Visual Studio Code
sudo apt install spotify-client -y

echo "Spotify has been Installed!"
