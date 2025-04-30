-- Leader Key Configuration
vim.g.mapleader = " " -- Set the leader key to space
vim.g.maplocalleader = "\\" -- Set the local leader key to backslash

-- Line numbering
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers

-- Visual indicators
vim.opt.cursorline = true -- Highlight the current line
vim.opt.signcolumn = "yes" -- Always show the sign column
vim.opt.list = true -- Show invisible characters
vim.opt.listchars = { space = "·", trail = "·", tab = "→ ", eol = "↲", nbsp = "␣" } -- Define how invisible chars appear

-- Window behavior
vim.opt.splitright = true -- Open new vertical splits to the right
vim.opt.splitbelow = true -- Open new horizontal splits below
vim.wo.wrap = false -- Don't wrap lines
vim.opt.scrolloff = 10 -- Keep 10 lines visible above/below cursor

-- Indentation settings
vim.opt.tabstop = 4 -- Number of spaces a tab counts for
vim.opt.shiftwidth = 4 -- Number of spaces to use for autoindent
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.autoindent = true -- Copy indent from current line when starting a new line
vim.opt.breakindent = true -- Wrapped lines preserve indentation

-- Search settings
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true -- Override ignorecase if search contains uppercase
vim.opt.inccommand = "split" -- Show preview of substitutions in a split

-- Clipboard
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus" -- Use system clipboard
end)

-- Mouse support
vim.opt.mouse = "a" -- Enable mouse in all modes

-- Files and Backup
vim.opt.undofile = true -- Enable persistent undo history
vim.opt.swapfile = false -- Disable swap files

-- Performance and Timing
vim.opt.updatetime = 250 -- Faster completion and other operations
vim.opt.timeoutlen = 300 -- Time to wait for a mapped sequence to complete

-- Spell Checking
vim.opt.spelllang = "en_us" -- Set spelling language to US English
vim.opt.spell = true -- Enable spell checking
