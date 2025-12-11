#!/usr/bin/env bash

SCREENSHOT_DIR=~/Pictures/Screenshots
SCREENCAST_DIR=~/Videos/Screencasts
mkdir -p "$SCREENSHOT_DIR"
mkdir -p "$SCREENCAST_DIR"

# Check if a recording is in progress
if pgrep -f "^wf-recorder" >/dev/null; then
    pkill -SIGINT -x "wf-recorder"
    notify-send "Screen recording stopped."
    exit 0
fi

OPTIONS="Screenshot a region\nRecord a region\nScreenshot full screen\nRecord full screen"
choice=$(echo -e "$OPTIONS" | wofi --dmenu --prompt "Capture Screen" --no-sort)

case "$choice" in
"Screenshot a region")
    if area=$(slurp); then
        grim -g "$area" - | tee >(wl-copy) >"$SCREENSHOT_DIR"/screenshot-"$(date +%F_%T)".png
        notify-send "Screenshot of a region taken"
    fi
    ;;
"Record a region")
    if area=$(slurp); then
        wf-recorder -g "$area" -f "$SCREENCAST_DIR"/screencast-"$(date +%F_%T)".mp4 &
        notify-send "Screen recording of a region started."
    fi
    ;;
"Screenshot full screen")
    sleep 0.5
    grim - | tee >(wl-copy) >"$SCREENSHOT_DIR"/screenshot-"$(date +%F_%T)".png
    notify-send "Screenshot of the whole screen taken"
    ;;
"Record full screen")
    wf-recorder -f "$SCREENCAST_DIR"/screencast-"$(date +%F_%T)".mp4 &
    notify-send "Screen recording of full screen started."
    ;;
esac
