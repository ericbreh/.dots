#!/usr/bin/env bash

# Toggle hyprsunset on/off
# Check if hyprsunset is running
if pgrep -x "hyprsunset" >/dev/null; then
	# hyprsunset is running, kill it
	pkill hyprsunset
	notify-send "Hyprsunset" "Blue light filter disabled" -i weather-clear-symbolic
else
	# hyprsunset is not running, start it
	hyprsunset -t 5000 &
	notify-send "Hyprsunset" "Blue light filter enabled" -i weather-clear-night-symbolic
fi
