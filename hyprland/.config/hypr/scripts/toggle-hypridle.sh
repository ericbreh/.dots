#!/bin/bash

# Check if hypridle is running
if pgrep -x "hypridle" > /dev/null; then
    # If running, kill it
    pkill -x "hypridle"
    echo "hypridle stopped"
    # Optional: Send notification if notify-send is available
    if command -v notify-send > /dev/null; then
        notify-send "Hypridle" "Idle inhibitor enabled" -i "security-high"
    fi
else
    # If not running, start it
    hypridle &
    echo "hypridle started"
    # Optional: Send notification if notify-send is available
    if command -v notify-send > /dev/null; then
        notify-send "Hypridle" "Idle inhibitor disabled" -i "security-low"
    fi
fi
