#!/bin/bash
# Sync laptop (intel_backlight) brightness to external monitor (DDC/CI)

BUS=5                 # from `ddcutil detect`
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
