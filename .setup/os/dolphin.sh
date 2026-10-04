#!/bin/bash

set -e

# Replace Omarchy's Nautilus (+ sushi, nautilus-python) with Dolphin.

echo "==> Installing Dolphin..."
# kio-extras, ffmpegthumbs, kdegraphics-thumbnailers: Dolphin MTP/SMB access and previews.
# archlinux-xdg-menu: Dolphin's "Open With" list is empty outside Plasma without it.
# breeze: Qt widget style KDE apps ask for; without it they fall back to GTK's Yaru bits (orange tab close button).
# dolphin: https://apps.kde.org/dolphin/ https://archlinux.org/packages/extra/x86_64/dolphin/
# kio-extras: https://www.kde.org/ https://archlinux.org/packages/extra/x86_64/kio-extras/
# ffmpegthumbs: https://apps.kde.org/ffmpegthumbs/ https://archlinux.org/packages/extra/x86_64/ffmpegthumbs/
# kdegraphics-thumbnailers: https://apps.kde.org/kdegraphics_thumbnailers/ https://archlinux.org/packages/extra/x86_64/kdegraphics-thumbnailers/
# archlinux-xdg-menu: https://wiki.archlinux.org/index.php/XdgMenu https://archlinux.org/packages/extra/any/archlinux-xdg-menu/
# breeze: https://kde.org/plasma-desktop/ https://archlinux.org/packages/extra/x86_64/breeze/
omarchy pkg add dolphin kio-extras ffmpegthumbs kdegraphics-thumbnailers archlinux-xdg-menu breeze

echo -e "\n==> Removing Nautilus..."
omarchy pkg drop sushi nautilus-python nautilus

echo -e "\n==> Setting Dolphin as the default file manager..."
xdg-mime default org.kde.dolphin.desktop inode/directory

echo -e "\n==> Rebuilding the KDE service cache for Open With menus..."
XDG_MENU_PREFIX=arch- kbuildsycoca6 --noincremental &>/dev/null

echo -e "\nDolphin installed. Reload Hyprland (or log out and back in) to pick up the new keybindings."
