#!/bin/bash

set -e

# Undo okular-toolbar.sh: delete the local part.rc so Okular goes back to its
# built-in toolbar. Close Okular first.

RC="$HOME/.local/share/kxmlgui5/okular/part.rc"

if [[ ! -f $RC ]]; then
    echo "No local Okular toolbar file at $RC, nothing to remove."
    exit 0
fi

if ! grep -q '<Action name="color_mode_menu"/>' "$RC"; then
    echo "$RC has no Change Colors button, leaving it alone." >&2
    exit 1
fi

rm "$RC"
rmdir --ignore-fail-on-non-empty "$(dirname "$RC")" "$(dirname "$(dirname "$RC")")"

echo "Change Colors button removed from Okular's toolbar. Restart Okular to see it."
