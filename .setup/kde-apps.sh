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
sudo pacman -S --noconfirm --needed dolphin kio-extras ffmpegthumbs kdegraphics-thumbnailers archlinux-xdg-menu okular kate partitionmanager

echo -e "\n==> Removing GNOME apps..."
omarchy-pkg-drop sushi nautilus-python nautilus evince gedit gnome-disk-utility

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

echo -e "\n==> Disabling Kate plugins..."
# Kate reads enabled plugins from its session, not katerc, so seed the session
# with the [Kate Plugins] list from the dotfiles katerc.
mkdir -p ~/.local/share/kate
awk '/^\[Kate Plugins\]/{p=1} p&&/^$/{exit} p' ~/dotfiles/.config/katerc >~/.local/share/kate/anonymous.katesession

echo -e "\n==> Rebuilding the KDE service cache for Open With menus..."
XDG_MENU_PREFIX=arch- kbuildsycoca6 --noincremental &>/dev/null

echo -e "\nKDE apps installed. Reload Hyprland (or log out and back in) to pick up the new keybindings."
