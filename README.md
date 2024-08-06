# dotfiles

Finally organizing config with dotfiles

# Setup .files

```sh
$ stow .
```

# Warp

-   `^r` -> fuzzy find commands history
-   `^~` -> open warp AI prompt

# Neovim v0.10.1

## Normal Mode

-   fundamental motions
    -   `j` -> move down
    -   `k` -> move up
    -   `h` -> move left
    -   `l` -> move right
    -   `w` -> move right by word
    -   `b` -> move left by word
-   horizontal motions
    -   `_` -> move to first non-blank character of the line
    -   `$` -> move to end of the line
    -   `0` -> move to first character of the line (column 0)
    -   `f<char>` -> move forward to (and land on) the next occurrence of `<char>`
    -   `F<char>` -> move backward to (and land on) the previous occurrence of `<char>`
    -   `t<char>` -> move forward to (and land before) the next occurrence of `<char>`
    -   `T<char>` -> move backward to (and land after) the previous occurrence of `<char>`
    -   `;` -> repeat the last `f`, `F`, `t`, or `T` motion forward
    -   `,` -> repeat the last `f`, `F`, `t`, or `T` motion backward
-   motion with count
    -   `8j` -> move down 8 lines
    -   `6k` -> move up 6 lines
    -   `9h` -> move left 9 characters
    -   `10l` -> move right 10 characters
-   delete Commands
    -   `dd` -> delete current line
    -   `D` -> delete end of line character to current character
    -   `dj`, `d3j`, `dk`, `d3k`, `dw`, `d2w`, `db` & `d3b` -> delete with motions
    -   `d$` -> delete from current character to end of the line
-   undo/redo
    -   `u` -> Undo the previous action
    -   `^r` -> Redo the previous action

## Insert Mode

-   enter insert mode
    -   `i` -> enter insert mode before the cursor
    -   `a` -> enter insert mode after the cursor
    -   `A` -> enter insert mode end of the line
    -   `o` -> enter insert mode below the cursor
-   exit insert mode
    -   `esc`
    -   `^[`
    -   `^c`

## Visual Mode

-   enter visual mode
    -   `v` -> enter character-wise visual mode
    -   `V` -> enter line-wise visual mode
-   visual mode operations
    -   use any normal mode motion commands to select text
    -   `y` -> copy (yank) the selected text
    -   `yy` -> Copy (yank) the whole current line
    -   `d` -> delete the selected text (also copies it)
    -   `p` -> paste the copied or deleted content
    -   note: deleting text in the normal mode also copies that for pasting.
    -   `vit` -> Select tag block of code

## Keymaps

-   `<leader>th` -> open color scheme changer
-   `<leader>lg` -> open lazygit inside neovim
-   `<leader>ld` -> open lazydocker inside neovim

## Commands

-   `:source %` -> source current lua file
-   `:Lazy` -> opening lazy ui
-   `:Mason` -> opening mason ui
-   `:LspInfo` -> opening current buffer connected lsps
-   `:Lazy sync` -> update plugins with lazy plugin manager
-   `:Telescope keymaps` -> show telescope keymaps

# Lazygit

-   `$ lazygit` -> open lazygit from terminal

# Lazydocker

-   `$ lazydocker` -> open lazydocker from terminal

# Lazysql

-   `$ lazysql` -> open lazysql from terminal
