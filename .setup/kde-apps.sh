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

echo -e "\n==> Rebuilding the KDE service cache for Open With menus..."
XDG_MENU_PREFIX=arch- kbuildsycoca6 --noincremental &>/dev/null

echo -e "\nKDE apps installed. Reload Hyprland (or log out and back in) to pick up the new keybindings."
