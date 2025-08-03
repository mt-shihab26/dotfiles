-- General Editor Behavior
vim.o.swapfile = false         -- Disable swap file creation to reduce clutter
vim.o.undofile = true          -- Enable persistent undo history across sessions
vim.o.wrap = false             -- Disable line wrapping (long lines scroll horizontally)
vim.o.signcolumn = "yes"       -- Always show the sign column (avoids text shifting)

-- Cursor and Line Display
vim.o.cursorline = true        -- Highlight the current line for visibility
vim.o.number = true            -- Show absolute line number on the current line
vim.o.relativenumber = true    -- Show relative numbers on other lines (useful for motions)

-- Indentation and Tabs
-- =========================================
vim.o.tabstop = 4              -- Number of spaces a <Tab> character displays as
vim.o.shiftwidth = 4           -- Number of spaces used for each indent level

-- Invisible Characters Display
-- =========================================
vim.o.list = true              -- Display invisible characters (tabs, spaces, etc.)
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
  vim.o.clipboard = "unnamedplus"   -- Use system clipboard for all yank/paste actions
end)

