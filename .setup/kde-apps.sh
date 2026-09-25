#!/bin/bash

set -e

# Replace Omarchy's GNOME apps with their KDE counterparts:
#   nautilus (+ sushi, nautilus-python) -> dolphin
#   evince                              -> okular
#   gedit                               -> kate
#   gnome-disk-utility                  -> partitionmanager
# gnome-keyring stays: the omarchy package depends on it.

echo "==> Installing KDE apps..."
# kio-extras, ffmpegthumbs, kdegraphics-thumbnailers: Dolphin MTP/SMB access and previews.
# archlinux-xdg-menu: Dolphin's "Open With" list is empty outside Plasma without it.
# breeze: Qt widget style KDE apps ask for; without it they fall back to GTK's Yaru bits (orange tab close button).
# ark, 7zip: extract archives from Dolphin (7zip adds 7z support).
omarchy pkg add dolphin kio-extras ffmpegthumbs kdegraphics-thumbnailers archlinux-xdg-menu okular kate partitionmanager breeze ark 7zip

echo -e "\n==> Removing GNOME apps..."
omarchy pkg drop sushi nautilus-python nautilus evince gedit gnome-disk-utility

echo -e "\n==> Setting KDE apps as defaults..."
xdg-mime default org.kde.dolphin.desktop inode/directory
xdg-mime default org.kde.okular.desktop application/pdf application/epub+zip image/vnd.djvu application/postscript
# Kate opens text, code and config files (Omarchy's nvim defaults plus common extras).
kate_types=(
    text/plain text/english text/markdown text/x-markdown application/x-zerosize
    text/x-makefile text/x-c text/x-c++ text/x-csrc text/x-chdr text/x-c++src text/x-c++hdr
    text/x-java text/x-moc text/x-pascal text/x-tcl text/x-tex text/x-python text/x-go
    text/rust text/x-php application/x-php text/x-ruby application/x-ruby text/x-lua
    application/javascript text/javascript application/typescript text/css text/csv
    application/json application/x-yaml application/yaml application/toml
    application/xml text/xml application/x-shellscript text/x-log
)
xdg-mime default org.kde.kate.desktop "${kate_types[@]}"
# Clicking an archive extracts it next to itself, like macOS
# (ark-extract-here.desktop lives in the dotfiles under .local/share/applications).
archive_types=(
    application/zip application/x-tar application/x-compressed-tar application/x-bzip-compressed-tar
    application/x-bzip2-compressed-tar application/x-xz-compressed-tar application/x-zstd-compressed-tar
    application/x-lzma-compressed-tar application/x-7z-compressed application/vnd.rar application/gzip
)
xdg-mime default ark-extract-here.desktop "${archive_types[@]}"

echo -e "\n==> Disabling Kate plugins, sidebars and menu bar..."
# Kate reads these from its session, not katerc, so seed the session with the
# [Kate Plugins] list from the dotfiles katerc plus hidden sidebars and menu bar.
mkdir -p ~/.local/share/kate
{
    awk '/^\[Kate Plugins\]/{p=1} p&&/^$/{exit} p' ~/dotfiles/.config/katerc
    printf '\n[MainWindow0]\nKate-MDI-Sidebar-Visible=false\n\n[MainWindow0 Settings]\nMenuBar=Disabled\n'
} >~/.local/share/kate/anonymous.katesession

echo -e "\n==> Rebuilding the KDE service cache for Open With menus..."
XDG_MENU_PREFIX=arch- kbuildsycoca6 --noincremental &>/dev/null

echo -e "\nKDE apps installed. Reload Hyprland (or log out and back in) to pick up the new keybindings."
