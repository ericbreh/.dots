#!/bin/bash

echo "Saving installed packages..."

if command -v pacman &>/dev/null; then
    # Arch Linux
    echo "Detected Arch Linux"

    echo "Saving AUR packages..."
    pacman -Qqm > aur-packages.txt
    echo "AUR packages saved to aur-packages.txt ($(wc -l < aur-packages.txt) packages)"

    echo "Saving pacman packages..."
    comm -23 <(pacman -Qqe | sort) <(pacman -Qqm | sort) > pacman-packages.txt
    echo "Pacman packages saved to pacman-packages.txt ($(wc -l < pacman-packages.txt) packages)"

elif command -v dnf &>/dev/null; then
    # Fedora
    echo "Detected Fedora"

    echo "Saving user-installed dnf packages..."
    dnf repoquery --userinstalled --qf '%{name}\n' | sort -u > dnf-packages.txt
    echo "DNF packages saved to dnf-packages.txt ($(wc -l < dnf-packages.txt) packages)"

    echo "Saving enabled Copr repos..."
    dnf copr list > coprs.txt
    echo "Copr repos saved to coprs.txt ($(wc -l < coprs.txt) repos)"

    if command -v flatpak &>/dev/null; then
        echo "Saving Flatpak apps..."
        flatpak list --app --columns=application > flatpak-packages.txt
        echo "Flatpak apps saved to flatpak-packages.txt ($(wc -l < flatpak-packages.txt) apps)"
    fi
else
    echo "Error: Neither pacman nor dnf found. Unsupported system."
    exit 1
fi

echo "Package lists saved successfully!"
