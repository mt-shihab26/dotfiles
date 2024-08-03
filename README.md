# dotfiles

Finally organizing config with dotfiles

# Setup .files

```sh
$ stow .
```

# Neovim

## Normal Mode

- basic motions
    - `j` -> move down
    - `k` -> move up
    - `h` -> move left
    - `l` -> move right
    - `w` -> move right by word
    - `b` -> move left by word
- motion with count
    - `8j` -> move down 8 lines
    - `6k` -> move up 6 lines
    - `9h` -> move left 9 characters
    - `10l` -> move right 10 characters
- delete Commands
    - `dd` -> delete current line
    - `dj` -> delete current line and 1 line below
    - `d3j` -> delete current line and 3 lines below
    - `dk` -> delete current line and 1 line above
    - `d3k` -> delete current line and 3 lines above
    - `dw` -> delete next word
    - `d2w` -> delete next 2 words
    - `db` -> delete previous word
    - `d3b` -> delete previous 3 words
- undo/redo
    - `u` -> Undo the previous action
    - `Ctrl + r` -> Redo the previous action

## Insert Mode

- enter insert mode
    - `i` -> enter insert mode before the cursor
    - `a` -> enter insert mode after the cursor
    - `o` -> enter insert mode below the cursor
- exit insert mode
    - `esc`
    - `ctrl + [`
    - `ctrl + c`

## Visual Mode

-

## NvChad

-   `<leader> + th` -> changing theme
-   `esc` -> escaping from the current buffer
-   `v + it` -> for selecting tag block of code
-   `qq` after recoreding macro `q` again, then `@q` to perform the macro
-   `:MasonInstallAll` -> install all mason packages
-   `:Lazy sync` -> sync plugins with lazy plugins manager
-   `:NvCheatsheet` -> show nvchat cheat sheet
-   `:Telescope keymaps` -> show telescope keymaps
-   `:source %` -> source lua file

# Warp

## Keymaps

- `^r` -> fuzzy find commands history
- `^~` -> to prompt warp ai

