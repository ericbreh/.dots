#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="/tmp/dots-backup-touchscreen-$(date +%Y%m%d-%H%M%S)"

echo "Installing touchscreen configuration..."

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

# Install touchscreen disable rule
safe_copy "$SCRIPT_DIR/99-disable-touchscreen.rules" "/etc/udev/rules.d/99-disable-touchscreen.rules"

echo "Touchscreen configuration installed successfully!"
echo "Backup files saved to: $BACKUP_DIR"
echo ""
echo "To apply udev rules immediately:"
echo "  sudo udevadm control --reload-rules"
echo "  sudo udevadm trigger"
echo ""
echo "To restore original configuration:"
if [[ -f "$BACKUP_DIR/99-disable-touchscreen.rules.orig" ]]; then
    echo "  sudo cp $BACKUP_DIR/99-disable-touchscreen.rules.orig /etc/udev/rules.d/99-disable-touchscreen.rules"
else
    echo "  sudo rm /etc/udev/rules.d/99-disable-touchscreen.rules"
fi
