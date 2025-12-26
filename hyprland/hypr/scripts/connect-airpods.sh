#!/usr/bin/env bash

AIRPODS_MAC=$(bluetoothctl devices | grep -i "airpods\|air pods" | head -1 | awk '{print $2}')

if [ -z "$AIRPODS_MAC" ]; then
    notify-send "AirPods" "No AirPods found"
    exit 1
fi

if bluetoothctl info "$AIRPODS_MAC" | grep -q "Connected: yes"; then
    echo "Disconnecting AirPods..."
    bluetoothctl disconnect "$AIRPODS_MAC"
    notify-send "AirPods" "Disconnected from AirPods"
else
    echo "Connecting to AirPods..."
    if bluetoothctl connect "$AIRPODS_MAC"; then
        notify-send "AirPods" "Connected to AirPods"
    else
        notify-send "AirPods" "Failed to connect to AirPods"
    fi
fi
