# Startup time

Neovim starts in about 35-40 ms on an idle machine, against about 600 ms when every plugin loaded at
startup. Neovim with no config (`nvim --clean`) takes about 15 ms.

What keeps it fast:

- `vim.loader.enable()`, the first line of `init.lua`, caches compiled Lua modules, so requiring
  them skips parsing and searching the runtimepath.
- `lua/lib/lazy.lua` loads most plugins only when they're needed.
- `options.lua` turns `spell` on right after the first screen; loading the spell file takes ~5 ms.

## When plugins load

| When                                  | Plugins                                                                                                   |
| ------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| At startup                            | theme, snacks (bigfile has to see files as they open), conform, nvim-treesitter (its queries highlight the first file), lazygit, tmux-navigator, plenary, nui, devicons, lsp-file-operations |
| Right after the first screen is drawn | cmp + luasnip, mason, lspconfig + fidget, gitsigns, lualine, bufferline, which-key, colorizer + indent-blankline, autopairs, ts-autotag, ts-comments |
| On first use                          | neo-tree, telescope, spectre, nvim-dap (+ dap-ui, dap-go, dap-rr)                                  |

Plugins that load after the first screen still attach to the files opened at startup:
`vim.lsp.enable` re-runs `FileType` for open buffers, and `plugins/colorizer.lua` attaches
colorizer to them itself.

"On first use" means any of:

| Plugin    | Loads on                                                                         |
| --------- | -------------------------------------------------------------------------------- |
| neo-tree  | `<leader>e`, `:Neotree`                                                          |
| telescope | any picker keymap, `:Telescope`, the first `vim.ui.select` menu (telescope-ui-select) |
| spectre   | `<leader>s`, `<leader>S`, `:Spectre`                                             |
| nvim-dap  | any `<leader>b...` keymap, clicking the sign column, any `:Dap...` command       |

The first use in a session takes a moment longer while the plugin loads.

## lib/lazy.lua

`lazy.add(specs, opts)` takes the same specs as `vim.pack.add`. The plugins are registered with
vim.pack at startup, so they still install, stay in `nvim-pack-lock.json` and are kept by
`:PackUpdate` and `:PackPrune`. They're only put on the runtimepath, sourced and set up when one
of these triggers fires:

| Option     | Loads the plugin when                                                                             |
| ---------- | ------------------------------------------------------------------------------------------------- |
| `modules`  | one of these Lua modules (or a submodule) is required, e.g. `require "telescope.builtin"` in a keymap |
| `commands` | one of these commands runs (or is completed on the command line), the command then runs as typed |
| `defer`    | right after startup, once the files are opened and the first screen is drawn                     |

`setup` runs once, right after the plugin loads. `lazy.add` returns a function that loads the
plugin straight away, which `plugins/telescope.lua` uses for its `vim.ui.select` stub.

```lua
local lazy = require "lib.lazy"

lazy.add({
    {
        src = "https://github.com/nvim-pack/nvim-spectre",
        version = "master",
    },
}, {
    modules = { "spectre" },
    commands = { "Spectre" },
    setup = function()
        require("spectre").setup {}
    end,
})
```

## Adding a plugin

- Use `lazy.add` unless the plugin has to act before or while the first file opens (theme, bigfile
  detection, treesitter queries). Prefer `modules`/`commands` for plugins used on demand and
  `defer` for everything else.
- Plugins shared by several others (plenary, nui, devicons) go in a plain `vim.pack.add`, so they
  are on the runtimepath for whichever plugin loads first.
- Don't require a lazy plugin at the top level of a file that runs at startup (`keymaps.lua`,
  `lib/*.lua`). Require it inside the function that uses it. `lib/dap.lua` looks nvim-dap up
  through a proxy table for the same reason.
- Watch for plugins that load others while setting up: lsp-file-operations requires neo-tree in
  its `setup`, so its setup runs when neo-tree loads (`plugins/neo-tree.lua`).

## Further improvements

What's left, with the costs measured on this machine. Most of the remaining startup time is Neovim
itself (~15 ms), the theme and plugin registration.

### Before the first screen

| Change                                                                                                        | Costs now  | Notes                                       |
| ------------------------------------------------------------------------------------------------------------- | ---------- | ------------------------------------------- |
| Load `snacks.image` and the patches in `lib/image.lua` only when an image opens                               | ~2 ms      | they have to be in place before `nvim picture.png` renders, so this needs a BufReadCmd hook |
| Skip built-in plugins that aren't used: the system `fzf.vim` (Arch puts `/usr/share/vim/vimfiles` on the runtimepath), gzip, tar, zip, tohtml, tutor | ~2 ms      | loses `:FZF` and opening .gz/.zip files; keep netrw, it's used |

Ruled out: the theme (~7 ms) is mostly sourcing the colorscheme and vim.pack's first call reading its
lockfile, both needed. ShaDa takes 2-3 ms to read, not worth trimming the history for.

### After the first screen

About 250-300 ms of work, including starting the language servers, once the screen is drawn. It
doesn't delay the first screen, but it's work the editor does before it's fully ready.

| Change                                                                                                        | Costs now   | Notes                                     |
| ------------------------------------------------------------------------------------------------------------- | ----------- | ----------------------------------------- |
| Colorizer only for the file types that have colors (css, html, js/ts, ...), or without `tailwind = true`      | ~45 ms      | setup ~13 ms, the first attach ~35 ms with tailwind and ~12 ms without |
| Load cmp on `InsertEnter`, or replace nvim-cmp with blink.cmp                                                 | 18-25 ms    | cmp_nvim_lsp's capabilities would have to come without loading cmp |
| Drop mason-lspconfig's setup                                                                                  | ~10 ms      | mason-tool-installer uses it to map tool names, check `lists/binaries.lua` installs on a new machine |

Done already: one `vim.lsp.enable(servers)` call instead of one per server. It made no measurable
difference, `vim.lsp.enable` only re-runs its own `FileType` handler.

### Replacing plugins

These don't change startup any more, since the plugins already load on first use, but they make that
first use faster: snacks.explorer or mini.files for neo-tree, snacks.picker for telescope, grug-far
for spectre, mini.statusline and mini.tabline for lualine and bufferline.

## Profiling

```sh
# startup time, the last lines read "--- NVIM STARTED ---"
nvim --headless --startuptime /tmp/startup.log +qa
grep 'NVIM STARTED' /tmp/startup.log

# slowest requires and sourced files
sort -k2 -rn /tmp/startup.log | head -20

# check what's loaded after startup, e.g. that a lazy plugin didn't load early
nvim --headless +'lua print(package.loaded["neo-tree"] ~= nil)' +qa
```

Run the first command a few times, the numbers vary between runs. `--startuptime` stops at
`NVIM STARTED`, so the plugins that load after the first screen (about 250-300 ms of work, mostly
colorizer, cmp and the language servers starting) don't show in it.
