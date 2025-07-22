#!/bin/bash

set -e

SRC_DIR="$1"
DEST_ROOT="$2"

if [ -z "$SRC_DIR" ] || [ -z "$DEST_ROOT" ]; then
  echo "Usage: $0 /path/to/source /path/to/destination"
  exit 1
fi

if [ ! -d "$SRC_DIR" ]; then
  echo "Error: Source directory '$SRC_DIR' does not exist."
  exit 1
fi

mkdir -p "$DEST_ROOT/no_date"

echo "Sorting photos/videos..."

# Copy and organize files
exiftool -r -ext jpg -ext jpeg -ext png -ext heic -ext mov -ext mp4 \
  -d "$DEST_ROOT/%Y/%m" \
  '-directory<CreateDate' \
  '-directory<DateTimeOriginal' \
  '-directory<MediaCreateDate' \
  -if '$CreateDate or $DateTimeOriginal or $MediaCreateDate' \
  -preserve \
  -o "$DEST_ROOT" \
  "$SRC_DIR"

# Files without date metadata
echo "Copying files without date metadata to $DEST_ROOT/no_date..."
find "$SRC_DIR" \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.heic' -o -iname '*.mov' -o -iname '*.mp4' \) \
  -type f ! -exec exiftool -q -DateTimeOriginal -S {} \; | while read -r file; do
    has_date=$(exiftool -q -CreateDate -DateTimeOriginal -MediaCreateDate -s3 "$file" | grep -v '^$' || true)
    if [ -z "$has_date" ]; then
      cp -n "$file" "$DEST_ROOT/no_date/"
    fi
done

echo "Done."
