# Pomodoro Timer

A minimalist macOS menu bar Pomodoro timer built with SwiftUI.

![macOS 13+](https://img.shields.io/badge/macOS-13%2B-blue)
![Swift](https://img.shields.io/badge/Swift-5.9-orange)

## Features

- **Menu bar only** — no dock icon, no windows, lives quietly in your top bar
- **Play / Pause / Restart** — simple controls in a clean dropdown
- **Configurable duration** — 5, 10, 15, 20, 25, 30, 45, or 60 minutes
- **Soothing completion sound** — choose from 14 built-in macOS sounds with preview
- **Remembers your settings** — duration and sound choice persist between launches

## Build

Requires macOS 13+ and Xcode Command Line Tools.

```bash
git clone https://github.com/adityajain07/PomodoroTimer.git
cd PomodoroTimer
bash build.sh
```

## Run

```bash
open build/PomodoroTimer.app
```

## Install

Copy to Applications for permanent use:

```bash
cp -r build/PomodoroTimer.app /Applications/
```

## License

MIT
