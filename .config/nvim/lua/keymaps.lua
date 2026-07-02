vim.keymap.set("n", "q", "<nop>", { desc = "disable macro recording" })

vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "clear search highlighting" })

vim.keymap.set("x", "p", '"_dP', { desc = "paste without yanking selected text" })

vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "move to left window" })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "move to below window" })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "move to above window" })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "move to right window" })

vim.keymap.set("n", "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", { desc = "navigate left window (tmux)" })
vim.keymap.set("n", "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>", { desc = "navigate down window (tmux)" })
vim.keymap.set("n", "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>", { desc = "navigate up window (tmux)" })
vim.keymap.set("n", "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>", { desc = "navigate right window (tmux)" })

vim.keymap.set("n", "l", require "utils.open_last_file", { desc = "open last file or move right" })

local toggle = require "utils.toggle"

vim.keymap.set("n", "<leader>ti", toggle.indent_char, { desc = "toggle tabs/spaces for indentation" })
vim.keymap.set("n", "<leader>tw", toggle.wrap, { desc = "toggle line wrapping on/off" })

local copy_file = require "utils.copy_file"

vim.keymap.set("n", "<leader>cp", copy_file.path, { desc = "copy current file relative path" })
vim.keymap.set("n", "<leader>ca", copy_file.abs_path, { desc = "copy current file absolute path" })
vim.keymap.set("n", "<leader>cf", copy_file.name, { desc = "copy current file name with extension" })

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

vim.keymap.set("n", "<leader>?", function() require("which-key").show { global = false } end, { desc = "buffer local keymaps (which-key)" })

vim.keymap.set("n", "<leader>L", "<cmd>LazyGit<cr>", { desc = "open lazygit window (lazygit)", remap = true })

vim.keymap.set("n", "<leader>s", function() require("spectre").open_file_search { select_word = true } end, { desc = "search on current buffer (spectre)" })
vim.keymap.set("n", "<leader>S", function() require("spectre").open_visual { select_word = true } end, { desc = "search on multi buffers (spectre)" })
vim.keymap.set("v", "<leader>S", function() require("spectre").open_visual() end, { desc = "search on multi buffers (spectre)" })

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
