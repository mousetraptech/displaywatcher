#!/bin/bash

PLIST_PATH="$HOME/Library/LaunchAgents/com.mousetraptech.displaywatcher.plist"

echo "Unloading LaunchAgent..."
launchctl unload "$PLIST_PATH" 2>/dev/null

echo "Removing LaunchAgent plist..."
rm -f "$PLIST_PATH"

echo "Removing displaywatcher state and log files..."
rm -f "$HOME/.displaywatcher_state"
rm -f "$HOME/.pauseaudio.log"
rm -f /tmp/displaywatcher.out
rm -f /tmp/displaywatcher.err

echo "✅ DisplayWatcher uninstalled."
