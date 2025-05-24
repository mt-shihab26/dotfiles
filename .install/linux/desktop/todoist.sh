#!/bin/bash

set -e

cd /tmp

# Variables
APPIMAGE_URL="https://github.com/kidonng/todoist-linux/releases/latest/download/Todoist.AppImage"
APP_DIR="$HOME/.local/share/applications"
BIN_DIR="$HOME/.local/bin"
APPIMAGE_PATH="$BIN_DIR/Todoist.AppImage"
DESKTOP_FILE="$APP_DIR/todoist.desktop"
ICON_URL="https://cdn.iconscout.com/icon/free/png-256/todoist-1-461770.png"
ICON_PATH="$HOME/.local/share/icons/todoist.png"

# Create required directories
mkdir -p "$BIN_DIR" "$APP_DIR" "$(dirname "$ICON_PATH")"

echo -e "Downloading Todoist AppImage..."
wget -qO "$APPIMAGE_PATH" "$APPIMAGE_URL"
chmod +x "$APPIMAGE_PATH"

echo -e "\nDownloading Todoist icon..."
wget -qO "$ICON_PATH" "$ICON_URL"

echo -e "\nCreating desktop entry..."
cat >"$DESKTOP_FILE" <<EOL
[Desktop Entry]
Name=Todoist
Exec=$APPIMAGE_PATH
Icon=$ICON_PATH
Type=Application
Categories=Utility;
Comment=Todoist task manager
Terminal=false
EOL

echo -e "\nUpdating KDE application menu..."
kbuildsycoca5

echo -e "\nTodoist AppImage installed successfully!"
echo "You can launch it from the application menu or by running: $APPIMAGE_PATH"

cd -
