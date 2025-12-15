#!/bin/bash

# This script mounts an rclone remote with minimal caching.

# --- VARIABLES ---
REMOTE_NAME="db-ab10"
REMOTE_PATH="Classical Music/Herbert von Karajan, BPO - Tchaikovsky - Symphonies Nos. 1-6 (2016) [24-96] re/"
MOUNT_POINT="/home/atharv/Music/Tchaikovsky Symphonies"

# --- MOUNT COMMAND ---
rclone mount \
  "$REMOTE_NAME:$REMOTE_PATH" \
  "$MOUNT_POINT" \
  --read-only \
  --vfs-cache-mode writes \
  --dir-cache-time 12h \
  --buffer-size 16M \
  --daemon
