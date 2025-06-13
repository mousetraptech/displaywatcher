# 🎧 media-voice Preset

This preset dims Spotify, plays a voice notification using `say`, and then restores the original volume.

## 🔊 Requirements

- macOS
- [Spotify.app](https://www.spotify.com)
- Accessibility permissions granted to Terminal or your StageHand runtime environment

## 🛠️ Usage

```bash
cp presets/media-voice/on_connect.sh handlers/on_connect.sh
cp presets/media-voice/on_disconnect.sh handlers/on_disconnect.sh
chmod +x handlers/*.sh
```

## 🧠 Notes

- This preset is Spotify-specific. It uses AppleScript to dim and restore volume.
- If you want a universal `say` message without dimming, use the `say-only` preset (coming soon).
- Feel free to adapt this to `backgroundmusic` or other tools if using different apps.
