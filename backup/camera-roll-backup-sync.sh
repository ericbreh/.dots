#!/bin/bash

SRC="/run/media/ericbreh/Backup/Eric Camera Roll Backup/"
DST="/run/media/ericbreh/MEMOREX/Eric Camera Roll Backup/"

# Usage message
usage() {
  echo "Usage: $0 [--sync]"
  echo "  --sync    Actually sync files"
  echo "            Dry-run showing differences"
  exit 1
}

# Check arguments
if [[ "$1" == "--sync" ]]; then
  SYNC=true
elif [[ -z "$1" ]]; then
  SYNC=false
else
  usage
fi

# Check if source and destination directories exist
if [[ ! -d "$SRC" ]]; then
  echo "Error: Source directory does not exist: $SRC"
  exit 1
fi

if [[ ! -d "$DST" ]]; then
  echo "Warning: Destination directory does not exist: $DST"
  echo "Creating destination directory..."
  mkdir -p "$DST"
fi

if [[ "$SYNC" == false ]]; then
  echo "Running dry-run comparison..."
  rsync -avun --delete "$SRC" "$DST"
  echo "Dry-run complete. Use --sync to actually perform the sync."
else
  echo "Syncing files..."
  rsync -avu --delete "$SRC" "$DST"
  echo "Sync complete."
fi
