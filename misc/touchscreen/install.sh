#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing touchscreen disable rule..."

# Install touchscreen disable rule
sudo cp "$SCRIPT_DIR/99-disable-touchscreen.rules" "/etc/udev/rules.d/99-disable-touchscreen.rules"

echo "Applying udev rules..."
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "Touchscreen disabled!"
