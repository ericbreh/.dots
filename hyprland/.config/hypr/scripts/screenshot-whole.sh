#! /bin/bash
grim - | wl-copy && wl-paste >~/Pictures/Screenshots/screenshot-"$(date +%F_%T)".png && notify-send "Screenshot of the whole screen taken"