#!/bin/bash

set -e

# Undo okular-toolbar.sh: show the menu bar again and delete the local part.rc so
# Okular goes back to its built-in toolbar. Close Okular first.

RC="$HOME/.local/share/kxmlgui5/okular/part.rc"

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
