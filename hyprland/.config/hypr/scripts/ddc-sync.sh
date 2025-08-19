#!/bin/bash
# Sync laptop (intel_backlight) brightness to external monitor (DDC/CI)

BUS=5                 # from `ddcutil detect`
MAX_MONITOR=75        # max brightness we want on external monitor
BACKLIGHT="/sys/class/backlight/intel_backlight"

# Read laptop brightness values
current=$(cat "$BACKLIGHT/brightness")
max=$(cat "$BACKLIGHT/max_brightness")

# Scale: laptop 0..max → monitor 0..MAX_MONITOR
percent=$(( current * MAX_MONITOR / max ))

# Clamp (safety)
if [[ $percent -lt 0 ]]; then
    percent=0
elif [[ $percent -gt $MAX_MONITOR ]]; then
    percent=$MAX_MONITOR
fi

# Apply to external monitor
ddcutil --bus=$BUS setvcp 10 $percent
