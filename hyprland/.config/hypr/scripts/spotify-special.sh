#!/bin/bash

# Script to launch Spotify in special workspace and toggle special workspace

# Check if Spotify is running (look for the actual spotify binary)
if ! pgrep -x spotify > /dev/null && ! pgrep -f "spotify-launcher" > /dev/null; then
    # Spotify is not running, launch it in special workspace
    echo "Launching Spotify..."
    hyprctl dispatch exec "[workspace special:spotify] spotify-launcher"
    # Wait for Spotify to start and show the workspace
    sleep 3
    hyprctl dispatch togglespecialworkspace spotify
else
    # Spotify is already running, just toggle the workspace
    echo "Toggling workspace..."
    hyprctl dispatch togglespecialworkspace spotify
fi
