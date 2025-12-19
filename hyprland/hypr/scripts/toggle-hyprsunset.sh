#!/usr/bin/env bash

get_status() {
    if pgrep -x "hyprsunset" >/dev/null; then
        echo '{"alt": "activated", "tooltip": "Hyprsunset is active"}'
    else
        echo '{"alt": "deactivated", "tooltip": "Hyprsunset is not active"}'
    fi
}

toggle_hyprsunset() {
    if pgrep -x "hyprsunset" >/dev/null; then
        pkill hyprsunset
        notify-send "Hyprsunset" "Blue light filter disabled" -i weather-clear-symbolic
    else
        hyprsunset -t 4000 &
        notify-send "Hyprsunset" "Blue light filter enabled" -i weather-clear-night-symbolic
    fi
    pkill -SIGRTMIN+8 waybar
}

case "$1" in
"status")
    get_status
    ;;
*)
    toggle_hyprsunset
    ;;
esac
