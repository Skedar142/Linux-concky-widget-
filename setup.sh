#!/bin/bash
set -e

echo "=== Conky Widget Setup ==="

# 1. Install conky if needed
if ! command -v conky &> /dev/null; then
    echo "Installing conky-all..."
    sudo apt install -y conky-all
fi

# 2. Install config files
echo "Installing widget files to ~/.config/conky/..."
mkdir -p ~/.config/conky
cp "$(dirname "$0")/conky-left.conf"   ~/.config/conky/conky-left.conf
cp "$(dirname "$0")/conky-right.conf"  ~/.config/conky/conky-right.conf
cp "$(dirname "$0")/widget-left.lua"   ~/.config/conky/widget-left.lua
cp "$(dirname "$0")/widget-right.lua"  ~/.config/conky/widget-right.lua

# 3. Download fonts
echo "Installing fonts..."
mkdir -p ~/.local/share/fonts
curl -sL "https://github.com/sahibjotsaggu/Nothing-Font/raw/main/NDOT45.ttf" -o ~/.local/share/fonts/NDOT45.ttf || true
curl -sL "https://github.com/google/fonts/raw/main/apache/specialelite/SpecialElite-Regular.ttf" -o ~/.local/share/fonts/SpecialElite-Regular.ttf || true
curl -sL "https://github.com/google/fonts/raw/main/ofl/dotgothic16/DotGothic16-Regular.ttf" -o ~/.local/share/fonts/DotGothic16-Regular.ttf || true
fc-cache -fv

# 4. Kill any existing conky instances
pkill conky 2>/dev/null || true
sleep 1

# 5. Create autostart .desktop entries
echo "Creating autostart entries..."
mkdir -p ~/.config/autostart

cat > ~/.config/autostart/conky-left.desktop << EOF
[Desktop Entry]
Type=Application
Name=Conky Left Widget
Comment=Weather and quote desktop widget
Exec=conky -c $HOME/.config/conky/conky-left.conf
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
EOF

cat > ~/.config/autostart/conky-right.desktop << EOF
[Desktop Entry]
Type=Application
Name=Conky Right Widget
Comment=Clock desktop widget
Exec=conky -c $HOME/.config/conky/conky-right.conf
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
EOF

# 6. Start both instances now, detached
echo "Starting widgets..."
nohup conky -c ~/.config/conky/conky-left.conf  > /tmp/conky-left.log  2>&1 &
disown
sleep 0.5
nohup conky -c ~/.config/conky/conky-right.conf > /tmp/conky-right.log 2>&1 &
disown

echo ""
echo "=== Done! ==="
echo "Both widgets are running and will auto-start on login."
echo ""
echo "Useful commands:"
echo "  Stop:    pkill conky"
echo "  Restart: ~/.config/autostart/conky-left.desktop & ~/.config/autostart/conky-right.desktop"
echo "  Logs:    tail -f /tmp/conky-left.log /tmp/conky-right.log"
