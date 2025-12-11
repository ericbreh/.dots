#!/usr/bin/env bash

# Toggle hyprsunset on/off
if pgrep -x "hyprsunset" >/dev/null; then
    pkill hyprsunset
    notify-send "Hyprsunset" "Blue light filter disabled" -i weather-clear-symbolic
else
    hyprsunset -t 5000 &
    notify-send "Hyprsunset" "Blue light filter enabled" -i weather-clear-night-symbolic
fi
