#!/bin/bash

# Determine the install path dynamically
INSTALL_DIR="$(cd "$(dirname "$0")" && pwd)"
PLIST_SRC="$INSTALL_DIR/LaunchAgents/com.mousetraptech.displaywatcher.plist"
PLIST_DEST="$HOME/Library/LaunchAgents/com.mousetraptech.displaywatcher.plist"

echo "Installing DisplayWatcher from: $INSTALL_DIR"

# Make all scripts executable
chmod +x "$INSTALL_DIR/scripts/"*.sh "$INSTALL_DIR/handlers/"*.sh

# Copy and update the .plist
cp "$PLIST_SRC" "$PLIST_DEST"

/usr/libexec/PlistBuddy -c "Delete :ProgramArguments" "$PLIST_DEST" 2>/dev/null
/usr/libexec/PlistBuddy -c "Add :ProgramArguments array" "$PLIST_DEST"
/usr/libexec/PlistBuddy -c "Add :ProgramArguments:0 string /bin/bash" "$PLIST_DEST"
/usr/libexec/PlistBuddy -c "Add :ProgramArguments:1 string $INSTALL_DIR/scripts/displaywatcher.sh" "$PLIST_DEST"

# Load the LaunchAgent
launchctl unload "$PLIST_DEST" 2>/dev/null
launchctl load "$PLIST_DEST"

echo "✅ DisplayWatcher installed and loaded."
