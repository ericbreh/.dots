#!/usr/bin/env bash

TMP_FILE="/tmp/hyprsunset_on"

get_status() {
    if [ -f "$TMP_FILE" ]; then
        echo '{"alt": "activated", "tooltip": "Hyprsunset is active"}'
    else
        echo '{"alt": "deactivated", "tooltip": "Hyprsunset is not active"}'
    fi
}

toggle_hyprsunset() {
    pkill hyprsunset
    if [ -f "$TMP_FILE" ]; then
        hyprsunset -t 6500 >/dev/null 2>&1 &
        rm "$TMP_FILE"
        notify-send "Hyprsunset" "Blue light filter disabled"
    else
        hyprsunset -t 4000 >/dev/null 2>&1 &
        touch "$TMP_FILE"
        notify-send "Hyprsunset" "Blue light filter enabled"
    fi
    disown
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
