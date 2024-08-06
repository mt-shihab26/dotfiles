local map = vim.keymap.set

local opts = function(options)
    local default_options = { noremap = true, silent = true }
    return vim.tbl_extend("force", default_options, options or {})
end

map("i", "jk", "<ESC>", opts { desc = "Exit insert mode with jk" })
-- map("n", "<leader>nh", ":nohl<CR>", opts({ desc = "Clear search highlights" }))
-- map("n", "x", '"_x', opts())

-- Windows
-- map("n", "<leader>sv", "<C-w>v", opts({ desc = "Split window vertically" }))
-- map("n", "<leader>sh", "<C-w>s", opts({ desc = "Split window horizontally" }))
-- map("n", "<leader>se", "<C-w>=", opts({ desc = "Make splits equal size" }))
-- map("n", "<leader>sx", "<cmd>close<CR>", opts({ desc = "Close current split" }))

-- Comment
map("n", "<leader>/", "gcc", opts { desc = "Comment toggle", remap = true })
map("v", "<leader>/", "gc", opts { desc = "Comment toggle", remap = true })

-- LSP Config
map("n", "gd", vim.lsp.buf.definition, opts { desc = "Go to definition" })
map("n", "K", vim.lsp.buf.hover, opts { desc = "Show hover information" })
map({ "n", "v" }, "L", vim.lsp.buf.code_action, opts { desc = "Show code actions" })

-- Tree
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", opts { desc = "NvimTree focus window" })
map("n", "<leader>p", "<cmd>NvimTreeClose<CR>", opts { desc = "NvimTree close" })
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", opts { desc = "NvimTree toggle window" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts { desc = "Telescope find files" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", opts { desc = "Telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts { desc = "Telescope find buffers" })
map("n", "<leader>fc", "<cmd>Telescope git_commits<CR>", opts { desc = "Telescope git commits" })
map("n", "<leader>fs", "<cmd>Telescope git_status<CR>", opts { desc = "Telescope git status" })

-- Tabs
map("n", "<tab>", "<cmd>BufferLineCycleNext<CR>", opts { desc = "Next buffer" })
map("n", "<S-tab>", "<cmd>BufferLineCyclePrev<CR>", opts { desc = "Previous buffer" })
map("n", "<C-x>", ":bp<bar>sp<bar>bn<bar>bd<CR>", opts { desc = "Close buffer" })

-- Colorscheme
map("n", "<leader>th", "<cmd>Themery<CR>", opts { desc = "Open colorscheme changer dropdown" })
