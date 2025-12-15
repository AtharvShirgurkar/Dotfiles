#!/bin/bash

# --- Configuration ---
# Add your channel URLs here. Go to a channel's "Videos" tab and copy the URL.
CHANNELS_URLS=(
    "https://www.youtube.com/@SomeTechChannel/videos"
    "https://www.youtube.com/@AnotherFavoriteChannel/videos"
    "https://www.youtube.com/@MusicChannel/videos"
)

# Number of recent videos to fetch from each channel
NUM_VIDEOS=10

# The file where your video list will be stored
VIDEO_LIST_FILE="$HOME/.cache/yt_video_list.txt"

# --- Script ---
echo "Syncing YouTube feed..."

# Clear the old list
> "$VIDEO_LIST_FILE"

# Loop through each channel URL
for url in "${CHANNELS_URLS[@]}"; do
    # Use yt-dlp to get the latest videos
    # --playlist-end: Limits how many videos to check
    # --print: Prints a custom string. We use "Channel - Title | URL"
    # This format is easy for wofi to show and for our launcher to parse.
    yt-dlp --playlist-end $NUM_VIDEOS \
           --print "%(channel)s - %(title)s | %(webpage_url)s" \
           "$url" >> "$VIDEO_LIST_FILE"
done

# Optional: Send a notification when done
notify-send "YouTube Sync" "Feed updated successfully."

echo "Sync complete."
