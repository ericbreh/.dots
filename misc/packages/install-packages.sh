#!/bin/bash

echo "Installing packages from saved lists..."

# Check if package files exist
if [ ! -f "pacman-packages.txt" ]; then
    echo "Error: pacman-packages.txt not found!"
    exit 1
fi

if [ ! -f "aur-packages.txt" ]; then
    echo "Error: aur-packages.txt not found!"
    exit 1
fi

# Install pacman packages
echo "Installing pacman packages..."
echo "Found $(wc -l < pacman-packages.txt) pacman packages to install"
sudo pacman -S --needed - < pacman-packages.txt

# Install AUR packages
echo "Installing AUR packages..."
echo "Found $(wc -l < aur-packages.txt) AUR packages to install"
paru -S --needed - < aur-packages.txt

echo "Package installation complete!"
