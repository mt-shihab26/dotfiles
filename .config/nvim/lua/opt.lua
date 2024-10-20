-- Options are loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt
local g = vim.g

-- indentation
opt.tabstop = 4 -- 4 spaces for tabs (prettier default)
opt.shiftwidth = 4 -- 4 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.swapfile = false

-- spell
opt.spell = true
opt.spelllang = "en_us"

-- -- font
-- opt.guifont = "CaskaydiaMono Nerd Font:h12"
-- g.WebDevIconsUnicodeDecorateFolderNodes = 1 -- Enable Nerd Font icons
-- g.WebDevIconsUnicodeDecorateFileNodes = 1 -- Enable Nerd Font icons

-- php
g.lazyvim_php_lsp = "intelephense"
