#!/bin/bash

case "$1" in
    "audio")
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "[MUTED]"; then
            brightnessctl --device='platform::mute' set 0
        else
            brightnessctl --device='platform::mute' set 1
        fi
        ;;
    "mic")
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q "[MUTED]"; then
            brightnessctl --device='platform::micmute' set 0
        else
            brightnessctl --device='platform::micmute' set 1
        fi
        ;;
esac
