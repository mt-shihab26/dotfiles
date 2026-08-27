local map = vim.keymap.set

-- general
map("n", "q", "<nop>", { desc = "disable macro recording" })
map("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "clear search highlighting" })
map("x", "p", '"_dP', { desc = "paste without yanking selected text" })

-- toggle
local toggle = require "lib.toggle"

map("n", "<leader>ti", toggle.indent_char, { desc = "toggle tabs/spaces for indentation" })
map("n", "<leader>tw", toggle.wrap, { desc = "toggle line wrapping on/off" })

-- window navigation
map("n", "<leader>j", "<C-w>j", { desc = "move to below window" })
map("n", "<leader>k", "<C-w>k", { desc = "move to above window" })
map("n", "<leader>l", "<C-w>l", { desc = "move to right window" })

map("n", "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", { desc = "navigate left window (tmux)" })
map("n", "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>", { desc = "navigate down window (tmux)" })
map("n", "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>", { desc = "navigate up window (tmux)" })
map("n", "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>", { desc = "navigate right window (tmux)" })

-- buffers (bufferline)
local buffer = require "lib.buffer"

map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "prev buffer (bufferline)" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "next buffer (bufferline)" })
map("n", "<leader>Q", "<cmd>bp<bar>sp<bar>bn<bar>bd<cr>", { desc = "close current buffer (bufferline)" })
map("n", "<leader>q", buffer.close_terminals_or_others, { desc = "close terminals or other buffers (bufferline)" })
map("n", "<leader>cl", "<cmd>BufferLineCloseRight<cr>", { desc = "delete buffers to the right (bufferline)" })
map("n", "<leader>ch", "<cmd>BufferLineCloseLeft<cr>", { desc = "delete buffers to the left (bufferline)" })

map("n", "l", buffer.open_last_file, { desc = "open last file or move right" })

-- file tree (neo-tree)
map("n", "<leader>e", "<cmd>Neotree action=focus<cr>", { desc = "focus file tree (neo-tree)", remap = true })
map("n", "<leader>p", "<cmd>Neotree action=close<cr>", { desc = "close file tree (neo-tree)", remap = true })

-- clipboard
local clipboard = require "lib.clipboard"

map("n", "<leader>cp", clipboard.path, { desc = "copy current file relative path" })
map("n", "<leader>ca", clipboard.abs_path, { desc = "copy current file absolute path" })
map("n", "<leader>cf", clipboard.name, { desc = "copy current file name with extension" })

-- fuzzy finding (telescope)
local telescope = require "lib.telescope"

map("n", "<leader>f", telescope.find_files, { desc = "find files (telescope)" })
map("n", "<leader>F", telescope.find_all_files, { desc = "find all files (telescope)" })
map("n", "<leader>g", telescope.grep_files, { desc = "grep files (telescope)" })
map("n", "<leader>G", telescope.grep_all_files, { desc = "grep all files (telescope)" })
map("n", "<leader>h", telescope.help_tags, { desc = "help tags (telescope)" })
map("n", "<leader>H", telescope.lsp_document_symbols, { desc = "lsp document symbols (telescope)" })

-- search and replace (spectre)
local spectre = require "lib.spectre"

map("n", "<leader>s", spectre.search_buffer, { desc = "search on current buffer (spectre)" })
map("n", "<leader>S", spectre.search_word, { desc = "search on multi buffers (spectre)" })
map("v", "<leader>S", spectre.search_selection, { desc = "search on multi buffers (spectre)" })

-- git (lazygit, gitsigns)
map("n", "]h", "<cmd>silent Gitsigns next_hunk<cr>", { desc = "navigate to the next git hunk (gitsigns)" })
map("n", "[h", "<cmd>silent Gitsigns prev_hunk<cr>", { desc = "navigate to the previous git hunk (gitsigns)" })
map("n", "<leader>L", "<cmd>LazyGit<cr>", { desc = "open lazygit window (lazygit)", remap = true })

-- discoverability (which-key)
local which_key = require "lib.which_key"

map("n", "<leader>?", which_key.show_buffer_local, { desc = "buffer local keymaps (which-key)" })

-- lsp
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
        map("n", "<leader>d", diagnostic.open_float, opts "show hover diagnostics (lspconfig)")

        map("n", "<leader>h", buf.signature_help, opts "signature help (lspconfig)")
        map("n", "<leader>a", buf.code_action, opts "code actions (lspconfig)")
        map("n", "<leader>r", buf.rename, opts "rename symbol (lspconfig)")

        map("n", "[d", diagnostic.goto_prev, opts "go to prev diagnostic (lspconfig)")
        map("n", "]d", diagnostic.goto_next, opts "go to next diagnostic (lspconfig)")

        map("n", "<leader>ls", function()
            vim.cmd "LspStart"
        end, opts "start LSP server")
        map("n", "<leader>lS", function()
            vim.cmd "LspStop"
        end, opts "stop LSP server")
        map("n", "<leader>lr", function()
            vim.cmd "LspRestart"
        end, opts "restart LSP server")
    end,
})
