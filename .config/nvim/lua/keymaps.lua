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

vim.keymap.set("n", "<leader>L", "<cmd>LazyGit<cr>", { desc = "open lazygit window (lazygit)", remap = true })

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local opts = function(desc)
            return { buffer = args.buf, noremap = true, silent = true, desc = desc }
        end

        local map = vim.keymap.set
        local buf = vim.lsp.buf
        local diagnostic = vim.diagnostic

        map("n", "gd", buf.definition, opts "go to definition (lspconfig)")
        map("n", "gD", buf.declaration, opts "go to declaration (lspconfig)")
        map("n", "gi", buf.implementation, opts "go to implementation (lspconfig)")
        map("n", "gr", buf.references, opts "go to references (lspconfig)")

        map("n", "K", buf.hover, opts "show hover documentation (lspconfig)")
        map("n", "<C-k>", diagnostic.open_float, opts "show hover diagnostics (lspconfig)")

        map("n", "<leader>h", buf.signature_help, opts "signature help (lspconfig)")
        map("n", "<leader>a", buf.code_action, opts "code actions (lspconfig)")
        map("n", "<leader>r", buf.rename, opts "rename symbol (lspconfig)")

        map("n", "[d", diagnostic.goto_prev, opts "go to prev diagnostic (lspconfig)")
        map("n", "]d", diagnostic.goto_next, opts "go to next diagnostic (lspconfig)")

        map("n", "<leader>ls", function() vim.cmd "LspStart" end, opts "start LSP server")
        map("n", "<leader>lS", function() vim.cmd "LspStop" end, opts "stop LSP server")
        map("n", "<leader>lr", function() vim.cmd "LspRestart" end, opts "restart LSP server")
    end,
})

vim.keymap.set("n", "]h", "<cmd>silent Gitsigns next_hunk<cr>", { desc = "navigate to the next git hunk (gitsigns)" })
vim.keymap.set(
    "n",
    "[h",
    "<cmd>silent Gitsigns prev_hunk<cr>",
    { desc = "navigate to the previous git hunk (gitsigns)" }
)
