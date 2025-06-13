# DisplayWatcher

A minimalist macOS utility to run custom scripts when an external display (like an Apple TV) connects or disconnects.

### Why this exists
If you're frequently using external displays and want automated handling—like pausing media, switching audio, or triggering notifications—DisplayWatcher handles it cleanly and transparently.

---

## Installation

1. Install **displayplacer**:

    ```bash
    brew install displayplacer
    ```

2. Clone/display the project:

    ```bash
    git clone https://github.com/mousetraptech/displaywatcher.git
    cd displaywatcher
    ```

3. Make scripts executable:

    ```bash
    chmod +x scripts/displaywatcher.sh handlers/*.sh
    ```

4. Find your external display ID:

    ```bash
    displayplacer list
    ```

   Copy the `Persistent screen id:` for your external monitor and paste it into `scripts/displaywatcher.sh`, replacing `YOUR_EXTERNAL_DISPLAY_ID_HERE` on the `EXT_ID` line.

5. Install the LaunchAgent:

    ```bash
    cp LaunchAgents/com.mousetraptech.displaywatcher.plist ~/Library/LaunchAgents/
    launchctl load ~/Library/LaunchAgents/com.mousetraptech.displaywatcher.plist
    ```

   It will run automatically at login and monitor display status every 5 seconds by default.

---

## Handlers

- `handlers/on_connect.sh` — runs when the external display is connected.
- `handlers/on_disconnect.sh` — runs when it’s disconnected.

You can customize these to do anything: pause or mute audio, show notifications, toggle IoT devices, etc.

---

## Testing

To test handler scripts manually:

```bash
bash handlers/on_disconnect.sh
bash handlers/on_connect.sh
```

---

## Configuration

- Modify the polling interval in `scripts/displaywatcher.sh` (`CHECK_INTERVAL=5`).
- You can also disable the LaunchAgent via:

```bash
launchctl unload ~/Library/LaunchAgents/com.mousetraptech.displaywatcher.plist
```

---

## License

This project is released under the MIT License — see LICENSE.

---

## Version

DisplayWatcher `1.0.0`
