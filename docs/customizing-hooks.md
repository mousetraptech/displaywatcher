# 🧬 Customizing StageHand Hooks

StageHand uses two hook scripts to respond to external display changes:

- `handlers/on_connect.sh` — runs when the external display connects
- `handlers/on_disconnect.sh` — runs when the external display disconnects

These scripts are plain Bash and can be edited to perform any user-level action.

---

## 🛠️ Example Actions (No Extra Permissions)

Here are some safe, permission-free examples you can use or remix:

### 🔊 Switch audio output

Requires [**switchaudio-osx**](https://github.com/deweller/switchaudio-osx):

```bash
brew install switchaudio-osx
```

**on_connect.sh**
```bash
SwitchAudioSource -s "MacBook Pro Speakers"
```

**on_disconnect.sh**
```bash
SwitchAudioSource -s "External Headphones"
```

---

### 🖼️ Change desktop wallpaper

No extra permissions needed (uses `osascript`):

**on_connect.sh**
```bash
osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/System/Library/Desktop Pictures/Solid Colors/Solid Gray Dark.png"'
```

**on_disconnect.sh**
```bash
osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/System/Library/Desktop Pictures/Solid Colors/Solid Gray Light.png"'
```

---

### 📝 Log activity to a file

**on_connect.sh**
```bash
echo "$(date): display connected" >> ~/stagehand.log
```

**on_disconnect.sh**
```bash
echo "$(date): display disconnected" >> ~/stagehand.log
```

---

### 🗣️ Audible confirmation

**on_connect.sh**
```bash
say "External display connected"
```

**on_disconnect.sh**
```bash
say "External display disconnected"
```

---

## 🧠 Tips

- All scripts run as the logged-in user.
- Avoid sudo or anything that prompts for permission.
- Use absolute paths or `$HOME` instead of `~`.
- If your action seems to fail silently, log its output or test it manually:

```bash
bash handlers/on_connect.sh
```

---

Customize boldly—StageHand won’t judge.