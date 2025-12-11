#!/usr/bin/env bash
SCREENSHOT_DIR=~/Pictures/Screenshots
mkdir -p "$SCREENSHOT_DIR"
grim - | tee >(wl-copy) >"$SCREENSHOT_DIR"/screenshot-"$(date +%F_%T)".png
notify-send "Screenshot of the whole screen taken"