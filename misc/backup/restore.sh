#!/usr/bin/env bash
set -e

if [ -z "$1" ]; then
	echo "Error: No backup source provided."
	echo "Usage: $0 /path/to/mount/point"
	exit 1
fi

MOUNT_POINT="$1"
BACKUP_DIR="$MOUNT_POINT/Computer"

if ! mountpoint -q "$MOUNT_POINT"; then
	echo "Backup drive not mounted. Exiting."
	exit 1
fi

restore() {
	local target="$1"
	local backup="$BACKUP_DIR/$2"

	if [[ ! -d "$backup" ]]; then
		echo "Warning: Backup $backup does not exist, skipping"
		return
	fi

	echo "Restoring $backup to $target"
	mkdir -p "$target"
	rsync -a --delete --partial --info=progress2,stats2 "$backup/" "$target/"
}

restore "$HOME/Github/secrets" Github/secrets
restore "$HOME/Pictures" Pictures
restore "$HOME/.dots" .dots
restore "$HOME/Documents" Documents
restore "$HOME/Movies/" Movies

restore "$HOME/.ssh" .ssh
restore "$HOME/.gnupg" .gnupg

echo "Restore completed!"

if [ -d "$HOME/.ssh" ]; then
    chmod 700 "$HOME/.ssh"
    chmod 600 "$HOME/.ssh"/{id_*,authorized_keys,config} 2>/dev/null || true
    chmod 644 "$HOME/.ssh"/{*.pub,known_hosts} 2>/dev/null || true
    echo "SSH permissions fixed"
fi

if [ -d "$HOME/.gnupg" ]; then
    chmod -R 700 "$HOME/.gnupg"
    chmod 600 "$HOME/.gnupg"/{*.gpg,*.conf} 2>/dev/null || true
    echo "GPG permissions fixed"
fi
