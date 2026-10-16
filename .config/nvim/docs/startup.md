# Startup time

Neovim starts in about 70 ms (about 90 ms when opening a file), against about 600 ms when every
plugin loaded at startup. Neovim with no config (`nvim --clean`) takes about 15 ms.

Two things keep it fast:

- `vim.loader.enable()`, the first line of `init.lua`, caches compiled Lua modules, so requiring
  them skips parsing and searching the runtimepath.
- `lua/lib/lazy.lua` loads most plugins only when they're needed.

## When plugins load

| When                                  | Plugins                                                                                                   |
| ------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| At startup                            | theme, snacks (bigfile has to see files as they open), gitsigns, conform, nvim-treesitter (its queries highlight the first file), lazygit, tmux-navigator, plenary, nui, devicons, lsp-file-operations |
| Right after the first screen is drawn | cmp + luasnip, mason, lspconfig + fidget, lualine, bufferline, which-key, colorizer + indent-blankline, autopairs, ts-autotag, ts-comments |
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
`NVIM STARTED`, so the plugins that load after the first screen (about 150-200 ms of work, mostly
colorizer and lspconfig) don't show in it.
