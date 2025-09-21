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

# enroll fingerprints
if command -v fprintd-enroll >/dev/null 2>&1; then
    echo "Resetting fingerprints for user $USER..."
    fprintd-delete "$USER" >/dev/null 2>&1 || true

    echo "Enrolling right thumb..."
    echo "Please scan your right thumb multiple times when prompted..."
    if fprintd-enroll -f right-thumb; then
        echo "Right thumb enrolled successfully!"
    else
        echo "Fingerprint enrollment failed or was cancelled"
    fi

    echo ""
    echo "Current enrolled fingerprints:"
    fprintd-list "$USER" 2>/dev/null || echo "No fingerprints enrolled"
else
    echo "Warning: fprintd not found. Please install it first:"
fi


echo ""
echo "To restore original files, run:"
echo "  sudo cp $BACKUP_DIR/faillock.conf.orig /etc/security/faillock.conf"
echo "  sudo cp $BACKUP_DIR/system-auth.orig /etc/pam.d/system-auth"
