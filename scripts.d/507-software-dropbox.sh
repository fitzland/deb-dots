#!/bin/bash

# Download Dropbox daemon to your system
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

# Run Dropbox daemon 
~/.dropbox-dist/dropboxd

echo "Dropbox has been Installed!"
