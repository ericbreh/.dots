#!/usr/bin/env bash
set -e

# Check for required files
if [ ! -f "pacman-packages.txt" ] || [ ! -f "aur-packages.txt" ]; then
    echo "Error: Package files not found!"
    exit 1
fi

# Install pacman packages
echo "Installing $(wc -l < pacman-packages.txt) pacman packages..."
sudo pacman -S --needed - < pacman-packages.txt

# Install AUR packages
echo "Installing $(wc -l < aur-packages.txt) AUR packages..."
paru -S --needed - < aur-packages.txt
