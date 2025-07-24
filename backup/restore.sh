#!/bin/bash

BACKUP_DIR="/run/media/ericbreh/MEMOREX/computer"
BACKUP_LIST="backup-list.txt"
DRY_RUN=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
	case $1 in
	--dry-run | -n)
		DRY_RUN=true
		shift
		;;
	--help | -h)
		echo "Usage: $0 [OPTIONS]"
		echo "Restore files from backup directory to original locations"
		echo ""
		echo "Options:"
		echo "  --dry-run, -n    Show what would be restored without actually doing it"
		echo "  --help, -h       Show this help message"
		exit 0
		;;
	*)
		echo "Unknown option: $1"
		echo "Use --help for usage information"
		exit 1
		;;
	esac
done

# Check if backup directory exists
if [[ ! -d "$BACKUP_DIR" ]]; then
	echo "Error: Backup directory $BACKUP_DIR does not exist"
	exit 1
fi

# Check if backup list exists
if [[ ! -f "$BACKUP_LIST" ]]; then
	echo "Error: Backup list file $BACKUP_LIST does not exist"
	exit 1
fi

if [[ "$DRY_RUN" == true ]]; then
	echo "DRY RUN MODE - No files will be actually restored"
	echo "=============================================="
fi

# Confirmation prompt (skip in dry-run mode)
if [[ "$DRY_RUN" == false ]]; then
	echo "WARNING: This will restore files from backup and may overwrite existing files!"
	echo "Backup directory: $BACKUP_DIR"
	read -p "Are you sure you want to continue? (y/N): " confirm
	if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
		echo "Restore cancelled"
		exit 0
	fi
fi

while read -r line; do
	# Skip empty lines and comments
	[[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue

	# Split on '=>' and trim whitespace
	src=$(echo "$line" | cut -d'=' -f1 | xargs)
	dst=$(echo "$line" | cut -d'>' -f2 | xargs)

	# Expand variables in source path
	src=$(eval echo "$src")

	backup_path="$BACKUP_DIR/$dst"

	# Check if backup exists
	if [[ ! -d "$backup_path" ]]; then
		echo "Warning: Backup $backup_path does not exist, skipping"
		continue
	fi

	echo "Restoring $backup_path to $src"

	if [[ "$DRY_RUN" == false ]]; then
		# Create parent directory if it doesn't exist
		mkdir -p "$(dirname "$src")"

		# Restore using rsync
		rsync -a --delete "$backup_path/" "$src/"

		if [[ $? -eq 0 ]]; then
			echo "✓ Successfully restored $src"
		else
			echo "✗ Failed to restore $src"
		fi
	else
		echo "  Would restore: $backup_path/ -> $src/"
	fi

done <"$BACKUP_LIST"

if [[ "$DRY_RUN" == true ]]; then
	echo ""
	echo "Dry run completed. Use without --dry-run to perform actual restore."
else
	echo ""
	echo "Restore completed!"
fi