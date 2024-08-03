# dotfiles

Finally organizing config with dotfiles

# Setup .files

```sh
$ stow .
```

# Neovim

## Normal Mode

- foundational motions
    - `j` -> go down
    - `k` -> go up
    - `h` -> go left
    - `l` -> go right
    - `w` -> go right by word
    - `b` -> go left by word
- command count motions
    - `8j` -> go down to 8th line
    - `6k` -> go up to 6th line
    - `9k` -> go left to 6th line
    - `10l` -> go right to 6th line
- `d` commands
    - `dd` -> for deleting line
    - `u` -> undo the previous action
    - `ctrl + r` -> redo the previous action
    - `dj` -> delete current line with below 1 line 
    - `d3j` -> delete current line with below 3 lines
    - `dk` -> delete current line with above 1 line 
    - `d3k` -> delete current line with ebove 3 lines
    - `dw` ->  delete next 1 word
    - `d2w` ->  delete next 3 words
    - `db`->  delete previous 1 word
    - `d3b` -> delete previous 3 words

## Insert Mode 

- escaping insert mode
    -  `esc`
    -  `ctrl + [`

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

