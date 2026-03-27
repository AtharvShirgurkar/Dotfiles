#!/bin/bash

LOG="/tmp/lid-debug.log"
echo "----- Lid Closed at $(date) -----" >> "$LOG"

# More robust compositor check
if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
    NUM_OUTPUTS=$(hyprctl monitors -j | jq length)
    IS_HYPRLAND=true
    echo "Compositor: Hyprland ($NUM_OUTPUTS outputs)" >> "$LOG"
else
    NUM_OUTPUTS=$(swaymsg -t get_outputs | jq length)
    IS_HYPRLAND=false
    echo "Compositor: Sway ($NUM_OUTPUTS outputs)" >> "$LOG"
fi

# Condition A: External display
if [ "$NUM_OUTPUTS" -gt 1 ]; then
    echo "Action: External display connected. Disabling eDP-1." >> "$LOG"
    if [ "$IS_HYPRLAND" = true ]; then
        hyprctl keyword monitor "eDP-1, disable"
    else
        swaymsg output eDP-1 disable
    fi
    exit 0
fi

# Condition B: Idle inhibitor
if [ -f "/tmp/waybar_inhibitor_active" ]; then
    echo "Action: Inhibitor file exists. Running DPMS off." >> "$LOG"
    if [ "$IS_HYPRLAND" = true ]; then
        hyprctl dispatch dpms off eDP-1
    else
        swaymsg output eDP-1 dpms off
    fi
    exit 0
else
    echo "Debug: /tmp/waybar_inhibitor_active NOT found!" >> "$LOG"
fi

# Else: Suspend
echo "Action: Suspending system." >> "$LOG"
systemctl suspend
