#!/usr/bin/env bash

pkill -x slurp 2>/dev/null

if area=$(slurp); then
	mkdir -p ~/Pictures/Screenshots
	grim -g "$area" - | tee >(wl-copy) >~/Pictures/Screenshots/Screenshot-"$(date +%F_%T)".png
	notify-send "Screenshot of the region taken"
fi
