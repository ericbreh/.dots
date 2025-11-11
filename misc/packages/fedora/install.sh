#!/usr/bin/env bash
set -e

# Check for required files
if [ ! -f "dnf-packages.txt" ]; then
    echo "Error: dnf-packages.txt not found!"
    exit 1
fi

# Enable Copr repos if available
if [ -f "coprs.txt" ]; then
    echo "Enabling Copr repos..."
    while read -r repo; do
        [[ -n "$repo" ]] && sudo dnf copr enable -y "$repo"
    done < coprs.txt
fi

# Install DNF packages
echo "Installing $(wc -l < dnf-packages.txt) packages..."
sudo dnf install $(cat dnf-packages.txt)

# Install Flatpak apps if available
if [ -f "flatpak-packages.txt" ]; then
    echo "Installing $(wc -l < flatpak-packages.txt) Flatpak apps..."
    xargs -a flatpak-packages.txt flatpak install -y
fi
