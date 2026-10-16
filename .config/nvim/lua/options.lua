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

-- display
vim.opt.wrap = false         -- long lines run off the screen instead of wrapping
vim.opt.cursorline = true    -- highlight the line the cursor is on
vim.opt.signcolumn = "yes"   -- always keep the sign column, so text doesn't shift when signs appear
vim.opt.cmdheight = 0        -- hide the command line until it is in use
vim.opt.laststatus = 3       -- one statusline at the bottom for all windows, instead of one per window
vim.opt.termguicolors = true -- use 24-bit (true) colors, so colorschemes look as designed instead of the 256 color palette
vim.opt.list = true          -- draw invisible characters using listchars below

vim.opt.listchars = {
    space = "·", -- every space
    trail = "·", -- spaces at the end of a line
    tab = "→ ", -- a tab character: arrow, then padding up to the tab width
    eol = "↲", -- the end of each line
    nbsp = "␣", -- non-breaking spaces, which otherwise look like normal ones
}

-- splits
vim.opt.splitright = true -- :vsplit opens the new window to the right of the current one, not the left
vim.opt.splitbelow = true -- :split opens the new window below the current one, not above

-- search
vim.opt.ignorecase = true    -- searches and :s match regardless of case, so /foo also finds Foo and FOO
vim.opt.smartcase = true     -- but a pattern with an uppercase letter is case-sensitive (not for * and #)
vim.opt.inccommand = "split" -- preview :s replacements live, with a split listing every affected line

-- files & undo
vim.opt.swapfile = false     -- don't write .swp files while editing (no crash recovery, no "swap file exists" warnings)
vim.opt.backup = false       -- don't keep a backup copy of the file after saving it
vim.opt.undofile = true      -- save undo history to disk, so u still works after closing and reopening a file
vim.opt.confirm = true       -- ask to save instead of failing when quitting with unsaved changes
vim.opt.isfname:append "@-@" -- treat @ as part of a file name, so gf works on paths like node_modules/@scope/pkg

-- spell
vim.opt.spelllang = "en_us" -- check spelling against American English

-- underline misspelled words (]s / [s to jump, z= for suggestions); turned on right after startup, since
-- loading the spell file would delay the first screen by ~5ms. The windows opened at startup get it too,
-- unless a script set it for them already (e.g. an ftplugin with nospell)
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.schedule(function()
            -- find them before setting the global value, which marks spell as set for every window
            -- floating windows are skipped, their "minimal" style turns spell off
            local unset = vim.tbl_filter(function(win)
                return vim.api.nvim_win_get_config(win).relative == ""
                    and vim.api.nvim_get_option_info2("spell", { win = win }).last_set_sid == 0
            end, vim.api.nvim_list_wins())
            vim.go.spell = true
            for _, win in ipairs(unset) do
                vim.wo[win].spell = true
            end
        end)
    end,
})

-- mouse
vim.opt.mouse = "a"                 -- enable the mouse in all modes: click to move, drag to select, scroll, resize splits
vim.opt.mousescroll = "ver:1,hor:2" -- scroll one line per wheel event, a trackpad sends many of them per swipe

-- clipboard (deferred to avoid startup latency)
vim.schedule(function()
    local omarchy_remote_clipboard = require "lib.omarchy_remote_clipboard"
    omarchy_remote_clipboard.setup()
    vim.opt.clipboard = "unnamedplus"
end)
