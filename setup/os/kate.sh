#!/bin/bash

set -e

# Replace Omarchy's gedit with Kate.

echo "==> Installing Kate..."
# archlinux-xdg-menu: Dolphin's "Open With" list is empty outside Plasma without it.
# breeze: Qt widget style KDE apps ask for; without it they fall back to GTK's Yaru bits (orange tab close button).
# kate: https://apps.kde.org/kate/ https://archlinux.org/packages/extra/x86_64/kate/
# archlinux-xdg-menu: https://wiki.archlinux.org/index.php/XdgMenu https://archlinux.org/packages/extra/any/archlinux-xdg-menu/
# breeze: https://kde.org/plasma-desktop/ https://archlinux.org/packages/extra/x86_64/breeze/
omarchy pkg add kate archlinux-xdg-menu breeze

echo -e "\n==> Removing gedit..."
omarchy pkg drop gedit

echo -e "\n==> Setting Kate as the default text editor..."
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

echo -e "\nKate installed."
