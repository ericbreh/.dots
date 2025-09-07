#!/bin/bash

# Check if Spotify is running
spotify_running=false

if pgrep -f "com.spotify.Client" > /dev/null || pgrep -f "flatpak.*spotify" > /dev/null || pgrep -x "spotify" > /dev/null || pgrep -x "spotify-launcher" > /dev/null; then
    spotify_running=true
fi

if [ "$spotify_running" = false ]; then
    echo "Launching Spotify..."
    hyprctl dispatch togglespecialworkspace spotify
    
    # Check if Flatpak version is available
    if flatpak list | grep -q "com.spotify.Client" && command -v flatpak > /dev/null; then
        flatpak run com.spotify.Client &
    # Check if regular spotify-launcher is available
    elif command -v spotify-launcher > /dev/null; then
        spotify-launcher &
    # Check if regular spotify is available
    elif command -v spotify > /dev/null; then
        spotify &
    else
        echo "Error: No Spotify installation found!"
        exit 1
    fi
    
    # Force move Spotify window to special workspace if it's not there
    # sleep 1
    # spotify_window=$(hyprctl clients | grep -i spotify | grep -o "0x[0-9a-f]*" | head -1)
    # if [ ! -z "$spotify_window" ]; then
    #     hyprctl dispatch movetoworkspacesilent special:spotify,address:$spotify_window
    # fi
    
else
    echo "Toggling workspace..."
    hyprctl dispatch togglespecialworkspace spotify
fi