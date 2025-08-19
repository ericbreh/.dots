#!/bin/bash

MOUNT_POINT="/run/media/ericbreh/MEMOREX"
BACKUP_DIR="$MOUNT_POINT/computer"

backup() {
	mkdir -p "$BACKUP_DIR/$2"
	if [ -n "$3" ]; then
		echo "Backing up $1 to $BACKUP_DIR/$2 excluding $3"
		rsync -a --delete --info=stats2 --exclude="$3" "$1" "$BACKUP_DIR/$2"
	else
		echo "Backing up $1 to $BACKUP_DIR/$2"
		rsync -a --delete --info=stats2 "$1" "$BACKUP_DIR/$2"
	fi

}

if ! mountpoint -q $MOUNT_POINT; then
	echo "Backup drive not mounted. Exiting."
	exit 1
fi

backup "$HOME/Github/secrets/" Github/secrets
backup "$HOME/Pictures/" Pictures "Screenshots"
backup "$HOME/.ssh/" .ssh
backup "$HOME/.gnupg/" .gnupg
backup "$HOME/.dots/" .dots
backup "$HOME/Documents/" Documents