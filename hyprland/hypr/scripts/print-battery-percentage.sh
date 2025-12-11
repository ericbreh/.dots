#!/usr/bin/env bash
BATTERY_PERCENT=$(cat /sys/class/power_supply/BAT0/capacity)
ON_AC_POWER=$(cat /sys/class/power_supply/BAT0/status)

if [ "$BATTERY_PERCENT" -ge 90 ]; then
    DISCHARGING_ICON="󰁹"
elif [ "$BATTERY_PERCENT" -ge 80 ]; then
    DISCHARGING_ICON="󰂂"
elif [ "$BATTERY_PERCENT" -ge 70 ]; then
    DISCHARGING_ICON="󰂁"
elif [ "$BATTERY_PERCENT" -ge 60 ]; then
    DISCHARGING_ICON="󰂀"
elif [ "$BATTERY_PERCENT" -ge 50 ]; then
    DISCHARGING_ICON="󰁿"
elif [ "$BATTERY_PERCENT" -ge 40 ]; then
    DISCHARGING_ICON="󰁾"
elif [ "$BATTERY_PERCENT" -ge 30 ]; then
    DISCHARGING_ICON="󰁽"
elif [ "$BATTERY_PERCENT" -ge 20 ]; then
    DISCHARGING_ICON="󰁼"
elif [ "$BATTERY_PERCENT" -ge 10 ]; then
    DISCHARGING_ICON="󰁻"
else
    DISCHARGING_ICON="󰁺"
fi

if [ "$ON_AC_POWER" == "Discharging" ]; then
    echo "$BATTERY_PERCENT% $DISCHARGING_ICON"
else
    echo "$BATTERY_PERCENT% 󰂄"
fi
