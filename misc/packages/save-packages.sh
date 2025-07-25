#!/bin/bash

# Save all installed pacman and AUR packages to text files

echo "Saving installed packages..."

# Save AUR packages
echo "Saving AUR packages..."
pacman -Qqm > aur-packages.txt
echo "AUR packages saved to aur-packages.txt ($(wc -l < aur-packages.txt) packages)"

# Save pacman packages
echo "Saving pacman packages..."
comm -23 <(pacman -Qqe | sort) <(pacman -Qqm | sort) > pacman-packages.txt
echo "Pacman packages saved to pacman-packages.txt ($(wc -l < pacman-packages.txt) packages)"

echo "Package lists saved successfully!"
echo "Files created:"
echo "  - pacman-packages.txt: Official repository packages"
echo "  - aur-packages.txt: AUR packages"
