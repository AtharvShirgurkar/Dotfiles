#!/bin/bash

STATE_FILE="/tmp/waybar_inhibitor_active"

# 1. Handle the toggle action when clicked
if [ "$1" == "toggle" ]; then
    if [ -f "$STATE_FILE" ]; then
        # Deactivate
        rm -f "$STATE_FILE"
        pkill -CONT swayidle # Resume normal swayidle behavior
    else
        # Activate
        touch "$STATE_FILE"
        pkill -STOP swayidle # Pause swayidle to prevent screen blanking
    fi
    # Tell Waybar to update the module instantly (matches the signal in config)
    pkill -RTMIN+8 waybar
    exit 0
fi

# 2. Output the current state for Waybar (JSON format)
if [ -f "$STATE_FILE" ]; then
    echo '{"text": "", "class": "active", "tooltip": "Inhibitor Active (Lid & Idle)"}'
else
    echo '{"text": "", "class": "inactive", "tooltip": "Inhibitor Inactive"}'
fi
