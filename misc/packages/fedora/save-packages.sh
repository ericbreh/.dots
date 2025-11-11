#!/usr/bin/env bash
set -e

# Save DNF packages
dnf repoquery --userinstalled --qf '%{name}\n' | sort -u > dnf-packages.txt
echo "DNF packages saved: $(wc -l < dnf-packages.txt)"

# Save Copr repos
dnf copr list > coprs.txt
echo "Copr repos saved: $(wc -l < coprs.txt)"

# Save Flatpak apps if available
if command -v flatpak &>/dev/null; then
    flatpak list --app --columns=application > flatpak-packages.txt
    echo "Flatpak apps saved: $(wc -l < flatpak-packages.txt)"
fi
