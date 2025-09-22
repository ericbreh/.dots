#!/bin/bash

get_status() {
    if pgrep -x "hypridle" > /dev/null; then
        # hypridle is running - idle inhibition deactivated
        echo '{"alt": "deactivated"}'
    else
        # hypridle is not running - idle inhibition activated
        echo '{"alt": "activated"}'
    fi
}

toggle_hypridle() {
    if pgrep -x "hypridle" > /dev/null; then
        # If running, kill it
        pkill -x "hypridle"
        echo "hypridle stopped" >&2
        # Send notification if notify-send is available
        if command -v notify-send > /dev/null; then
            notify-send "Hypridle" "Idle inhibitor enabled" -i caffeine-cup-full-symbolic
        fi
    else
        # If not running, start it
        hypridle &
        echo "hypridle started" >&2
        # Send notification if notify-send is available
        if command -v notify-send > /dev/null; then
            notify-send "Hypridle" "Idle inhibitor disabled" -i caffeine-cup-empty-symbolic
        fi
    fi
    
    # Signal waybar to refresh
    pkill -SIGRTMIN+8 waybar 2>/dev/null || true
}

# Handle command line arguments
case "$1" in
    "status")
        get_status
        ;;
    *)
        toggle_hypridle
        get_status
        ;;
esac
