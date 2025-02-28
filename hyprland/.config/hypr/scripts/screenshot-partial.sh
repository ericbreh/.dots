#! /bin/bash
if area=$(slurp); then grim -g "$area" - | tee >(wl-copy) >~/Pictures/Screenshots/Screenshot-"$(date +%F_%T)".png && notify-send "Screenshot of the region taken"; fi