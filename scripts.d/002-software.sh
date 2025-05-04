#!/bin/bash

# Function to install visual studio code
install_vsc() {
    echo "Installing Microsfot Visual Studio Code..."
    bash ./501-software-visual-studio-code.sh
}

# Function to install firefox developer edition
install_ffde() {
    echo "Installing Mozilla Firefox Developer Edition..."
    bash ./502-software-firefox-devedition.sh
}

# Function to install microsoft edge
install_mse() {
    echo "Installing Microsoft Edge..."
    bash ./503-software-ms-edge.sh
}

# Function to install google chrome
install_gchr() {
    echo "Installing Google Chrome..."
    bash ./504-software-google-chrome.sh
}

# Function to install spotify
install_spotify() {
    echo "Installing Spotify..."
    bash ./506-software-spotify.sh
}

# Function to install customized DWM
install_custom_dwm() {
    echo "Installing JUSTAGUYLINUX customized DWM with picom animations..."
    bash ./103-desktop-dwm-custom.sh
}

# Function to install vanilla i3
install_vanilla_i3() {
    echo "Installing vanilla i3..."
    bash ./102-desktop-i3-vanilla.sh
}

# Function to install customized i3
install_custom_i3() {
    echo "Installing JUSTAGUYLINUX customized i3..."
    bash ./101-desktop-i3-custom.sh
}

# Function to prompt user for installation choice (vanilla or customized)
prompt_installation_choice() {
    local wm_name="$1"
    echo "$wm_name Installation"
    echo "1. Install $wm_name with no customization"
    echo "2. Install $wm_name with JUSTAGUYLINUX customized"
    echo "Or ENTER to skip"
    read -r choice

   case "$choice" in
        1)
            echo "Installing $wm_name with no customization..."
            ;;
        2)
            echo "Installing $wm_name with JUSTAGUYLINUX customized..."
            ;;
        *)
            echo "Skipping installation of $wm_name."
            ;;
    esac
    
    # Adding a couple of line returns
    echo -e "\n\n"
}

# Main script starts here

# Array to store user choices
declare -A choices

# Prompt for each window manager and store choices in the array
prompt_and_store_choice() {
    local wm_name="$1"
    prompt_installation_choice "$wm_name"
    choices["$wm_name"]=$choice
}

# Prompt for AwesomeWM installation
prompt_and_store_choice "AwesomeWM"

# Prompt for BSPWM installation
prompt_and_store_choice "BSPWM"

# Prompt for DWM installation
prompt_and_store_choice "DWM"

# Prompt for i3 installation
prompt_and_store_choice "i3"

# Install based on user choices stored in the array
for wm_name in "${!choices[@]}"; do
    case "${choices[$wm_name]}" in
        1)
            case "$wm_name" in
                "AwesomeWM")
                    install_vanilla_awesome
                    ;;
                "BSPWM")
                    install_vanilla_bspwm
                    ;;
                "DWM")
                    install_vanilla_dwm
                    ;;
                "i3")
                    install_vanilla_i3
                    ;;
                *)
                    echo "Installation function not defined for $wm_name"
                    ;;
            esac
            ;;
        2)
            case "$wm_name" in
                "AwesomeWM")
                    install_custom_awesome
                    ;;
                "BSPWM")
                    install_custom_bspwm
                    ;;
                "DWM")
                    install_custom_dwm
                    ;;
                "i3")
                    install_custom_i3
                    ;;
                *)
                    echo "Installation function not defined for $wm_name"
                    ;;
            esac
            ;;
        *)
            echo "Skipping $wm_name installation..."
            ;;
    esac
done

echo "All installations completed."


