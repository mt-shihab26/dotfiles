local map = vim.keymap.set

local opts = function(options)
    local default_options = { noremap = true, silent = true }
    return vim.tbl_extend("force", default_options, options or {})
end

map("i", "jk", "<ESC>", opts { desc = "exit insert mode" })
-- map("n", "<leader>nh", ":nohl<CR>", opts({ desc = "Clear search highlights" }))
-- map("n", "x", '"_x', opts())

-- Windows
-- map("n", "<leader>sv", "<C-w>v", opts({ desc = "Split window vertically" }))
-- map("n", "<leader>sh", "<C-w>s", opts({ desc = "Split window horizontally" }))
-- map("n", "<leader>se", "<C-w>=", opts({ desc = "Make splits equal size" }))
-- map("n", "<leader>sx", "<cmd>close<CR>", opts({ desc = "Close current split" }))

-- Comment
map("n", "<leader>/", "gcc", opts { desc = "comment toggle", remap = true })
map("v", "<leader>/", "gc", opts { desc = "comment toggle", remap = true })

-- LSP Config
map("n", "gd", vim.lsp.buf.definition, opts { desc = "go to definition" })
map("n", "K", vim.lsp.buf.hover, opts { desc = "show hover information" })
map({ "n", "v" }, "L", vim.lsp.buf.code_action, opts { desc = "show code actions" })

-- Tree
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", opts { desc = "open file tree" })
map("n", "<leader>p", "<cmd>NvimTreeClose<CR>", opts { desc = "close file tree" })
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", opts { desc = "toggle file tree" })

-- Telescope
map("n", "<leader>ff", "<cmd>TelescopeProjectFiles<CR>", opts { desc = "find files" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", opts { desc = "live grep" })

-- Tabs
map("n", "<tab>", "<cmd>BufferLineCycleNext<CR>", opts { desc = "next buffer" })
map("n", "<S-tab>", "<cmd>BufferLineCyclePrev<CR>", opts { desc = "previous buffer" })
map("n", "<C-x>", ":bp<bar>sp<bar>bn<bar>bd<CR>", opts { desc = "close buffer" })

-- Colorscheme
map("n", "<leader>cs", "<cmd>Themery<CR>", opts { desc = "open colorscheme changer" })

-- Integrations
map("n", "<leader>lg", "<cmd>LazyGit<CR>", opts { desc = "open lazygit" })
map("n", "<leader>ld", "<cmd>LazyDocker<CR>", opts { desc = "open lazydocker" })
map("n", "<leader>ls", "<cmd>LazySQL<CR>", opts { desc = "open lazysql" })

-- Terminal
map("n", "<leader>t", "<cmd>ToggleTerm<CR>", opts { desc = "open terminal" })
