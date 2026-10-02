#!/bin/bash

set -e

# Add a Change Colors button (with the color mode dropdown) to Okular's main toolbar
# and hide its menu bar.
# Okular reads toolbar layout only from its UI file, so write a local copy of the
# built-in part.rc (extracted from the installed Okular) with the button added.
# Re-run after an Okular update that bumps the file's version. Close Okular first.

LIB="/usr/lib/qt6/plugins/kf6/parts/okularpart.so"
RC="$HOME/.local/share/kxmlgui5/okular/part.rc"

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

# Hide the menu bar like Kate; the toolbar's hamburger button still has every menu.
kwriteconfig6 --file okularrc --group MainWindow --key MenuBar Disabled

echo "Change Colors button added and menu bar hidden in Okular. Restart Okular to see it."
