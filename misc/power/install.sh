#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="/tmp/dots-backup-power-$(date +%Y%m%d-%H%M%S)"

echo "Installing power management configuration files..."

# Create backup directory
mkdir -p "$BACKUP_DIR"
echo "Backup directory: $BACKUP_DIR"

# Function to safely copy with backup
safe_copy() {
    local src="$1"
    local dest="$2"
    local filename=$(basename "$dest")
    
    if [[ -f "$dest" ]]; then
        echo "Backing up existing $dest to $BACKUP_DIR/"
        cp "$dest" "$BACKUP_DIR/$filename.orig"
    fi
    
    echo "Installing $filename to $dest"
    sudo cp "$src" "$dest"
}

# Install logind configuration
safe_copy "$SCRIPT_DIR/logind.conf" "/etc/systemd/logind.conf"

# Install UPower configuration
safe_copy "$SCRIPT_DIR/UPower.conf" "/etc/UPower/UPower.conf"

echo "Power management configuration installed successfully!"
echo "Backup files saved to: $BACKUP_DIR"
echo ""
echo "To apply changes, you may need to restart services:"
echo "  sudo systemctl restart systemd-logind"
echo "  sudo systemctl restart upower"
echo ""
echo "To restore original files, run:"
echo "  sudo cp $BACKUP_DIR/logind.conf.orig /etc/systemd/logind.conf"
echo "  sudo cp $BACKUP_DIR/UPower.conf.orig /etc/UPower/UPower.conf"
