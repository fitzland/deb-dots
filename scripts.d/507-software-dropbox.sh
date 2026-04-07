#!/bin/bash

# Download and extract Dropbox daemon
wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf - -C ~

# Start daemon in background — it will open a browser link for account linking
echo "Starting Dropbox daemon..."
nohup ~/.dropbox-dist/dropboxd >/dev/null 2>&1 &

echo ""
echo "Dropbox daemon started in the background."
echo "Check your browser to complete account linking."
echo "Once linked, Dropbox will run automatically at login."
