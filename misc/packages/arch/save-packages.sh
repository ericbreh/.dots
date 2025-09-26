#!/bin/bash
set -e

# Save AUR packages
pacman -Qqm | grep -v -- "-debug" > aur-packages.txt
echo "AUR packages saved: $(wc -l < aur-packages.txt)"

# Save pacman packages (excluding AUR)
comm -23 <(pacman -Qqe | sort) <(pacman -Qqm | sort) > pacman-packages.txt
echo "Pacman packages saved: $(wc -l < pacman-packages.txt)"

