#!/bin/bash

set -e

# htop: https://htop.dev/ https://archlinux.org/packages/extra/x86_64/htop/
# stow: https://www.gnu.org/software/stow/ https://archlinux.org/packages/extra/any/stow/
# cloc: https://github.com/AlDanial/cloc https://archlinux.org/packages/extra/any/cloc/
# tree: https://gitlab.com/OldManProgrammer/unix-tree https://archlinux.org/packages/extra/x86_64/tree/
# wget: https://www.gnu.org/software/wget/wget.html https://archlinux.org/packages/extra/x86_64/wget/
omarchy pkg add htop stow cloc tree wget
