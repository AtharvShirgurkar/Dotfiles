#!/bin/bash

# A script to close only windows on the "tv" workspace and launch a new one.
# Usage: tv-launcher.sh "application-command-here"

APP_TO_LAUNCH=$1
# We no longer need BAR_CLASS because we only target the "tv" workspace.
TV_WORKSPACE="tv" 

if [ -z "$APP_TO_LAUNCH" ]; then
    echo "Error: No application command provided."
    exit 1
fi

# =========================================================================
# 1. Kill only the windows on the dedicated TV workspace.
# =========================================================================

# This command selects all containers on the workspace named "tv" and kills them.
# The `swaymsg` command is: [criteria] command
swaymsg "[workspace=\"$TV_WORKSPACE\"] kill"

# Optional: Add a small delay to allow the kill signal to process before launching the new app
sleep 0.5

# =========================================================================
# 2. Launch the application on the TV workspace and set it to fullscreen
# (This section remains the same)
# =========================================================================

# We need to extract the executable name to correctly target the window with [app_id]
EXECUTABLE_NAME="$(basename "$(echo "$APP_TO_LAUNCH" | awk '{print $1}')")"

swaymsg "workspace $TV_WORKSPACE; \
         exec --no-startup-id \"$APP_TO_LAUNCH\"; \
         [app_id=\"$EXECUTABLE_NAME\"] \
         fullscreen enable, border none"

exit 0
