#!/usr/bin/env bash
# setup.sh — i3 Rice Setup Script for Debian 12
set -euo pipefail

# === COLORS ===
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# === PATHS ===
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# === FLAGS ===
DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
    echo -e "${YELLOW}[i] Running in dry-run mode — no files will be changed.${RESET}"
fi

# === PACKAGE LIST ===
PACKAGES=(
    # Core
    i3
    git
    
    # Libraries / Tools
    hsetroot
    xclip
    i3lock
    dunst
    policykit-1-gnome
    rsync
    
    # Fonts / Text Rendering
    fonts-firacode
)

# === FILE/FOLDER MOVE MAP ===
# Format: "source -> destination"
# Works for both files and directories
COPY_MAP=(
    "$SCRIPT_DIR/config -> $HOME/.config"
    "$SCRIPT_DIR/wallpapers -> $HOME/Pictures/wallpapers"
)

echo -e "${GREEN}[*] Starting i3 rice setup for Debian 12...${RESET}"

# === System Update ===
echo -e "${YELLOW}[*] Updating package lists...${RESET}"
sudo apt update -y

# === Install Required Packages (skip existing) ===
echo -e "${YELLOW}[*] Installing required packages (skipping existing)...${RESET}"
for pkg in "${PACKAGES[@]}"; do
    if dpkg -s "$pkg" &>/dev/null; then
        echo "  → $pkg already installed"
    else
        echo "  → Installing $pkg"
        sudo apt install -y "$pkg"
    fi
done
echo -e "${GREEN}[✓] Package installation complete.${RESET}"

# === Copy Files and Folders ===
RSYNC_OPTS="-avh --progress"
$DRY_RUN && RSYNC_OPTS+=" --dry-run"

echo -e "${YELLOW}[*] Copying configured files and folders...${RESET}"

for pair in "${COPY_MAP[@]}"; do
    src="${pair%% -> *}"
    dest="${pair##*-> }"
    src="$(eval echo "$src")"
    dest="$(eval echo "$dest")"

    if [ ! -e "$src" ]; then
        echo -e "${RED}[!] Source not found: $src${RESET}"
        continue
    fi

    echo "  → Copying from $src to $dest"

    if [ -d "$src" ]; then
        mkdir -p "$dest"
    else
        mkdir -p "$(dirname "$dest")"
    fi

    # Backup existing destination
    timestamp=$(date +"%Y%m%d-%H%M%S")
    if [ -d "$dest" ] || [ -f "$dest" ]; then
        backup="$dest.backup-$timestamp"
        echo "    Backing up existing $dest → $backup"
        cp -r "$dest" "$backup"
    fi

    rsync $RSYNC_OPTS "$src" "$dest"
done

echo -e "${GREEN}[✓] All files and folders copied successfully.${RESET}"

# === Reload i3 (if running) ===
if pgrep -x "i3" >/dev/null 2>&1; then
    echo -e "${YELLOW}[*] Reloading i3 configuration...${RESET}"
    if i3-msg reload >/dev/null 2>&1; then
        echo -e "${GREEN}[✓] i3 reloaded successfully.${RESET}"
    else
        echo -e "${RED}[!] Failed to reload i3. You may need to restart manually.${RESET}"
    fi
else
    echo -e "${YELLOW}[!] i3 is not currently running — skipping reload.${RESET}"
fi

echo -e "${GREEN}[✓] Setup complete! Enjoy your rice.${RESET}"

