#!/usr/bin/env bash

get_status() {
    if pgrep -x "hypridle" >/dev/null; then
        echo '{"alt": "activated", "tooltip": "Hypridle is active"}'
    else
        echo '{"alt": "deactivated", "tooltip": "Hypridle is not active"}'
    fi
}

toggle_hypridle() {
    if pgrep -x "hypridle" >/dev/null; then
        pkill -x "hypridle"
        notify-send "Hypridle" "Idle inhibitor enabled" -i weather-clear-symbolic
    else
        hypridle &
        notify-send "Hypridle" "Idle inhibitor disabled" -i weather-clear-night-symbolic
    fi
    pkill -SIGRTMIN+8 waybar
}

case "$1" in
"status")
    get_status
    ;;
*)
    toggle_hypridle
    ;;
esac
