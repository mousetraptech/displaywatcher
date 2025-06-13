#!/bin/bash

log() { echo "🛠️  $1"; }

set -e

# Check for displayplacer
if ! command -v displayplacer >/dev/null 2>&1; then
  log "❌ Error: displayplacer is not installed."
  log "➡️  Please install it using: brew install displayplacer"
  exit 1
fi

# Paths
LAUNCH_AGENTS="$HOME/Library/LaunchAgents"
mkdir -p "$LAUNCH_AGENTS"

INSTALL_DIR="$(cd "$(dirname "$0")" && pwd)"
PLIST_SRC="$INSTALL_DIR/launchd/com.mousetraptech.stagehand.plist"
PLIST_DEST="$LAUNCH_AGENTS/com.mousetraptech.stagehand.plist"
STAGEHAND_DIR="$HOME/.stagehand"
DISPLAY_ID_FILE="$STAGEHAND_DIR/display_id"

# Ensure config directory exists
mkdir -p "$STAGEHAND_DIR"

log "📦 Installing StageHand from: $INSTALL_DIR"

# Extract external display ID
EXT_ID=$(displayplacer list | grep 'external' | head -n 1 | awk '{print $2}' | tr -d '"')
if [[ -z "$EXT_ID" ]]; then
  log "⚠️  Could not detect external display. You may need to connect it and rerun install."
  exit 1
fi

echo "$EXT_ID" > "$DISPLAY_ID_FILE"
log "🧬 Saved external display ID: $EXT_ID"

# Make scripts executable
chmod +x "$INSTALL_DIR"/scripts/*.sh "$INSTALL_DIR"/scripts/stagehand "$INSTALL_DIR"/handlers/*.sh 2>/dev/null || log "No scripts found to chmod"
log "🔐 Scripts made executable."

mkdir -p ~/bin
cp scripts/stagehand ~/bin/
export PATH="$HOME/bin:$PATH"
log "📎 CLI script linked to ~/bin/stagehand"

# Copy and update LaunchAgent
cp "$PLIST_SRC" "$PLIST_DEST"
log "📄 LaunchAgent copied to $PLIST_DEST"

/usr/libexec/PlistBuddy -c "Delete :ProgramArguments" "$PLIST_DEST" 2>/dev/null || true
/usr/libexec/PlistBuddy -c "Add :ProgramArguments array" "$PLIST_DEST"
/usr/libexec/PlistBuddy -c "Add :ProgramArguments:0 string /bin/bash" "$PLIST_DEST"
/usr/libexec/PlistBuddy -c "Add :ProgramArguments:1 string $INSTALL_DIR/scripts/stagehand.sh" "$PLIST_DEST"

# Load LaunchAgent
launchctl unload "$PLIST_DEST" 2>/dev/null || true
launchctl load "$PLIST_DEST"

log "✅ StageHand installed and loaded."