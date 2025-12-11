#!/usr/bin/env bash

if pgrep -f "^waybar$" > /dev/null; then
    pkill -f "^waybar$"
else
    waybar &
fi
