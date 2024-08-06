local map = vim.keymap.set

local opts = function(options)
    local default_options = { noremap = true, silent = true }
    return vim.tbl_extend("force", default_options, options or {})
end

-- use jk to exit insert mode
map("i", "jk", "<ESC>", opts { desc = "Exit insert mode with jk" })

-- clear search highlights
-- map("n", "<leader>nh", ":nohl<CR>", opts({ desc = "Clear search highlights" }))

-- delete single character without copying into register
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
map("n", "<leader>fc", "<cmd>Telescope git_commits<CR>", opts { desc = "Telescope git commits" })
map("n", "<leader>fs", "<cmd>Telescope git_status<CR>", opts { desc = "Telescope git status" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts { desc = "Telescope find buffers" })

-- Barbar Tabs
map("n", "<tab>", "<Cmd>BufferNext<CR>", opts { desc = "Next buffer" })
map("n", "<S-tab>", "<Cmd>BufferPrevious<CR>", opts { desc = "Previous buffer" })
-- map("n", "<t-0>", "<Cmd>BufferLast<CR>", opts { desc = "Go to last buffer" })
-- map("n", "<t-1>", "<Cmd>BufferGoto 1<CR>", opts { desc = "Go to buffer 1" })
-- map("n", "<t-2>", "<Cmd>BufferGoto 2<CR>", opts { desc = "Go to buffer 2" })
-- map("n", "<t-3>", "<Cmd>BufferGoto 3<CR>", opts { desc = "Go to buffer 3" })
-- map("n", "<t-4>", "<Cmd>BufferGoto 4<CR>", opts { desc = "Go to buffer 4" })
-- map("n", "<t-5>", "<Cmd>BufferGoto 5<CR>", opts { desc = "Go to buffer 5" })
-- map("n", "<t-6>", "<Cmd>BufferGoto 6<CR>", opts { desc = "Go to buffer 6" })
-- map("n", "<t-7>", "<Cmd>BufferGoto 7<CR>", opts { desc = "Go to buffer 7" })
-- map("n", "<t-8>", "<Cmd>BufferGoto 8<CR>", opts { desc = "Go to buffer 8" })
-- map("n", "<t-9>", "<Cmd>BufferGoto 9<CR>", opts { desc = "Go to buffer 9" })
