#!/bin/bash

# Define the config file and the directory to search in
CONFIG_FILE="$HOME/.config/waybar/config.jsonc"
HWMON_DIR="/sys/devices/platform/coretemp.0/hwmon/"

# Find the full path to temp1_input
TEMP_PATH=$(find "$HWMON_DIR" -name "temp1_input" | head -n 1)

# Check if a valid path was found
if [ -z "$TEMP_PATH" ]; then
    echo "Error: Could not find temp1_input file in $HWMON_DIR"
    exit 1
fi

# Escape the slashes in the path for sed
ESCAPED_PATH=$(echo "$TEMP_PATH" | sed 's/\//\\\//g')

# Use sed to replace the hwmon-path in the config file
sed -i "s/\"hwmon-path\": \".*\"/\"hwmon-path\": \"$ESCAPED_PATH\"/" "$CONFIG_FILE"

echo "Updated hwmon-path in $CONFIG_FILE to: $TEMP_PATH"
