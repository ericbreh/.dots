#!/bin/bash
set -e

if [ -z "$1" ]; then
	echo "Error: No backup destination provided."
	echo "Usage: $0 /path/to/mount/point"
	exit 1
fi

MOUNT_POINT="$1"
BACKUP_DIR="$MOUNT_POINT/computer"

if ! mountpoint -q $MOUNT_POINT; then
	echo "Backup drive not mounted. Exiting."
	exit 1
fi

backup() {
	local source="$1"
	local dest="$BACKUP_DIR/$2"
	local exclude="$3"

	mkdir -p "$dest"

	if [ -n "$exclude" ]; then
		echo "Backing up $source to $dest (excluding $exclude)"
		rsync -a --delete --partial --info=progress2,stats2 --exclude="$exclude" "$source" "$dest"
	else
		echo "Backing up $source to $dest"
		rsync -a --delete --partial --info=progress2,stats2 "$source" "$dest"
	fi

}

mkdir -p "$BACKUP_DIR"

backup "$HOME/Github/secrets/" Github/secrets
backup "$HOME/Pictures/" Pictures "Screenshots"
backup "$HOME/.ssh/" .ssh
backup "$HOME/.gnupg/" .gnupg
backup "$HOME/.dots/" .dots
backup "$HOME/Documents/" Documents

echo "Backup completed!"
