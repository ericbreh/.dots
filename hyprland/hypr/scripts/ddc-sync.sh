#!/usr/bin/env bash
# Sync laptop (intel_backlight) brightness to external monitor (DDC/CI)

BUS=$(ddcutil detect | awk '/Display [0-9]+/{display=1} display && /I2C bus:/ {gsub("/dev/i2c-", "", $3); print $3; exit}')
if [[ -z "$BUS" ]]; then
    BUS=5 # fallback if detection fails
fi
MAX_MONITOR=100
MIN_MONITOR=0
BACKLIGHT="/sys/class/backlight/intel_backlight"

# Read laptop brightness values
current=$(cat "$BACKLIGHT/brightness")
max=$(cat "$BACKLIGHT/max_brightness")

percent=$(( current * (MAX_MONITOR - MIN_MONITOR) / max + MIN_MONITOR ))

# Clamp
if [[ $percent -lt $MIN_MONITOR ]]; then
    percent=$MIN_MONITOR
elif [[ $percent -gt $MAX_MONITOR ]]; then
    percent=$MAX_MONITOR
fi

# Apply to external monitor
ddcutil --bus=$BUS setvcp 10 $percent
