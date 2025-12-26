#!/usr/bin/env bash

SEARCH_DIR="$HOME"

selected_path=$(fd . "$SEARCH_DIR" \
    --exclude .git --exclude node_modules --exclude .cache |
    sort | wofi --dmenu --prompt "Search Files" -i)

if [ -n "$selected_path" ]; then
    xdg-open "$selected_path"
fi
