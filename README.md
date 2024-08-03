# dotfiles

Finally organizing config with dotfiles

## Setup .files

```sh
$ stow .
```

## Neovim

### Keymaps

- `d` commands
    -   `dd` -> for deleting line
    -   `u` -> undo the previous action
    -   `ctrl + r` -> redo the previous action
    -   `d3j` -> delete there below lines
    -   `dw`, `d2w` ->  delete next one, two words repectively
    -   `db`, `d2b` ->  delete previous one, two words repectively

### NvChad

-   `<leader> + th` -> changing theme
-   `esc` -> escaping from the current buffer
-   `v + it` -> for selecting tag block of code
-   `qq` after recoreding macro `q` again, then `@q` to perform the macro
-   `:MasonInstallAll` -> install all mason packages
-   `:Lazy sync` -> sync plugins with lazy plugins manager
-   `:NvCheatsheet` -> show nvchat cheat sheet
-   `:Telescope keymaps` -> show telescope keymaps
-   `:source %` -> source lua file

## Warp

### Keymaps

- `^r` -> fuzzy find commands history
- `^~` -> to prompt warp ai

