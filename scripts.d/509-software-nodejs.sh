#!/bin/bash

# Update your system
sudo apt update && sudo apt upgrade

# Install extrepo and discover NodeSource Entries
sudo apt install extrepo
extrepo search node

# Enable NodeSource Node.js Stream on Debian
sudo extrepo enable node_24.x

# Import Mozilla APT Repository signing Key
sudo apt install nodejs
node --version
npm --version

# Update APT Cache
sudo nala update

echo "Nodejs has been Installed!"
