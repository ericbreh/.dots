#!/bin/bash

MOUNT_POINT="/run/media/ericbreh/MEMOREX"
BACKUP_DIR="$MOUNT_POINT/computer"

restore() {
    local target="$1"
    local backup="$BACKUP_DIR/$2"

    if [[ ! -d "$backup" ]]; then
        echo "Warning: Backup $backup does not exist, skipping"
        return
    fi

    echo "Restoring $backup to $target"
    mkdir -p "$target"
    rsync -a --delete --info=stats2 "$backup/" "$target/"
}

if ! mountpoint -q "$MOUNT_POINT"; then
    echo "Backup drive not mounted. Exiting."
    exit 1
fi

restore "$HOME/Github/secrets" Github/secrets
restore "$HOME/Pictures" Pictures
restore "$HOME/.ssh" .ssh
restore "$HOME/.gnupg" .gnupg
restore "$HOME/.dots" .dots
restore "$HOME/Documents" Documents

echo "Restore completed!"
