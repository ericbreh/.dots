#!/usr/bin/env bash

# Define the directory to search. You can change this to your preferred directory.
SEARCH_DIR="$HOME"

# Use fd to find files and directories, format the output to show only filename and parent directory,
# then pass them to wofi in dmenu mode.
selected_display=$(fd --type f --type d . "$SEARCH_DIR" \
            --exclude .git --exclude node_modules --exclude .cache --exclude Utils | \
            awk -F'/' '{if (NF>1) print $(NF-1)"/"$NF" ("$0")"; else print $0" ("$0")"}' | \
            wofi --dmenu --prompt "Search Files")

# Extract the full path from the selected item (which is in parentheses)
if [ -n "$selected_display" ]; then
    # Extract the path between the last "(" and ")"
    selected=$(echo "$selected_display" | sed 's/.*(\(.*\))/\1/')
    xdg-open "$selected"
fi