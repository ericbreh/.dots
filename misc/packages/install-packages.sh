#!/bin/bash

echo "Installing packages from saved lists..."

if command -v pacman &>/dev/null; then
    # Arch Linux
    echo "Detected Arch Linux"

    if [ ! -f "pacman-packages.txt" ] || [ ! -f "aur-packages.txt" ]; then
        echo "Error: pacman-packages.txt or aur-packages.txt not found!"
        exit 1
    fi

    echo "Installing pacman packages..."
    echo "Found $(wc -l < pacman-packages.txt) pacman packages to install"
    sudo pacman -S --needed - < pacman-packages.txt

    echo "Installing AUR packages..."
    echo "Found $(wc -l < aur-packages.txt) AUR packages to install"
    paru -S --needed - < aur-packages.txt

elif command -v dnf5 &>/dev/null; then
    # Fedora
    echo "Detected Fedora"

    if [ ! -f "dnf-packages.txt" ]; then
        echo "Error: dnf-packages.txt not found!"
        exit 1
    fi

    if [ -f "coprs.txt" ]; then
        echo "Enabling Copr repos..."
        while read -r repo; do
            [[ -n "$repo" ]] && sudo dnf5 copr enable -y "$repo"
        done < coprs.txt
    fi

    echo "Installing DNF packages..."
    echo "Found $(wc -l < dnf-packages.txt) packages to install"
    sudo dnf5 install $(cat dnf-packages.txt)

    if [ -f "flatpak-packages.txt" ]; then
        echo "Installing Flatpak apps..."
        echo "Found $(wc -l < flatpak-packages.txt) flatpak apps to install"
        xargs -a flatpak-packages.txt flatpak install -y
    fi
else
    echo "Error: Neither pacman nor dnf5 found. Unsupported system."
    exit 1
fi

echo "Package installation complete!"
