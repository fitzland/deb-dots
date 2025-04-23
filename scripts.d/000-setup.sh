#!/bin/bash

# Function to install vanilla AwesomeWM
install_vanilla_awesome() {
    echo "Installing vanilla AwesomeWM..."
    bash ./108-desktop-awesome-vanilla.sh
}

# Function to install customized AwesomeWM
install_custom_awesome() {
    echo "Installing JUSTAGUYLINUX customized AwesomeWM..."
    bash ./107-desktop-awesome-vanilla.sh
}

# Function to install vanilla BSPWM
install_vanilla_bspwm() {
    echo "Installing vanilla BSPWM..."
    bash ./106-desktop-bspwm-vanilla.sh
}

# Function to install customized BSPWM
install_custom_bspwm() {
    echo "Installing JUSTAGUYLINUX customized BSPWM..."
    bash ./105-desktop-bspwm-custom.sh
}

# Function to install vanilla DWM
install_vanilla_dwm() {
    echo "Installing vanilla DWM..."
    bash ./104-desktop-dwm-vanilla.sh
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
                "DK Window Manager")
                    install_vanilla_dk
                    ;;
                "DWM")
                    install_vanilla_dwm
                    ;;
                "Fluxbox")
                    install_vanilla_fluxbox
                    ;;
                "IceWM")
                    install_vanilla_icewm
                    ;;
                "i3")
                    install_vanilla_i3
                    ;;
                "Openbox")
                    install_vanilla_openbox
                    ;;
                "Qtile")
                    install_vanilla_qtile
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
                "DK Window Manager")
                    install_custom_dk
                    ;;
                "DWM")
                    install_custom_dwm
                    ;;
                "Fluxbox")
                    install_custom_fluxbox
                    ;;
                "IceWM")
                    install_custom_icewm
                    ;;
                "i3")
                    install_custom_i3
                    ;;
                "Openbox")
                    install_custom_openbox
                    ;;
                "Qtile")
                    install_custom_qtile
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


