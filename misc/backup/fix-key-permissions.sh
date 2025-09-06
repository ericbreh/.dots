#!/bin/bash

# Script to fix SSH and GPG key permissions after restore from backup

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if directories exist
SSH_DIR="$HOME/.ssh"
GPG_DIR="$HOME/.gnupg"

# Fix SSH permissions
if [ -d "$SSH_DIR" ]; then
    print_status "Fixing SSH permissions..."
    
    # Set SSH directory permissions
    chmod 700 "$SSH_DIR"
    print_status "Set $SSH_DIR to 700"
    
    # Fix private key permissions (common private key files)
    for key_file in "$SSH_DIR/id_rsa" "$SSH_DIR/id_ed25519" "$SSH_DIR/id_ecdsa" "$SSH_DIR/id_dsa"; do
        if [ -f "$key_file" ]; then
            chmod 600 "$key_file"
            print_status "Set $(basename "$key_file") to 600"
        fi
    done
    
    # Fix public key permissions
    for pub_file in "$SSH_DIR"/*.pub; do
        if [ -f "$pub_file" ]; then
            chmod 644 "$pub_file"
            print_status "Set $(basename "$pub_file") to 644"
        fi
    done
    
    # Fix authorized_keys if it exists
    if [ -f "$SSH_DIR/authorized_keys" ]; then
        chmod 600 "$SSH_DIR/authorized_keys"
        print_status "Set authorized_keys to 600"
    fi
    
    # Fix config file if it exists
    if [ -f "$SSH_DIR/config" ]; then
        chmod 600 "$SSH_DIR/config"
        print_status "Set config to 600"
    fi
    
    # Fix known_hosts if it exists
    if [ -f "$SSH_DIR/known_hosts" ]; then
        chmod 644 "$SSH_DIR/known_hosts"
        print_status "Set known_hosts to 644"
    fi
    
    print_success "SSH permissions fixed!"
else
    print_warning "SSH directory $SSH_DIR not found"
fi

echo ""

# Fix GPG permissions
if [ -d "$GPG_DIR" ]; then
    print_status "Fixing GPG permissions..."
    
    # Set GPG directory permissions
    chmod 700 "$GPG_DIR"
    print_status "Set $GPG_DIR to 700"
    
    # Fix private keys directory
    if [ -d "$GPG_DIR/private-keys-v1.d" ]; then
        chmod 700 "$GPG_DIR/private-keys-v1.d"
        print_status "Set private-keys-v1.d to 700"
        
        # Fix individual private key files
        for key_file in "$GPG_DIR/private-keys-v1.d"/*.key; do
            if [ -f "$key_file" ]; then
                chmod 600 "$key_file"
                print_status "Set $(basename "$key_file") to 600"
            fi
        done
    fi
    
    # Fix public keys directory
    if [ -d "$GPG_DIR/public-keys.d" ]; then
        chmod 700 "$GPG_DIR/public-keys.d"
        print_status "Set public-keys.d to 700"
    fi
    
    # Fix openpgp-revocs directory
    if [ -d "$GPG_DIR/openpgp-revocs.d" ]; then
        chmod 700 "$GPG_DIR/openpgp-revocs.d"
        print_status "Set openpgp-revocs.d to 700"
    fi
    
    # Fix trust database
    if [ -f "$GPG_DIR/trustdb.gpg" ]; then
        chmod 600 "$GPG_DIR/trustdb.gpg"
        print_status "Set trustdb.gpg to 600"
    fi
    
    # Fix common GPG files
    for gpg_file in "$GPG_DIR"/*.gpg "$GPG_DIR"/*.conf; do
        if [ -f "$gpg_file" ]; then
            chmod 600 "$gpg_file"
            print_status "Set $(basename "$gpg_file") to 600"
        fi
    done
    
    print_success "GPG permissions fixed!"
else
    print_warning "GPG directory $GPG_DIR not found"
fi

echo ""
print_success "All key permissions have been fixed!"

# Optional: Test SSH and GPG functionality
echo ""
print_status "Testing SSH and GPG functionality..."

# Test SSH agent
if command -v ssh-add >/dev/null 2>&1; then
    if ssh-add -l >/dev/null 2>&1; then
        print_success "SSH agent is running and has keys loaded"
    else
        print_warning "SSH agent is running but no keys are loaded. You may need to run 'ssh-add' to add your keys."
    fi
else
    print_warning "ssh-add command not found"
fi

# Test GPG
if command -v gpg >/dev/null 2>&1; then
    if gpg --list-secret-keys >/dev/null 2>&1; then
        print_success "GPG can access private keys"
    else
        print_warning "GPG may have issues accessing private keys"
    fi
else
    print_warning "gpg command not found"
fi

echo ""
print_status "Script completed successfully!"
