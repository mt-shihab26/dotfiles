local map = vim.keymap.set

local opts = function(options)
    local default_options = { noremap = true, silent = true }
    return vim.tbl_extend("force", default_options, options or {})
end

map("i", "jk", "<ESC>", opts { desc = "exit insert mode" })

-- Comment
map("n", "<leader>/", "gcc", opts { desc = "comment toggle", remap = true })
map("v", "<leader>/", "gc", opts { desc = "comment toggle", remap = true })

require("which-key").add {
    -- tree
    { "<leader>e", "<CMD>NvimTreeFocus<CR>", mode = "n", desc = "open file tree" },
    { "<leader>p", "<CMD>NvimTreeClose<CR>", mode = "n", desc = "close file tree" },
    { "<C-n>", "<CMD>NvimTreeToggle<CR>", mode = "n", desc = "toggle file tree" },

    -- tabs
    { "<tab>", "<CMD>BufferLineCycleNext<CR>", mode = "n", desc = "next buffer" },
    { "<S-tab>", "<CMD>BufferLineCyclePrev<CR>", mode = "n", desc = "previous buffer" },
    { "<leader>c", "<CMD>bp<bar>sp<bar>bn<bar>bd<CR>", mode = "n", desc = "close buffer" },

    -- terminal
    { "<leader>ft", "<CMD>ToggleTerm<CR>", mode = "n", desc = "open terminal" },

    -- copy
    { "<leader>y", "<CMD>CopyFilePath<CR>", mode = "n", desc = "copy file path" },

    -- git
    { "<leader>gp", "<CMD>Gitsigns preview_hunk<CR>", mode = "n", desc = "preview git line change" },

    -- lsp
    { "K", vim.lsp.buf.hover, mode = "n", desc = "show hover information" },
    { "L", vim.diagnostic.open_float, mode = "n", desc = "show hover line diagnostics" },
    { "gd", vim.lsp.buf.definition, mode = "n", desc = "go to definition" },
    { "gD", vim.lsp.buf.declaration, mode = "n", desc = "go to declaration" },
    { "<leader>a", vim.lsp.buf.code_action, mode = { "n", "v" }, desc = "show code action" },
    { "<leader>r", vim.lsp.buf.rename, mode = "n", desc = "rename symbol" },
    { "<leader>D", vim.lsp.buf.type_definition, mode = "n", desc = "show type definition" },
    { "gi", vim.lsp.buf.implementation, mode = "n", desc = "go to implementation" },
    { "gr", vim.lsp.buf.references, mode = "n", desc = "list all references" },

    -- telescope
    { "<leader>f", group = "telescope" },
    { "<leader>ff", "<CMD>TelescopeProjectFiles<CR>", mode = "n", desc = "find file" },
    { "<leader>fw", "<CMD>Telescope live_grep<CR>", mode = "n", desc = "live grep" },
    { "<leader>fd", "<CMD>TelescopeDotFiles<CR>", mode = "n", desc = "find dotfiles" },

    -- integrations
    { "<leader>o", group = "open things" },
    { "<leader>og", "<CMD>LazyGit<CR>", mode = "n", desc = "open lazygit" },
    { "<leader>od", "<CMD>LazyDocker<CR>", mode = "n", desc = "open lazydocker" },
    { "<leader>os", "<CMD>LazySQL<CR>", mode = "n", desc = "open lazysql" },
    { "<leader>ol", "<CMD>OpenInBrowser<CR>", mode = { "n", "v" }, desc = "open in browser" },
    { "<leader>ot", "<CMD>Themery<CR>", mode = "n", desc = "open colorscheme changer" },

    -- toggles
    { "<leader>tcf", "<CMD>TailwindFoldToggle<CR>", mode = "n", desc = "toggle html classes float" },
}
