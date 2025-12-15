#!/bin/bash

# --- Configuration ---
INDEX_FILE="/home/atharv/.config/sway/Scripts/rclone_master_index.txt"
CACHE_DIR="/tmp/rclone_cache"

# Ensure cache directory exists
mkdir -p "$CACHE_DIR"

# Check if index exists
if [ ! -f "$INDEX_FILE" ]; then
    notify-send "Rclone Error" "Index file not found! Run the indexer script first."
    exit 1
fi

# --- STEP 1: GET SEARCH QUERY (Wofi) ---
# We use Wofi just to capture the keystrokes
QUERY=$(wofi --dmenu --lines 0 --prompt "Fuzzy Search..." --width 400 < /dev/null)

if [ -z "$QUERY" ]; then
    exit 0
fi

# --- STEP 2: FILTER USING FZF ---
# Instead of grep, we pipe the file into fzf using the --filter flag.
# This runs fzf non-interactively, applying its fuzzy algorithm to the list
# and returning the matches to the variable.
RESULTS=$(cat "$INDEX_FILE" | fzf --filter="$QUERY" --scheme=path)

if [ -z "$RESULTS" ]; then
    notify-send "Rclone Search" "No files found matching: $QUERY"
    exit 0
fi

# --- STEP 3: SELECT FILE (Wofi) ---
# Display the FZF filtered results in Wofi
SELECTION=$(echo "$RESULTS" | wofi --dmenu -i --lines 15 --prompt "Select File ($QUERY)..." --width 800)

if [ -z "$SELECTION" ]; then
    exit 0
fi

# --- STEP 4: LAUNCH LOGIC ---
FILENAME=$(basename "$SELECTION")
EXTENSION="${FILENAME##*.}"
EXTENSION="${EXTENSION,,}"
LOCAL_FILE="$CACHE_DIR/$FILENAME"

download_and_open() {
    APP_NAME=$1
    APP_CMD=$2
    notify-send "Rclone Launcher" "Downloading for $APP_NAME..."
    rclone copyto "$SELECTION" "$LOCAL_FILE"
    if [ $? -eq 0 ]; then
        $APP_CMD "$LOCAL_FILE" &
    else
        notify-send "Rclone Error" "Download failed!"
    fi
}

case "$EXTENSION" in
    # --- STREAMING ---
    mkv|mp4|webm|avi|mov|flv|mp3|flac|wav|ogg|m4a|m4b|ape|opus)
        notify-send "Rclone Launcher" "Streaming to MPV..."
        rclone cat "$SELECTION" | mpv --force-window - &
        ;;

    # --- PDF ---
    pdf) download_and_open "Zathura" "zathura" ;;
    
    # --- IMAGES ---
    jpg|jpeg|png|gif|webp|bmp|tiff) download_and_open "IMV" "imv" ;;
    
    # --- DOCS ---
    doc|docx|xls|xlsx|ppt|pptx|odt|ods|odp) download_and_open "LibreOffice" "libreoffice" ;;
    
    # --- TEXT ---
    txt|md|cfg|conf|ini|log|sh|json|yaml|xml) download_and_open "Mousepad" "mousepad" ;;
    
    # --- FALLBACK ---
    *) notify-send "Rclone Launcher" "Unknown file type: $EXTENSION" ;;
esac
