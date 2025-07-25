#!/bin/bash

# zram configuration installer
# This script installs the zram-generator configuration

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/zram-generator.conf"
TARGET_DIR="/etc/systemd"
TARGET_FILE="$TARGET_DIR/zram-generator.conf"

echo "🗜️  Installing zram configuration..."

# Check if source config exists
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "❌ Error: zram-generator.conf not found in $SCRIPT_DIR"
    exit 1
fi

# Check if running as root or with sudo
if [[ $EUID -ne 0 ]]; then
    echo "❌ Error: This script must be run as root or with sudo"
    echo "Usage: sudo $0"
    exit 1
fi

# Backup existing config if it exists
if [[ -f "$TARGET_FILE" ]]; then
    echo "📦 Backing up existing configuration to $TARGET_FILE.backup"
    cp "$TARGET_FILE" "$TARGET_FILE.backup"
fi

# Copy new configuration
echo "📋 Installing zram configuration to $TARGET_FILE"
cp "$CONFIG_FILE" "$TARGET_FILE"

# Set proper permissions
chmod 644 "$TARGET_FILE"

# Check if zram service exists and restart it
if systemctl list-unit-files | grep -q "systemd-zram-setup@.service"; then
    echo "🔄 Restarting zram service..."
    
    # Stop existing zram device if active
    if systemctl is-active --quiet systemd-zram-setup@zram0.service; then
        systemctl stop systemd-zram-setup@zram0.service
        # Turn off swap on zram device
        if swapon --show | grep -q "/dev/zram0"; then
            swapoff /dev/zram0 2>/dev/null || true
        fi
    fi
    
    # Start the service
    systemctl start systemd-zram-setup@zram0.service
    
    echo "✅ zram configuration installed successfully!"
    echo ""
    echo "📊 Current zram status:"
    zramctl 2>/dev/null || echo "zramctl not available"
    echo ""
    echo "💾 Current swap status:"
    swapon --show
else
    echo "⚠️  Warning: systemd-zram-setup service not found"
    echo "   You may need to install zram-generator package"
    echo "   Configuration has been installed but service is not active"
fi

echo ""
echo "🎉 Installation complete!"
