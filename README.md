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
    - `^r` -> Redo the previous action

## Insert Mode

- enter insert mode
    - `i` -> enter insert mode before the cursor
    - `a` -> enter insert mode after the cursor
    - `o` -> enter insert mode below the cursor
- exit insert mode
    - `esc`
    - `^[`
    - `^c`

## Visual Mode

- enter visual mode
    - `v` -> enter character-wise visual mode
    - `V` -> enter line-wise visual mode
- visual mode operations
    - use any normal mode motion commands to select text
    - `y` -> copy (yank) the selected text
    - `yy` -> Copy (yank) the whole current line
    - `d` -> delete the selected text (also copies it)
    - `p` -> paste the copied or deleted content
    - note: deleting text in the normal mode also copies that for pasting.

## NvChad

- general commands
    - `<leader> + th` -> Change theme
    - `Esc` -> Escape from the current buffer
    - `:MasonInstallAll` -> Install all Mason packages
    - `:Lazy sync` -> Sync plugins with Lazy plugin manager
    - `:NvCheatsheet` -> Show NvChad cheat sheet
    - `:Telescope keymaps` -> Show Telescope keymaps
    - `:source %` -> Source current Lua file
- Visual Mode
    - `v + it` -> Select tag block of code

# Warp

- `^r` -> fuzzy find commands history
- `^~` -> open warp AI prompt

