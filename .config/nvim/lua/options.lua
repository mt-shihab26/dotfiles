-- leader keys
vim.g.mapleader = " "       -- space is the prefix for <leader> mappings
vim.g.maplocalleader = "\\" -- backslash is the prefix for <localleader> (filetype-specific) mappings

-- experimental ui
require "vim._core.ui2".enable {} -- redrawn cmdline and messages: no "Press ENTER" prompts, long output opens in a pager

-- netrw
vim.g.netrw_banner = 0 -- hide the help banner above the file list (toggle with I)

-- line numbers
vim.opt.number = true         -- show the real line number on the cursor line
vim.opt.relativenumber = true -- show the distance from the cursor on every other line, for jumps like 5j

-- indentation
vim.opt.tabstop = 4        -- a tab character in a file is shown 4 columns wide
vim.opt.softtabstop = 4    -- Tab and Backspace move 4 columns at a time in insert mode
vim.opt.shiftwidth = 4     -- one indent level is 4 columns for >>, << and auto-indent
vim.opt.expandtab = true   -- Tab inserts spaces instead of a tab character
vim.opt.smartindent = true -- indent new lines automatically, one level deeper after {

-- line display
vim.opt.wrap = false       -- long lines run off the screen instead of wrapping
vim.opt.cursorline = true  -- highlight the line the cursor is on
vim.opt.signcolumn = "yes" -- always keep the sign column, so text doesn't shift when signs appear
vim.opt.cmdheight = 0      -- hide the command line until it is in use
vim.opt.list = true        -- draw invisible characters using listchars below

vim.opt.listchars = {
    space = "·", -- every space
    trail = "·", -- spaces at the end of a line
    tab = "→ ", -- a tab character: arrow, then padding up to the tab width
    eol = "↲", -- the end of each line
    nbsp = "␣", -- non-breaking spaces, which otherwise look like normal ones
}

-- splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

-- files & undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.confirm = true
vim.opt.isfname:append "@-@"

-- spell
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- ui & input
vim.opt.laststatus = 3
vim.opt.termguicolors = true
vim.opt.mouse = "a"
-- scroll one line per wheel event, a trackpad sends many of them per swipe
vim.opt.mousescroll = "ver:1,hor:2"

-- block cursor, a thin bar while inserting, an underline while replacing
-- vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

-- clipboard (deferred to avoid startup latency)
vim.schedule(function()
    local omarchy_remote_clipboard = require "lib.omarchy_remote_clipboard"
    omarchy_remote_clipboard.setup()
    vim.opt.clipboard = "unnamedplus"
end)

-- LSP sends malformed colors (float > 1.0 → >255 → 7-digit hex), disable until upstream fix.
if vim.lsp.document_color then
    vim.lsp.document_color.enable(false)
end
-- Suppress handler for in-flight responses that arrive after disable.
vim.lsp.handlers["textDocument/documentColor"] = function() end

-- highlight yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank()
    end,
})

-- custom filetype detection
local filetype = require "lib.filetype"
filetype.mdx()
filetype.gitconfig()
filetype.glsl()
