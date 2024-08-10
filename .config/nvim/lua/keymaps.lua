local map = vim.keymap.set
local wk = require "which-key"

local opts = function(options)
    local default_options = { noremap = true, silent = true }
    return vim.tbl_extend("force", default_options, options or {})
end

map("i", "jk", "<ESC>", opts { desc = "exit insert mode" })

-- Comment

map("n", "<leader>/", "gcc", opts { desc = "comment toggle", remap = true })
map("v", "<leader>/", "gc", opts { desc = "comment toggle", remap = true })

-- LSP Config
map("n", "K", vim.lsp.buf.hover, opts { desc = "show hover information" })
map("n", "L", vim.diagnostic.open_float, opts { desc = "show hover line diagnostics" })
map("n", "<leader>k", vim.lsp.buf.signature_help, opts { desc = "show signature help" })
map("n", "<leader>D", vim.lsp.buf.type_definition, opts { desc = "show type definition" })
map("n", "gd", vim.lsp.buf.definition, opts { desc = "go to definition" })
map("n", "gD", vim.lsp.buf.declaration, opts { desc = "go to declaration" })
map("n", "gi", vim.lsp.buf.implementation, opts { desc = "go to implementation" })
map("n", "gr", vim.lsp.buf.references, opts { desc = "list all references" })
map("n", "<leader>r", vim.lsp.buf.rename, opts { desc = "rename symbol" })
map({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts { desc = "show code action" })

-- Tree
wk.add {
    { "<leader>e", "<cmd>NvimTreeFocus<CR>", mode = "n", desc = "open file tree" },
    { "<leader>p", "<cmd>NvimTreeClose<CR>", mode = "n", desc = "close file tree" },
    { "<C-n>", "<cmd>NvimTreeToggle<CR>", mode = "n", desc = "toggle file tree" },
}

-- Telescope
wk.add {
    { "<leader>f", group = "telescope" },
    { "<leader>ff", "<cmd>TelescopeProjectFiles<CR>", mode = "n", desc = "find file" },
    { "<leader>fw", "<cmd>Telescope live_grep<CR>", mode = "n", desc = "live grep" },
    { "<leader>fd", "<cmd>TelescopeDotFiles<CR>", mode = "n", desc = "find dotfiles" },
}

-- Tabs
wk.add {
    { mode = "n", "<tab>", "<cmd>BufferLineCycleNext<CR>", desc = "next buffer" },
    { mode = "n", "<S-tab>", "<cmd>BufferLineCyclePrev<CR>", desc = "previous buffer" },
    { mode = "n", "<leader>c", "<cmd>bp<bar>sp<bar>bn<bar>bd<CR>", desc = "close buffer" },
}

-- Colorscheme
map("n", "<leader>tc", "<cmd>Themery<CR>", opts { desc = "open colorscheme changer" })

-- Integrations
map("n", "<leader>lg", "<cmd>LazyGit<CR>", opts { desc = "open lazygit" })
map("n", "<leader>ld", "<cmd>LazyDocker<CR>", opts { desc = "open lazydocker" })
map("n", "<leader>ls", "<cmd>LazySQL<CR>", opts { desc = "open lazysql" })

-- Terminal
map("n", "<leader>t", "<cmd>ToggleTerm<CR>", opts { desc = "open terminal" })

-- Copy
map("n", "<leader>y", "<cmd>CopyFilePath<CR>", opts { desc = "copy file path" })

-- Git
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "preview git line change" })

-- Link open
map({ "n", "v" }, "<leader>ol", "<cmd>OpenInBrowser<CR>", opts { desc = "open in browser" })
