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
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", opts { desc = "open file tree" })
map("n", "<leader>p", "<cmd>NvimTreeClose<CR>", opts { desc = "close file tree" })
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", opts { desc = "toggle file tree" })

-- Telescope
map("n", "<leader>ff", "<cmd>TelescopeProjectFiles<CR>", opts { desc = "find files" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", opts { desc = "live grep" })

-- Tabs
map("n", "<tab>", "<cmd>BufferLineCycleNext<CR>", opts { desc = "next buffer" })
map("n", "<S-tab>", "<cmd>BufferLineCyclePrev<CR>", opts { desc = "previous buffer" })
map("n", "<leader>c", ":bp<bar>sp<bar>bn<bar>bd<CR>", opts { desc = "close buffer" })

-- Colorscheme
map("n", "<leader>tc", "<cmd>Themery<CR>", opts { desc = "open colorscheme changer" })

-- Integrations
map("n", "<leader>lg", "<cmd>LazyGit<CR>", opts { desc = "open lazygit" })
map("n", "<leader>ld", "<cmd>LazyDocker<CR>", opts { desc = "open lazydocker" })
map("n", "<leader>ls", "<cmd>LazySQL<CR>", opts { desc = "open lazysql" })

-- Terminal
map("n", "<leader>t", "<cmd>ToggleTerm<CR>", opts { desc = "open terminal" })

-- Copy
map("n", "<leader>y", "<cmd>CopyFilePath<CR>", { desc = "copy file path" })

-- Git
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "preview git line change" })

-- ChatGPT
map("n", "<leader>gc", ":ChatGPT<CR>", opts { desc = "chatgpt" })
map({ "n", "v" }, "<leader>ge", ":ChatGPTEditWithInstruction<CR>", opts { desc = "chatgpt prompts" })
map({ "n", "v" }, "<leader>gg", ":ChatGPTRun grammar_correction<CR>", opts { desc = "chatgpt grammar correction" })
map({ "n", "v" }, "<leader>gt", ":ChatGPTRun translate<CR>", opts { desc = "chatgpt translate" })
map({ "n", "v" }, "<leader>gk", ":ChatGPTRun keywords<CR>", opts { desc = "chatgpt keywords" })
map({ "n", "v" }, "<leader>gd", ":ChatGPTRun docstring<CR>", opts { desc = "chatgpt docstring" })
map({ "n", "v" }, "<leader>ga", ":ChatGPTRun add_tests<CR>", opts { desc = "chatgpt add tests" })
map({ "n", "v" }, "<leader>go", ":ChatGPTRun optimize_code<CR>", opts { desc = "chatgpt optimize Code" })
map({ "n", "v" }, "<leader>gs", ":ChatGPTRun summarize<CR>", opts { desc = "chatgpt summarize" })
map({ "n", "v" }, "<leader>gf", ":ChatGPTRun fix_bugs<CR>", opts { desc = "chatgpt fix Bugs" })
map({ "n", "v" }, "<leader>gx", ":ChatGPTRun explain_code<CR>", opts { desc = "chatgpt explain Code" })
map({ "n", "v" }, "<leader>gr", ":ChatGPTRun roxygen_edit<CR>", opts { desc = "chatgpt roxygen Edit" })
map({ "n", "v" }, "<leader>gl", ":ChatGPTRun code_readability_analysis<CR>", opts { desc = "chatgpt code readability" })
