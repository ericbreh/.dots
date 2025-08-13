#!/bin/bash

# Device identifiers
LAPTOP_SPEAKER="alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink"
LAPTOP_MIC="alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Mic1__source"
WIRELESS_HEADPHONES="bluez_output.90_5F_7A_BB_87_46.1"
WIRELESS_MIC="bluez_input.90:5F:7A:BB:87:46"

get_best_audio_output() {
    # Check if wireless headphones are available
    if pactl list sinks short | grep -q "$WIRELESS_HEADPHONES"; then
        echo "$WIRELESS_HEADPHONES"
    else
        echo "$LAPTOP_SPEAKER"
    fi
}

get_best_audio_input() {
    # Check if wireless headphones mic is available 
    if pactl list sources short | grep -q "$WIRELESS_MIC"; then
        echo "$WIRELESS_MIC"
    else
        echo "$LAPTOP_MIC"
    fi
}

smart_audio_switch() {
    local target_sink=$(get_best_audio_output)
    local target_source=$(get_best_audio_input)
    local current_sink=$(pactl get-default-sink)
    local current_source=$(pactl get-default-source)
    
    # Only switch if needed
    if [[ "$current_sink" != "$target_sink" ]]; then
        pactl set-default-sink "$target_sink"
        echo "Audio output switched to: $target_sink"
        
        # Move existing streams
        pactl list short sink-inputs | while read -r stream; do
            streamId=$(echo "$stream" | cut -f1)
            pactl move-sink-input "$streamId" "$target_sink" 2>/dev/null
        done
    fi
    
    if [[ "$current_source" != "$target_source" ]]; then
        pactl set-default-source "$target_source"
        echo "Audio input switched to: $target_source"
        
        # Move existing streams
        pactl list short source-outputs | while read -r stream; do
            streamId=$(echo "$stream" | cut -f1)
            pactl move-source-output "$streamId" "$target_source" 2>/dev/null
        done
    fi
}

# If script is called with "monitor" argument, run in monitoring mode
if [[ "$1" == "monitor" ]]; then
    echo "$(date): Starting intelligent audio monitor"
    echo "Will automatically switch between laptop and wireless headphones"
    echo "HDMI/monitor audio will be ignored"
    
    # Initial setup
    smart_audio_switch
    
    # Monitor for changes
    pactl subscribe | while read -r event; do
        if echo "$event" | grep -q "sink\|source"; then
            echo "$(date): Audio change detected: $event"
            sleep 0.5  # Let system settle
            smart_audio_switch
        fi
    done
else
    # Single run mode
    smart_audio_switch
fi
