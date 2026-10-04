#!/bin/bash

set -e

# Install KDE Partition Manager alongside GNOME Disks.

echo "==> Installing KDE Partition Manager..."
# breeze: Qt widget style KDE apps ask for; without it they fall back to GTK's Yaru bits (orange tab close button).
# partitionmanager: https://apps.kde.org/partitionmanager/ https://archlinux.org/packages/extra/x86_64/partitionmanager/
# breeze: https://kde.org/plasma-desktop/ https://archlinux.org/packages/extra/x86_64/breeze/
omarchy pkg add partitionmanager breeze
