#!/usr/bin/env bash

# Dim Spotify, speak connection message, restore volume
osascript <<EOF
tell application "Spotify"
  set originalVolume to sound volume
  set sound volume to 20
end tell

do shell script "say \"External display connected\""

tell application "Spotify"
  set sound volume to originalVolume
end tell
EOF
