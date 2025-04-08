# Neovim

## Vim Motion

-

## Normal Mode

- fundamental motions
    - `j` -> move down
    - `k` -> move up
    - `h` -> move left
    - `l` -> move right
    - `w` -> move right by word
    - `b` -> move left by word
- horizontal motions
    - `_` -> move to first non-blank character of the line
    - `$` -> move to end of the line
    - `0` -> move to first character of the line (column 0)
    - `f<char>` -> move forward to (and land on) the next occurrence of `<char>`
    - `F<char>` -> move backward to (and land on) the previous occurrence of `<char>`
    - `t<char>` -> move forward to (and land before) the next occurrence of `<char>`
    - `T<char>` -> move backward to (and land after) the previous occurrence of `<char>`
    - `;` -> repeat the last `f`, `F`, `t`, or `T` motion forward
    - `,` -> repeat the last `f`, `F`, `t`, or `T` motion backward
- motion with count
    - `8j` -> move down 8 lines
    - `6k` -> move up 6 lines
    - `9h` -> move left 9 characters
    - `10l` -> move right 10 characters
- delete Commands
    - `dd` -> delete current line
    - `D` -> delete end of line character to current character
    - `dj`, `d3j`, `dk`, `d3k`, `dw`, `d2w`, `db` & `d3b` -> delete with motions
    - `d$` -> delete from current character to end of the line
- undo/redo
    - `u` -> Undo the previous action
    - `^r` -> Redo the previous action

## Insert Mode

- enter insert mode
    - `i` -> enter insert mode before the cursor
    - `a` -> enter insert mode after the cursor
    - `A` -> enter insert mode end of the line
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
    - `vit` -> Select tag block of code

## Commands

- `:source %` -> source current lua file
- `:Lazy` -> opening lazy ui
- `:Mason` -> opening mason ui
- `:LspInfo` -> opening current buffer connected lsps
- `:Lazy sync` -> update plugins with lazy plugin manager
- `:Telescope keymaps` -> show telescope keymaps

## Keymaps

- maps
    - `<esc>` -> clear search highlighting
    - `<leader>t` -> toggle tabs/spaces for indentation
- which-key
    - `<leader>?`-> buffer local key maps
- file explore (neo-tree, oil)
    - `<leader>e` -> focus file tree (neo-tree)
    - `<leader>p` -> close file tree (neo-tree)
    - `<leader>E` -> open directories as buffer (oil)
- bufferline
    - `<S-h>` -> prev buffer
    - `<S-l>` -> next buffer
    - `<leader>q` -> close current buffer
    - `<leader>Q` -> delete other buffers
- telescope
    - `<leader>f>`-> find finds
    - `<leader>F>`-> find all finds
    - `<leader>g>`-> grep finds
    - `<leader>G>`-> grep all finds
    - `<leader>h>`-> help tags
    - `<leader>H>`-> lsp document symbols
- lspconfig
    - `gd` -> go to definition
    - `gD` -> go to declaration
    - `gr` -> go to references
    - `gi` -> go to implementation
    - `K` -> show hover documentation
    - `<C-k>` -> show hover diagnostics
    - `<leader>h` -> signature help
    - `<leader>a` -> code actions
    - `<leader>r` -> rename symbol
    - `[d` -> go to prev diagnostic
    - `]d` -> go to next diagnostic
- cmp
    - `<Tab>` -> next suggestion
    - `<S-Tab>` -> prev suggestion
    - `<CR>` -> complete item
- tools
    - `<leader>lg` -> open lazygit
- spell
    - `z=` -> show spelling suggestions
    - `zg` -> add word to spell list
    - `zw` -> mark the word as incorrect
    - `[s` -> go to prev misspelled word
    - `]s` -> go to next misspelled word

## Plugins

plugins keymaps, docs etc

### spectre (nvim-pack/nvim-spectre)

#### keymaps

- `<leader>s` -> search on current buffer (spectre)
- `<leader>S` -> search on multi buffers (spectre)
