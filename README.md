# dotfiles

Finally organizing config with dotfiles

## Setup .files

```sh
$ stow .
```

## .config/nvim

### Keymaps

-   `<leader> + th` -> changing theme
-   `esc` -> escaping from the current buffer
-   `v + it` -> for selecting tag block of code
-   `qq` after recoreding macro `q` again, then `@q` to perform the macro

### Commands

-   `:MasonInstallAll` -> install all mason packages
-   `:Lazy sync` -> sync plugins with lazy plugins manager
-   `:NvCheatsheet` -> show nvchat cheat sheet
-   `:Telescope keymaps` -> show telescope keymaps
-   `:source %` -> source lua file
