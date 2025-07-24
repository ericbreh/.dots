#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.config/dots-backups/auth-$(date +%Y%m%d-%H%M%S)"

echo "Installing authentication configuration files..."

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

# Install faillock configuration
safe_copy "$SCRIPT_DIR/faillock.conf" "/etc/security/faillock.conf"

# Install PAM system-auth configuration
safe_copy "$SCRIPT_DIR/system-auth" "/etc/pam.d/system-auth"

echo "Authentication configuration installed successfully!"
echo "Backup files saved to: $BACKUP_DIR"
echo ""
echo "To restore original files, run:"
echo "  sudo cp $BACKUP_DIR/faillock.conf.orig /etc/security/faillock.conf"
echo "  sudo cp $BACKUP_DIR/system-auth.orig /etc/pam.d/system-auth"
