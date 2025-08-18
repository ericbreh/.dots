#!/bin/bash

set -e

MOUNT_POINT=~/iPhone
BACKUP_DIR=~/Pictures/iPhoneBackup

# Create directories if they don't exist
mkdir -p "$MOUNT_POINT"
mkdir -p "$BACKUP_DIR"

echo "[*] Pairing with iPhone..."
idevicepair pair

echo "[*] Mounting iPhone..."
ifuse "$MOUNT_POINT"

echo "[*] Backing up photos..."
rsync -a --ignore-existing --info=stats2 --prune-empty-dirs \
  --include='*/' \
  --include='*.heic' --include='*.HEIC' \
  --include='*.jpg' --include='*.JPG' \
  --include='*.jpeg' --include='*.JPEG' \
  --include='*.png' --include='*.PNG' \
  --include='*.mov' --include='*.MOV' \
  --include='*.mp4' --include='*.MP4' \
  --exclude='*' \
  "$MOUNT_POINT/DCIM/" "$BACKUP_DIR/"


echo "[*] Unmounting iPhone..."
fusermount -u "$MOUNT_POINT"

echo "[✓] Backup complete. Files are in $BACKUP_DIR"

