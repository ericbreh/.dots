#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo cp "$SCRIPT_DIR/faillock.conf" "/etc/security/faillock.conf"
sudo cp "$SCRIPT_DIR/system-auth" "/etc/pam.d/system-auth"

# enroll fingerprints
if command -v fprintd-enroll >/dev/null 2>&1; then
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
