#!/usr/bin/env bash

get_status() {
    if systemctl --user is-active --quiet hypridle; then
        echo '{"alt": "activated", "tooltip": "Hypridle is active"}'
    else
        echo '{"alt": "deactivated", "tooltip": "Hypridle is not active"}'
    fi
}

toggle_hypridle() {
    if systemctl --user is-active --quiet hypridle; then
        systemctl --user stop hypridle
        notify-send "Hypridle" "Idle inhibitor enabled"
    else
        systemctl --user start hypridle
        notify-send "Hypridle" "Idle inhibitor disabled"
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
