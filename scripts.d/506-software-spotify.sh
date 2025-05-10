#!/bin/bash

# Update your system
sudo nala update && sudo nala upgrade

# Import Spotify GPG Key
curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg

# Add Spotify APT Repository
echo "deb https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

# Update APT Cache
sudo nala update

# Install Visual Studio Code
sudo nala install spotify-client -y

echo "Spotify has been Installed!"
