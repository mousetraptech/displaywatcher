#!/usr/bin/env bash

PLIST_PATH="$HOME/Library/LaunchAgents/com.mousetraptech.stagehand.plist"

echo "Unloading LaunchAgent..."
launchctl unload "$PLIST_PATH" 2>/dev/null

echo "Removing LaunchAgent plist..."
rm -f "$PLIST_PATH"

echo "Removing stagehand state and log files..."
rm -f "$HOME/.stagehand_state"
rm -f "$HOME/.pauseaudio.log"
rm -f /tmp/stagehand.out
rm -f /tmp/stagehand.err

echo "✅ StageHand uninstalled."
