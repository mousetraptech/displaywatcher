# 🎭 StageHand

**StageHand** is a tiny macOS utility that listens for changes in external display state—like when your Mac loses or regains an extended monitor—and responds by executing customizable scripts.

Perfect for setups with an Apple TV, external monitor, or presentation rig that need to pause music, mute speakers, or trigger automations when your screen layout shifts.

---

## 🤔 Why this exists

If you're frequently using external displays and want your Mac to just handle things—StageHand runs in the background and does exactly what you tell it to. No fluff. No GUI. Just response.

---

## 🧠 Why “StageHand”?

Because it works behind the scenes—silent, reliable, and ready to manage cues when the show changes. It’s the tech you forget you installed… until it saves your ass.

---

## 📦 Installation

1. Install `displayplacer` (required):

    ```bash
    brew install displayplacer
    ```

2. Clone the repo:

    ```bash
    git clone https://github.com/mousetraptech/stagehand.git
    cd stagehand
    ```

3. Run the installer:

    ```bash
    sh ./install.sh
    ```

4. On startup, StageHand will:
    - Detect your current external display
    - Set up a LaunchAgent to run at login
    - Monitor for connect/disconnect events
    - Trigger handler scripts accordingly

5. (Optional) Verify it’s running:

    ```bash
    launchctl list | grep mousetraptech
    ```

---

## 🧬 Customization

Edit the handler scripts in:

- `handlers/on_connect.sh`
- `handlers/on_disconnect.sh`

These are plain Bash scripts. Do whatever you want:
- Pause/resume Spotify
- Mute/unmute speakers
- Log timestamps
- Trigger AppleScripts, CLI tools, or Home Assistant automations

[Customizing Hooks](docs/customizing-hooks.md)

---

## ✅ Testing

To manually trigger the handlers:

```bash
bash handlers/on_disconnect.sh
bash handlers/on_connect.sh
```

---

## 🎛️ Configuration

- To adjust the polling interval, edit this line in `scripts/stagehand.sh`:

    ```bash
    CHECK_INTERVAL=5
    ```

- To temporarily disable StageHand:

    ```bash
    launchctl unload ~/Library/LaunchAgents/com.mousetraptech.stagehand.plist
    ```

---

## 🗑️ Uninstall

```bash
sh ./uninstall.sh
```

Removes the LaunchAgent and stops monitoring.

---

## 📄 License

MIT. Use it, fork it, break it, improve it.
