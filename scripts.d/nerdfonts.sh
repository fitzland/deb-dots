#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Ensure curl is available for version lookup
if ! command_exists curl; then
    echo "Installing curl..."
    sudo nala install curl -y
fi

# Fetch latest Nerd Fonts release version from GitHub
VERSION=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
    | grep '"tag_name"' | cut -d'"' -f4)
echo "Installing Nerd Fonts ${VERSION}..."

# Check if unzip is installed; if not, install it
if ! command_exists unzip; then
    echo "Installing unzip..."
    sudo nala install unzip -y
fi

# Create directory for fonts if it doesn't exist
mkdir -p ~/.local/share/fonts

# Array of font names
fonts=( 
    "CascadiaCode"
    "FiraCode"  
    "Inconsolata"
    "IosevkaTerm"
    "JetBrainsMono" 
    "RobotoMono" 
    "SourceCodePro" 
    "UbuntuMono"
    # Add additional fonts here if needed
)

# Function to check if font directory exists
check_font_installed() {
    font_name=$1
    if [ -d ~/.local/share/fonts/$font_name ]; then
        echo "Font $font_name is already installed. Skipping."
        return 0  # Font already installed
    else
        return 1  # Font not installed
    fi
}

# Loop through each font, check if installed, and install if not
for font in "${fonts[@]}"
do
    if check_font_installed "$font"; then
        echo "Skipping installation of font: $font"
        continue  # Skip installation if font is already installed
    fi
    
    echo "Installing font: $font"
    wget -q --show-progress "https://github.com/ryanoasis/nerd-fonts/releases/download/${VERSION}/$font.zip" -P /tmp
    if [ $? -ne 0 ]; then
        echo "Failed to download font: $font"
        continue
    fi
    
    unzip -q /tmp/$font.zip -d ~/.local/share/fonts/$font/
    if [ $? -ne 0 ]; then
        echo "Failed to extract font: $font"
        continue
    fi
    
    rm /tmp/$font.zip
done

# Update font cache
fc-cache -f

echo "Fonts installation completed."
