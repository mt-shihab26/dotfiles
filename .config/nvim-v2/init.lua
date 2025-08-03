-- General Editor Behavior
vim.opt.swapfile = false         -- Disable swap file creation to reduce clutter
vim.opt.undofile = true          -- Enable persistent undo history across sessions
vim.opt.wrap = false             -- Disable line wrapping (long lines scroll horizontally)
vim.opt.signcolumn = "yes"       -- Always show the sign column (avoids text shifting)

-- Cursor and Line Display
vim.opt.cursorline = true        -- Highlight the current line for visibility
vim.opt.number = true            -- Show absolute line number on the current line
vim.opt.relativenumber = true    -- Show relative numbers on other lines (useful for motions)

-- Indentation and Tabs
-- =========================================
vim.opt.tabstop = 4              -- Number of spaces a <Tab> character displays as
vim.opt.shiftwidth = 4           -- Number of spaces used for each indent level

-- Invisible Characters Display
-- =========================================
vim.opt.list = true              -- Display invisible characters (tabs, spaces, etc.)
-- Customize how invisible characters are shown in the editor
vim.opt.listchars = {
  space = "·",     -- Space characters
  trail = "·",     -- Trailing spaces
  tab = "→ ",      -- Tabs (→ followed by a space for alignment)
  eol = "↲",       -- End of line
  nbsp = "␣",      -- Non-breaking space
  extends = "»",   -- Character that extends beyond the window (right side)
  precedes = "«",  -- Character that precedes the window (left side)
  conceal = "·",   -- Placeholder for concealed text (useful in markdown/code folding)
}

-- Clipboard Integration
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"   -- Use system clipboard for all yank/paste actions
end)

