#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing git configuration..."

# Copy .gitconfig to home directory
echo "Installing .gitconfig to ~/.gitconfig"
cp "$SCRIPT_DIR/.gitconfig" ~/.gitconfig

echo "Git configuration installed successfully!"
echo ""
echo "Current git config:"
git config --list --show-scope | grep "file:$HOME/.gitconfig" || echo "No user config found"
