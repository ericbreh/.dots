#!/bin/bash

# Define the directory to search. You can change this to your preferred directory.
SEARCH_DIR="$HOME"

# Use fd to find files and directories, then pass them to wofi in dmenu mode.
# After selection, open the chosen file or directory with xdg-open.
selected=$(fd --type f --type d . "$SEARCH_DIR" \
            --exclude .git --exclude node_modules --exclude .cache --exclude Utils | \
            wofi --dmenu --prompt "Search Files:")

# If a selection was made, open it.
if [ -n "$selected" ]; then
    xdg-open "$selected"
fi
