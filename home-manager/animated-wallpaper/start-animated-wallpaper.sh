#!/usr/bin/env bash

# Define the target video path (using a common filename)
# We assume the video is named 'wallpaper.mp4' in the user's Videos directory
VIDEO_SUBPATH="Videos/wallpaper.mp4"
WALLPAPER_VIDEO="$HOME/$VIDEO_SUBPATH"

# 1. Graceful Failure Check
if [[ ! -f "$WALLPAPER_VIDEO" ]]; then
    echo "$(date): Error: Animated wallpaper video not found at $WALLPAPER_VIDEO" >&2
    exit 1
fi

# Check if MPV is already running the wallpaper to prevent duplicates
if pgrep -x "mpv" > /dev/null; then
    echo "$(date): MPV wallpaper already running." >&2
    exit 0
fi

# Determine the Root Window ID (Xorg specific)
# We use xdotool, which is provided by Nix, but its path must be available.
ROOT_WINDOW_ID=$(xdotool getroot)

# Launch mpv with appropriate flags
mpv \
    --loop \
    --no-audio \
    --no-osc \
    --no-stop-screensaver \
    --wid="$ROOT_WINDOW_ID" \
    --player-operation-mode=pseudo-gui \
    --geometry=100%:100% \
    --quiet \
    --keep-open \
    "$WALLPAPER_VIDEO" &