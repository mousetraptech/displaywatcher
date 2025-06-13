#!/bin/bash

EXT_ID="YOUR_EXTERNAL_DISPLAY_ID_HERE"
CHECK_INTERVAL=5

while true; do
  CONNECTED=$(displayplacer list | grep -c "$EXT_ID")
  STATE_FILE="$HOME/.stagehand_state"

  LAST_STATE="$(cat "$STATE_FILE" 2>/dev/null || echo "unknown")"

  if [ "$CONNECTED" -eq 0 ] && [ "$LAST_STATE" != "disconnected" ]; then
    bash "$(dirname "$0")/../handlers/on_disconnect.sh"
    echo "disconnected" > "$STATE_FILE"
  elif [ "$CONNECTED" -ge 1 ] && [ "$LAST_STATE" != "connected" ]; then
    bash "$(dirname "$0")/../handlers/on_connect.sh"
    echo "connected" > "$STATE_FILE"
  fi

  sleep $CHECK_INTERVAL
done
