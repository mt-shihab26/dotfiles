#!/bin/bash

set -e

# Install F3D, a minimal 3D model viewer, to preview models by clicking them.

echo "==> Installing F3D..."
# f3d: https://f3d.app https://archlinux.org/packages/extra/x86_64/f3d/
omarchy pkg add f3d

echo -e "\n==> Setting F3D as the default for 3D models..."
# F3D registers its formats in its own mime files (FBX has no system mime type otherwise),
# so look up the types of each extension there instead of hardcoding the names.
# Only model/* types and F3D's own types are taken: *.obj is also a COFF object file.
extensions=(fbx glb gltf obj stl ply 3mf dae)
mapfile -t model_types < <(
    for ext in "${extensions[@]}"; do
        awk -v glob="*.$ext" '
            /<mime-type / { match($0, /type="[^"]+"/); current = substr($0, RSTART + 6, RLENGTH - 7) }
            index($0, "pattern=\"" glob "\"") && (current ~ /^model\// || FILENAME ~ /f3d-/) { print current }
        ' /usr/share/mime/packages/freedesktop.org.xml /usr/share/mime/packages/f3d-*.xml
    done | sort -u
)
xdg-mime default f3d.desktop "${model_types[@]}"
echo "Default for: ${model_types[*]}"

echo -e "\n==> Rebuilding the KDE service cache for Open With menus..."
XDG_MENU_PREFIX=arch- kbuildsycoca6 --noincremental &>/dev/null

echo -e "\nF3D installed."
