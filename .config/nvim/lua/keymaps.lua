vim.keymap.set("n", "q", "<nop>", { desc = "disable macro recording" })

vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "clear search highlighting" })

vim.keymap.set("x", "p", '"_dP', { desc = "paste without yanking selected text" })

vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "move to left window" })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "move to below window" })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "move to above window" })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "move to right window" })

vim.keymap.set("n", "l", require "utils.open_last_file", { desc = "open last file or move right" })

vim.keymap.set("n", "<leader>ti", require "utils.toggle_indent_char", { desc = "toggle tabs/spaces for indentation" })
vim.keymap.set("n", "<leader>tw", require "utils.toggle_wrap", { desc = "toggle line wrapping on/off" })

vim.keymap.set("n", "<leader>cp", require "utils.copy_file_path", { desc = "copy current file relative path" })
vim.keymap.set("n", "<leader>ca", require "utils.copy_file_abs_path", { desc = "copy current file absolute path" })
vim.keymap.set("n", "<leader>cf", require "utils.copy_file_name", { desc = "copy current file name with extension" })

vim.keymap.set("n", "<leader>e", "<cmd>Neotree action=focus<cr>", { desc = "focus file tree (neo-tree)", remap = true })
vim.keymap.set("n", "<leader>p", "<cmd>Neotree action=close<cr>", { desc = "close file tree (neo-tree)", remap = true })

vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "prev buffer (bufferline)" })
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "next buffer (bufferline)" })
vim.keymap.set("n", "<leader>Q", "<cmd>bp<bar>sp<bar>bn<bar>bd<cr>", { desc = "close current buffer (bufferline)" })
vim.keymap.set(
    "n",
    "<leader>q",
    require "utils.close_terminals_or_others",
    { desc = "close terminals or other buffers (bufferline)" }
)
vim.keymap.set(
    "n",
    "<leader>cl",
    "<cmd>BufferLineCloseRight<cr>",
    { desc = "delete buffers to the right (bufferline)" }
)
vim.keymap.set("n", "<leader>ch", "<cmd>BufferLineCloseLeft<cr>", { desc = "delete buffers to the left (bufferline)" })

local telescope = require "utils.telescope"

vim.keymap.set("n", "<leader>f", telescope.find_files, { desc = "find files (telescope)" })
vim.keymap.set("n", "<leader>F", telescope.find_all_files, { desc = "find all files (telescope)" })
vim.keymap.set("n", "<leader>g", telescope.grep_files, { desc = "grep files (telescope)" })
vim.keymap.set("n", "<leader>G", telescope.grep_all_files, { desc = "grep all files (telescope)" })
vim.keymap.set("n", "<leader>h", telescope.help_tags, { desc = "help tags (telescope)" })
vim.keymap.set("n", "<leader>H", telescope.lsp_document_symbols, { desc = "lsp document symbols (telescope)" })

vim.keymap.set("n", "]h", "<cmd>silent Gitsigns next_hunk<cr>", { desc = "navigate to the next git hunk (gitsigns)" })
vim.keymap.set(
    "n",
    "[h",
    "<cmd>silent Gitsigns prev_hunk<cr>",
    { desc = "navigate to the previous git hunk (gitsigns)" }
)
