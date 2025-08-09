#!/bin/bash

# toggle-mute.sh <audio|mic> [sync]
# Without the optional second arg (or anything other than 'sync'), this script
# toggles mute and updates the corresponding LED.
# With 'sync', it ONLY updates the LED to reflect the CURRENT mute state. This
# lets external tools (e.g. swayosd-client) perform the actual mute toggle while
# we just refresh LEDs.

TARGET=$1
MODE=$2  # 'sync' to only refresh LED state

case "$TARGET" in
    "audio")
        if [[ "$MODE" != "sync" ]]; then
            wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        fi
        if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "[MUTED]"; then
            brightnessctl --device='platform::mute' set 0
        else
            brightnessctl --device='platform::mute' set 1
        fi
        ;;
    "mic")
        if [[ "$MODE" != "sync" ]]; then
            wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        fi
        if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q "[MUTED]"; then
            brightnessctl --device='platform::micmute' set 0
        else
            brightnessctl --device='platform::micmute' set 1
        fi
        ;;
    *)
        echo "Usage: $0 <audio|mic> [sync]" >&2
        exit 1
        ;;
esac
