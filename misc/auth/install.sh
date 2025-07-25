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

# Check if fprintd is installed and enroll fingerprint
if command -v fprintd-enroll >/dev/null 2>&1; then
    echo "Setting up fingerprint authentication..."
    
    # Check if user already has fingerprints enrolled
    if fprintd-list "$USER" 2>/dev/null | grep -q "Fingerprints for user"; then
        echo "Fingerprints already enrolled for user $USER"
        fprintd-list "$USER"
        echo ""
        read -p "Do you want to enroll additional fingerprints? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "Available fingers: right-thumb, right-index-finger, right-middle-finger, right-ring-finger, right-little-finger"
            echo "                  left-thumb, left-index-finger, left-middle-finger, left-ring-finger, left-little-finger"
            read -p "Enter finger name to enroll (or press Enter to skip): " finger_name
            if [[ -n "$finger_name" ]]; then
                echo "Please scan your $finger_name multiple times when prompted..."
                fprintd-enroll -f "$finger_name" || echo "Fingerprint enrollment failed or was cancelled"
            fi
        fi
    else
        echo "No fingerprints found. Enrolling your right index finger..."
        echo "Please scan your right index finger multiple times when prompted..."
        if fprintd-enroll; then
            echo "Fingerprint enrolled successfully!"
            echo ""
            read -p "Do you want to enroll additional fingerprints for backup? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                echo "Available fingers: right-thumb, right-middle-finger, right-ring-finger, right-little-finger"
                echo "                  left-thumb, left-index-finger, left-middle-finger, left-ring-finger, left-little-finger"
                read -p "Enter finger name to enroll (or press Enter to skip): " finger_name
                if [[ -n "$finger_name" ]]; then
                    echo "Please scan your $finger_name multiple times when prompted..."
                    fprintd-enroll -f "$finger_name" || echo "Additional fingerprint enrollment failed or was cancelled"
                fi
            fi
        else
            echo "Fingerprint enrollment failed or was cancelled"
            echo "You can manually enroll fingerprints later using: fprintd-enroll"
        fi
    fi
    
    echo ""
    echo "Current enrolled fingerprints:"
    fprintd-list "$USER" 2>/dev/null || echo "No fingerprints enrolled"
else
    echo "Warning: fprintd not found. Please install fprintd package for fingerprint authentication:"
    echo "  sudo pacman -S fprintd"
fi

echo ""
echo "To restore original files, run:"
echo "  sudo cp $BACKUP_DIR/faillock.conf.orig /etc/security/faillock.conf"
echo "  sudo cp $BACKUP_DIR/system-auth.orig /etc/pam.d/system-auth"
