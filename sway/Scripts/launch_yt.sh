#!/bin/bash

# The file where your video list is stored (must match Script 1)
VIDEO_LIST_FILE="$HOME/.cache/yt_video_list.txt"

# Check if the list file exists
if [ ! -f "$VIDEO_LIST_FILE" ]; then
    notify-send "YouTube Launcher" "Video list not found. Run sync script first."
    exit 1
fi

# Use wofi to display the list and get the user's choice
# --dmenu: Reads from STDIN, prints selection to STDOUT
# --prompt: Sets a custom prompt
selected_video=$(cat "$VIDEO_LIST_FILE" | wofi --dmenu --prompt "YouTube Feed")

# Exit if the user pressed Esc (selection is empty)
if [ -z "$selected_video" ]; then
    echo "No video selected."
    exit 0
fi

# Parse the selection to get the URL
# The format is "Channel - Title | URL"
# We use cut to split the string at the "|" and get the 2nd part (the URL)
# xargs trims any leading/trailing whitespace
video_url=$(echo "$selected_video" | cut -d'|' -f2 | xargs)

# Play the video with mpv
# Add --force-window if mpv sometimes opens in the background
mpv "$video_url"
