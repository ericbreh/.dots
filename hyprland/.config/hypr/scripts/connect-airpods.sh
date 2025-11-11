#!/usr/bin/env bash

# AirPods Toggle Script
# Toggles connection to AirPods

# Find AirPods MAC address
AIRPODS_MAC=$(bluetoothctl devices | grep -i "airpods\|air pods" | head -1 | awk '{print $2}')

if [ -z "$AIRPODS_MAC" ]; then
	echo "No AirPods found in paired devices"
	echo "Available devices:"
	bluetoothctl devices
	exit 1
fi

# Check if AirPods are currently connected
if bluetoothctl info "$AIRPODS_MAC" | grep -q "Connected: yes"; then
	# Disconnect AirPods
	echo "Disconnecting AirPods..."
	if bluetoothctl disconnect "$AIRPODS_MAC"; then
		notify-send "AirPods" "Disconnected from AirPods" -i bluetooth-disabled-symbolic
	else
		notify-send "AirPods" "Failed to disconnect AirPods" -i error
	fi
else
	# Connect to AirPods
	echo "Connecting to AirPods..."
	if bluetoothctl connect "$AIRPODS_MAC"; then
		notify-send "AirPods" "Connected to AirPods" -i bluetooth-active-symbolic

		# Switch audio output to AirPods
		sleep 2
		BT_SINK=$(pactl list short sinks | grep bluez | head -1 | awk '{print $2}')
		if [ ! -z "$BT_SINK" ]; then
			pactl set-default-sink "$BT_SINK"
			echo "Audio output switched to AirPods"
		fi
	else
		notify-send "AirPods" "Failed to connect to AirPods" -i error
	fi
fi
