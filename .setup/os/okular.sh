#!/bin/bash

set -e

# Replace Omarchy's Evince with Okular, add a Change Colors button (with the color
# mode dropdown) to Okular's main toolbar and hide its menu bar.
# Re-run after an Okular update that bumps the UI file's version. Close Okular first.
#
# okular.sh --remove-toolbar undoes the toolbar part: shows the menu bar again and
# deletes the local part.rc so Okular goes back to its built-in toolbar.

LIB="/usr/lib/qt6/plugins/kf6/parts/okularpart.so"
RC="$HOME/.local/share/kxmlgui5/okular/part.rc"

if [[ $1 == --remove-toolbar ]]; then
    kwriteconfig6 --file okularrc --group MainWindow --key MenuBar --delete

    if [[ ! -f $RC ]]; then
        echo "Okular menu bar shown again. No local toolbar file at $RC to remove."
        exit 0
    fi

    if ! grep -q '<Action name="color_mode_menu"/>' "$RC"; then
        echo "$RC has no Change Colors button, leaving it alone." >&2
        exit 1
    fi

    rm "$RC"
    rmdir --ignore-fail-on-non-empty "$(dirname "$RC")" "$(dirname "$(dirname "$RC")")"

    echo "Change Colors button removed and menu bar shown again in Okular. Restart Okular to see it."
    exit 0
fi

echo "==> Installing Okular..."
# archlinux-xdg-menu: Dolphin's "Open With" list is empty outside Plasma without it.
# breeze: Qt widget style KDE apps ask for; without it they fall back to GTK's Yaru bits (orange tab close button).
# okular: https://apps.kde.org/okular/ https://archlinux.org/packages/extra/x86_64/okular/
# archlinux-xdg-menu: https://wiki.archlinux.org/index.php/XdgMenu https://archlinux.org/packages/extra/any/archlinux-xdg-menu/
# breeze: https://kde.org/plasma-desktop/ https://archlinux.org/packages/extra/x86_64/breeze/
omarchy pkg add okular archlinux-xdg-menu breeze

echo -e "\n==> Removing Evince..."
omarchy pkg drop evince

echo -e "\n==> Setting Okular as the default document viewer..."
xdg-mime default org.kde.okular.desktop application/pdf application/epub+zip image/vnd.djvu application/postscript

echo -e "\n==> Adding the Change Colors button to Okular's toolbar..."
# Okular reads toolbar layout only from its UI file, so write a local copy of the
# built-in part.rc (extracted from the installed Okular) with the button added.
# Qt stores the UI file zstd-compressed in the plugin's resources: try each zstd
# frame until one decompresses to the okular_part UI file.
builtin_rc=""
for offset in $(LC_ALL=C grep -obUaP '\x28\xb5\x2f\xfd' "$LIB" | cut -d: -f1); do
    candidate=$(tail -c +$((offset + 1)) "$LIB" | zstd -dcq 2>/dev/null || true)
    if [[ $candidate == *'<gui name="okular_part" '* ]]; then
        builtin_rc=$candidate
        break
    fi
done

if [[ -z $builtin_rc ]]; then
    echo "Okular's part.rc not found in $LIB" >&2
    exit 1
fi

mkdir -p "$(dirname "$RC")"

# Insert the button after the view mode button, only inside mainToolBar
# (view_render_mode also appears in the View menu).
printf '%s\n' "$builtin_rc" |
    sed '/<ToolBar name="mainToolBar">/,/<\/ToolBar>/ s|^\(  <Action name="view_render_mode"/>\)$|\1\n  <Action name="color_mode_menu"/>|' >"$RC"

if ! grep -q '<Action name="color_mode_menu"/>' "$RC"; then
    echo "Couldn't find the view mode button in Okular's main toolbar" >&2
    exit 1
fi

echo -e "\n==> Hiding Okular's menu bar..."
# Hide the menu bar like Kate; the toolbar's hamburger button still has every menu.
kwriteconfig6 --file okularrc --group MainWindow --key MenuBar Disabled

echo -e "\n==> Rebuilding the KDE service cache for Open With menus..."
XDG_MENU_PREFIX=arch- kbuildsycoca6 --noincremental &>/dev/null

echo -e "\nOkular installed with the Change Colors button and hidden menu bar. Restart Okular to see it."
