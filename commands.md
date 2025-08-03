# Commands

## Arch Linux Package Management

| Category          | Task                           | `pacman` Command              | `yay` Command              |
| ----------------- | ------------------------------ | ----------------------------- | -------------------------- |
| **Listing**       | List all installed packages    | `pacman -Q`                   | `yay -Q`                   |
|                   | List explicitly installed only | `pacman -Qe`                  | `yay -Qe`                  |
|                   | List packages from AUR only    | _N/A_                         | `yay -Qm`                  |
|                   | List packages by group         | `pacman -Qg <group>`          | `yay -Qg <group>`          |
| **Searching**     | Search repo packages           | `pacman -Ss <name>`           | `yay -Ss <name>`           |
|                   | Show package info (repo)       | `pacman -Si <package>`        | `yay -Si <package>`        |
|                   | Show installed package info    | `pacman -Qi <package>`        | `yay -Qi <package>`        |
|                   | Search installed packages      | `pacman -Qs <name>`           | `yay -Qs <name>`           |
| **Installing**    | Install a package              | `pacman -S <package>`         | `yay -S <package>`         |
|                   | Install multiple packages      | `pacman -S pkg1 pkg2`         | `yay -S pkg1 pkg2`         |
|                   | Install local file             | `pacman -U ./pkg.pkg.tar.zst` | `yay -U ./pkg.pkg.tar.zst` |
| **Updating**      | Update all packages            | `pacman -Syu`                 | `yay -Syu`                 |
|                   | Refresh package databases      | `pacman -Sy`                  | `yay -Sy`                  |
|                   | Upgrade AUR packages only      | _N/A_                         | `yay -Sua`                 |
|                   | Update dev (`-git`) packages   | _N/A_                         | `yay -Syu --devel`         |
| **Removing**      | Remove package only            | `pacman -R <package>`         | `yay -R <package>`         |
|                   | Remove with unused deps        | `pacman -Rs <package>`        | `yay -Rs <package>`        |
|                   | Remove with config & deps      | `pacman -Rns <package>`       | `yay -Rns <package>`       |
| **Cleaning**      | List orphaned packages         | `pacman -Qdt`                 | `yay -Yqdt`                |
|                   | Remove orphaned packages       | `pacman -Rns $(pacman -Qdtq)` | `yay -Yc`                  |
|                   | Clean cache (keep 3 versions)  | `pacman -Sc`                  | `yay -Sc`                  |
|                   | Clean all cached packages      | `pacman -Scc`                 | `yay -Scc`                 |
| **Miscellaneous** | Show config                    | _Edit `/etc/pacman.conf`_     | `yay -P`                   |
|                   | Download AUR PKGBUILD          | _N/A_                         | `yay -G <aur-package>`     |


