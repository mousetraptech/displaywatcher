#!/usr/bin/env bash

# Dim Spotify, speak disconnection message, restore volume
osascript <<EOF
tell application "Spotify"
  set originalVolume to sound volume
  set sound volume to 20
end tell

do shell script "say \"External display disconnected\""

tell application "Spotify"
  set sound volume to originalVolume
end tell
EOF
