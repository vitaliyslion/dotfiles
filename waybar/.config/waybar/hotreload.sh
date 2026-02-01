#!/bin/bash

# Define the directory to watch
CONFIG_DIR="$HOME/.config/waybar"

echo "Watching for changes in $CONFIG_DIR..."

# -m: monitor mode (don't exit after one event)
# -r: recursive (watch subdirectories)
# -e: events to listen for (modify, create, delete)
inotifywait -m -r -e modify,create,delete --format '%f' "$CONFIG_DIR" | while read FILE; do
  # Check if the changed file is a .css or .json/.jsonc file
  if [[ "$FILE" == *.css ]] || [[ "$FILE" == *.json ]] || [[ "$FILE" == *.jsonc ]]; then
    echo "Detected change in $FILE. Reloading Waybar..."
    killall waybar
    waybar &
  fi
done
