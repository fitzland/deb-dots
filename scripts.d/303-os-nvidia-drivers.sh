#!/bin/bash

# Nvidia Driver Installation for Debian 13 (Trixie) / LMDE 7 Gigi
# Uses Debian non-free repositories — recommended for desktop use.
# For CUDA toolkit development, see the commented section at the bottom.
#
# NOTE: Nvidia 590+ drivers dropped support for Maxwell, Pascal, and Volta GPUs.
# If you have an older card (GTX 900/1000/Titan V series), check your GPU generation
# before installing and pin to an older driver version if needed.

# Remove previous Nvidia drivers
echo "Removing previous Nvidia drivers..."
sudo apt autoremove --purge -y 'nvidia*' 2>/dev/null || true

# Update system
sudo apt update && sudo apt full-upgrade -y

# Enable non-free repositories
# Debian 13 uses DEB822 format (.sources); LMDE Gigi uses traditional .list format.
echo "Enabling non-free repositories..."

if [ -f /etc/apt/sources.list.d/debian.sources ]; then
    # Debian 13 — DEB822 format
    if ! grep -q 'non-free' /etc/apt/sources.list.d/debian.sources; then
        sudo sed -i '/^Components:/ s/$/ contrib non-free non-free-firmware/' \
            /etc/apt/sources.list.d/debian.sources
        echo "Non-free repos enabled (DEB822 format)."
    else
        echo "Non-free repos already enabled."
    fi
elif [ -f /etc/apt/sources.list.d/official-package-repositories.list ]; then
    # LMDE Gigi — modifies only the Debian upstream lines, not Mint-specific lines
    if ! grep -q 'non-free' /etc/apt/sources.list.d/official-package-repositories.list; then
        sudo sed -i '/deb\.debian\.org/ s/main$/main contrib non-free non-free-firmware/' \
            /etc/apt/sources.list.d/official-package-repositories.list
        sudo sed -i '/security\.debian\.org/ s/main$/main contrib non-free non-free-firmware/' \
            /etc/apt/sources.list.d/official-package-repositories.list
        echo "Non-free repos enabled (LMDE Gigi format)."
    else
        echo "Non-free repos already enabled."
    fi
else
    echo "Could not detect apt sources format. Enable non-free repos manually, then re-run."
    exit 1
fi

# Update APT cache after enabling non-free
sudo apt update

# Install Nvidia drivers
# nvidia-kernel-dkms builds the kernel module via DKMS (survives kernel updates)
# For Turing (RTX 20xx) and newer, you may substitute nvidia-open-kernel-dkms
echo "Installing Nvidia drivers..."
sudo apt install -y nvidia-kernel-dkms nvidia-driver firmware-misc-nonfree nvidia-settings

echo ""
echo "Nvidia Drivers have been Installed!"
echo "Please reboot your system to load the new driver: sudo reboot"

# --- CUDA Toolkit (optional, for development) ---
# Uncomment the following to also install the CUDA toolkit from Nvidia's repo.
# Do NOT use the debian12 CUDA repo — Debian 13 rejects its SHA1 signatures.
#
# wget https://developer.download.nvidia.com/compute/cuda/repos/debian13/x86_64/cuda-keyring_1.1-1_all.deb
# sudo dpkg -i cuda-keyring_1.1-1_all.deb
# sudo apt update
# sudo apt install -y cuda-toolkit
