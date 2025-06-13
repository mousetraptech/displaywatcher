#!/usr/bin/env bash

set -e

STAGEHAND_DIR="$HOME/.stagehand"
mkdir -p "$STAGEHAND_DIR/presets"

DISPLAY_ID_FILE="$STAGEHAND_DIR/display_id"
STATE_FILE="$STAGEHAND_DIR/state"
HANDLER_DIR="$(cd "$(dirname "$0")/../handlers" && pwd)"
CHECK_INTERVAL=5

# Load saved external display ID
if [[ ! -f "$DISPLAY_ID_FILE" ]]; then
  echo "❌ No display ID found. Please reinstall StageHand."
  exit 1
fi

EXT_ID=$(cat "$DISPLAY_ID_FILE")

while true; do
  CONNECTED=$(displayplacer list | grep -c "$EXT_ID")
  LAST_STATE=$(cat "$STATE_FILE" 2>/dev/null || echo "unknown")

  if [[ "$CONNECTED" -eq 0 && "$LAST_STATE" != "disconnected" ]]; then
    bash "$HANDLER_DIR/on_disconnect.sh"
    echo "disconnected" > "$STATE_FILE"
  elif [[ "$CONNECTED" -ge 1 && "$LAST_STATE" != "connected" ]]; then
    bash "$HANDLER_DIR/on_connect.sh"
    echo "connected" > "$STATE_FILE"
  fi

  sleep $CHECK_INTERVAL
done