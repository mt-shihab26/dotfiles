# dotfiles

My [Omarchy](https://omarchy.org) config, with a fully custom Neovim setup.

Omarchy provides the base system (Hyprland, the Omarchy shell, themes). This repo layers my
own changes on top of it and is linked into `~` with [GNU Stow](https://www.gnu.org/software/stow/).

## What's inside

- **Neovim** (`.config/nvim`): built from scratch, not a distro. Plugins via the built-in
  `vim.pack`, plus custom LSP, formatter, Treesitter, Telescope and snippet setup.
- **Omarchy overrides**: Hyprland keybindings and window rules (`.config/hypr/overwrite.lua`),
  bar plugins (`.setup/os/top-bar.sh`), wallpaper fitted without cropping
  (`.config/omarchy/plugins/mt-shihab26.background`, enabled by `.setup/os/background.sh`).
- **KDE apps instead of Omarchy's GNOME ones**: Dolphin, Okular, Kate (set up as a minimal
  gedit-style editor), Partition Manager and Ark, one script each in `.setup/os`.
- **Shell and terminals**: zsh, tmux with a sessionizer, kitty and ghostty.
- **Scripts** (`.bin`): sessionizer, wallpaper cycling, notes autocommit and other helpers.

## Install

```sh
git clone https://github.com/mt-shihab26/dotfiles.git ~/dotfiles
cd ~/dotfiles
./link.sh
```

Then run whichever setup scripts you need from `.setup/`, e.g. `.setup/os/dolphin.sh`.
Packages are installed through the Omarchy CLI (`omarchy pkg add`).

## Uninstall

```sh
cd ~/dotfiles
./unlink.sh
```
