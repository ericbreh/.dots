#!/bin/bash
set -e

# Fix SSH permissions
if [ -d "$HOME/.ssh" ]; then
    chmod 700 "$HOME/.ssh"
    chmod 600 "$HOME/.ssh"/{id_*,authorized_keys,config} 2>/dev/null || true
    chmod 644 "$HOME/.ssh"/{*.pub,known_hosts} 2>/dev/null || true
    echo "SSH permissions fixed"
fi

# Fix GPG permissions  
if [ -d "$HOME/.gnupg" ]; then
    chmod -R 700 "$HOME/.gnupg"
    chmod 600 "$HOME/.gnupg"/{*.gpg,*.conf} 2>/dev/null || true
    echo "GPG permissions fixed"
fi
