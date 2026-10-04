#!/bin/bash

set -e

# Install Ark to extract archives, from Dolphin or by clicking them.

echo "==> Installing Ark..."
# 7zip: adds 7z support to Ark.
# archlinux-xdg-menu: Dolphin's "Open With" list is empty outside Plasma without it.
# breeze: Qt widget style KDE apps ask for; without it they fall back to GTK's Yaru bits (orange tab close button).
# ark: https://apps.kde.org/ark/ https://archlinux.org/packages/extra/x86_64/ark/
# 7zip: https://www.7-zip.org https://archlinux.org/packages/extra/x86_64/7zip/
# archlinux-xdg-menu: https://wiki.archlinux.org/index.php/XdgMenu https://archlinux.org/packages/extra/any/archlinux-xdg-menu/
# breeze: https://kde.org/plasma-desktop/ https://archlinux.org/packages/extra/x86_64/breeze/
omarchy pkg add ark 7zip archlinux-xdg-menu breeze

echo -e "\n==> Setting Ark as the default for archives..."
# Clicking an archive extracts it next to itself, like macOS
# (ark-extract-here.desktop lives in the dotfiles under .local/share/applications).
archive_types=(
    application/zip application/x-tar application/x-compressed-tar application/x-bzip-compressed-tar
    application/x-bzip2-compressed-tar application/x-xz-compressed-tar application/x-zstd-compressed-tar
    application/x-lzma-compressed-tar application/x-7z-compressed application/vnd.rar application/gzip
)
xdg-mime default ark-extract-here.desktop "${archive_types[@]}"

echo -e "\n==> Rebuilding the KDE service cache for Open With menus..."
XDG_MENU_PREFIX=arch- kbuildsycoca6 --noincremental &>/dev/null

echo -e "\nArk installed."
