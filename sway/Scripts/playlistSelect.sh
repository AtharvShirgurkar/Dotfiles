#!/bin/bash

PLAYLIST_DIR="/home/atharv/Videos/Playlists"

# 1. Use find to get the list of m3u files
# 2. Use sed to strip the directory path, leaving only the filename
# 3. Pipe the list to wofi for selection
selected_file=$(find "$PLAYLIST_DIR" -maxdepth 1 -name "*.m3u" | \
    sed "s|^$PLAYLIST_DIR/||" | \
    wofi --dmenu -p "Select Playlist" \
    --hide-search=false \
    --insensitive)

# Check if a file was selected (i.e., wofi was not cancelled)
if [ -n "$selected_file" ]; then
    # Construct the full path
    FULL_PATH="$PLAYLIST_DIR/$selected_file"

    # Open the selected playlist with mpv
    mpv --playlist="$FULL_PATH" &
fi
