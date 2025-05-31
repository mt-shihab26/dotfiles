#!/bin/sh

# Toggle Night Light mode using gammastep or wlr-randr

# If using gammastep, check if gammastep is running:
if pgrep gammastep >/dev/null; then
    # Kill gammastep to disable night light
    pkill gammastep
else
    # Start gammastep with desired settings
    gammastep -O 5500K &
fi
