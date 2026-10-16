#!/usr/bin/env bash
# ==============================================================================
# install.sh — Steam Arabic Official Theme Installer for Linux & SteamOS
#
# Supports:
#   - Native Steam (Arch, Ubuntu, Debian, Fedora, openSUSE)
#   - SteamOS / Steam Deck (Desktop Mode)
#   - Flatpak Steam
#   - Snap Steam
# ==============================================================================

set -e

THEME_NAME="steam-arabic-official"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "\033[1;36m====================================================\033[0m"
echo -e "\033[1;36m  Steam Arabic Official Theme Installer (Linux/SteamOS)\033[0m"
echo -e "\033[1;36m====================================================\033[0m"

# 1. Detect Steam Installation Path
STEAM_PATH=""

if [ -n "$1" ] && [ -d "$1" ]; then
    STEAM_PATH="$1"
fi

if [ -z "$STEAM_PATH" ]; then
    CANDIDATES=(
        "$HOME/.local/share/Steam"
        "$HOME/.steam/steam"
        "$HOME/.steam/root"
        "$HOME/.var/app/com.valvesoftware.Steam/.local/share/Steam"
        "$HOME/.var/app/com.valvesoftware.Steam/.steam/steam"
        "$HOME/snap/steam/common/.local/share/Steam"
    )

    for path in "${CANDIDATES[@]}"; do
        if [ -d "$path" ]; then
            STEAM_PATH="$path"
            break
        fi
    done
fi

if [ -z "$STEAM_PATH" ]; then
    echo -e "\033[1;31m[ERROR] Steam directory could not be found automatically.\033[0m"
    echo -e "Please run the script providing your Steam path explicitly:"
    echo -e "  ./install.sh ~/.local/share/Steam"
    exit 1
fi

echo -e "\033[1;32m[+] Detected Steam Directory:\033[0m $STEAM_PATH"

# 2. Prepare Millennium Themes Directory
DEST_DIR="$STEAM_PATH/millennium/themes/$THEME_NAME"
mkdir -p "$DEST_DIR"

echo -e "\033[1;34m[+] Copying theme files to:\033[0m $DEST_DIR"

FILES=(
    "skin.json"
    "libraryroot.custom.css"
    "friends.custom.css"
    "webkit.custom.css"
    "theme.js"
)

for file in "${FILES[@]}"; do
    if [ -f "$SCRIPT_DIR/$file" ]; then
        cp -f "$SCRIPT_DIR/$file" "$DEST_DIR/$file"
        echo -e "  \033[0;32m✓\033[0m Copied $file"
    else
        echo -e "  \033[0;31m✗\033[0m Missing file: $file"
        exit 1
    fi
done

echo ""
echo -e "\033[1;32m====================================================\033[0m"
echo -e "\033[1;32m  Theme installed successfully on Linux / SteamOS! 🎉\033[0m"
echo -e "\033[1;32m====================================================\033[0m"
echo -e "\033[1;33mHow to activate in Steam:\033[0m"
echo -e "  1. Open Steam."
echo -e "  2. Go to: Steam -> Settings -> Themes."
echo -e "  3. Select: 'Steam Arabic Official (RTL)'."
echo -e "  4. Restart Steam."
echo ""
