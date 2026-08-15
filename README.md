# 🖥️ Linux Conky Desktop Widgets

Minimal, glassmorphism-style desktop widgets for Linux built with **Conky** and **Lua (Cairo)**. Features a digital clock and a date + quote panel that sit on your desktop with a transparent, frosted-glass look.

---

## ✨ Features

- **Digital Clock** — Large stacked hours/minutes display in amber (`#ff9900`) using the NDOT 45 font
- **Date & Quote Panel** — Current date and a motivational quote with accent dashes
- **Glassmorphism Design** — Semi-transparent dark rounded rectangles with subtle glass borders
- **Auto-start on Login** — Widgets persist across reboots via `.desktop` autostart entries
- **One-command Setup** — Single script handles everything: dependencies, fonts, configs, and autostart

---

## 📸 Widget Layout

```
┌─────────────────────────┐  ┌────────────┐
│   15-Aug, Friday        │  │     11     │
│   ── ── ──              │  │     04     │
│   Every day is a        │  │            │
│   summit push           │  │            │
└─────────────────────────┘  └────────────┘
     Left Widget (270×135)    Right Widget (130×145)
```

Both widgets are positioned at the **top-right** corner of the desktop.

---

## 📦 Requirements

| Requirement | Details |
|---|---|
| **OS** | Ubuntu / Debian-based Linux (or any distro with `apt`) |
| **Display Server** | X11 (Conky uses Xlib for rendering) |
| **Conky** | `conky-all` package (installed automatically by setup script) |
| **Lua + Cairo** | Included with `conky-all` |
| **curl** | For downloading fonts (pre-installed on most systems) |
| **Fonts** | NDOT 45, Special Elite, DotGothic16 (downloaded automatically) |

---

## 💾 RAM Usage

Measured on a live system:

| Widget | RSS (Resident Memory) |
|---|---|
| Right (Clock) | ~30 MB |
| Left (Date + Quote) | ~31 MB |
| **Total (both widgets)** | **~61 MB** |

> Both widgets combined use approximately **61 MB** of RAM — very lightweight for always-on desktop widgets.

---

## 🚀 Installation

### Quick Setup (Recommended)

```bash
git clone https://github.com/YOUR_USERNAME/Linux-concky-widget.git
cd Linux-concky-widget
chmod +x setup.sh
./setup.sh
```

### What the setup script does:
1. Installs `conky-all` if not already installed
2. Downloads required fonts to `~/.local/share/fonts/`
3. Copies widget configs and Lua scripts to `~/.config/conky/`
4. Creates autostart `.desktop` entries in `~/.config/autostart/`
5. Starts both widgets immediately

### Manual Installation

1. Install Conky:
   ```bash
   sudo apt install -y conky-all
   ```

2. Copy files to the Conky config directory:
   ```bash
   mkdir -p ~/.config/conky
   cp conky-left.conf conky-right.conf widget-left.lua widget-right.lua ~/.config/conky/
   ```

3. Download fonts:
   ```bash
   mkdir -p ~/.local/share/fonts
   curl -sL "https://github.com/sahibjotsaggu/Nothing-Font/raw/main/NDOT45.ttf" -o ~/.local/share/fonts/NDOT45.ttf
   curl -sL "https://github.com/google/fonts/raw/main/apache/specialelite/SpecialElite-Regular.ttf" -o ~/.local/share/fonts/SpecialElite-Regular.ttf
   curl -sL "https://github.com/google/fonts/raw/main/ofl/dotgothic16/DotGothic16-Regular.ttf" -o ~/.local/share/fonts/DotGothic16-Regular.ttf
   fc-cache -fv
   ```

4. Start the widgets:
   ```bash
   conky -c ~/.config/conky/conky-left.conf &
   conky -c ~/.config/conky/conky-right.conf &
   ```

---

## 🛠️ Useful Commands

| Action | Command |
|---|---|
| Stop all widgets | `pkill conky` |
| Restart widgets | `pkill conky && ./setup.sh` |
| View logs | `tail -f /tmp/conky-left.log /tmp/conky-right.log` |

---

## 📁 Project Structure

```
.
├── conky-left.conf      # Config for the date + quote widget
├── conky-right.conf     # Config for the clock widget
├── widget-left.lua      # Lua/Cairo renderer for left panel (glassmorphism + accent dashes)
├── widget-right.lua     # Lua/Cairo renderer for right panel (glassmorphism)
├── setup.sh             # One-command installer
└── README.md
```

---

## 🎨 Customization

- **Change the quote**: Edit line 37 in `conky-left.conf`
- **Change clock color**: Modify the hex color `ff9900` in `conky-right.conf`
- **Adjust position**: Change `gap_x` and `gap_y` values in the `.conf` files
- **Adjust transparency**: Modify the alpha value (last parameter) in the `rounded_rect()` calls in the `.lua` files (default: `0.35`)

---

## 📝 License

This project is open source. Feel free to use, modify, and share.


<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/b3880579-0afc-43b1-9f96-cf6a76f9a899" />

