-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Define an autocmd group for the blade workaround
local augroup = vim.api.nvim_create_augroup("lsp_blade_workaround", { clear = true })

-- Autocommand to temporarily change 'blade' filetype to 'php' when opening for LSP server activation
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup,
    pattern = "*.blade.php",
    callback = function()
        vim.bo.filetype = "php"
    end,
})

-- Additional autocommand to switch back to 'blade' after LSP has attached
vim.api.nvim_create_autocmd("LspAttach", {
    pattern = "*.blade.php",
    callback = function(args)
        vim.schedule(function()
            -- Check if the attached client is 'intelephense'
            for _, client in ipairs(vim.lsp.get_active_clients()) do
                if client.name == "intelephense" and client.attached_buffers[args.buf] then
                    vim.api.nvim_buf_set_option(args.buf, "filetype", "blade")
                    -- update treesitter parser to blade
                    vim.api.nvim_buf_set_option(args.buf, "syntax", "blade")
                    break
                end
            end
        end)
    end,
})

-- make $ part of the keyword for php.
vim.api.nvim_exec(
    [[
autocmd FileType php set iskeyword+=$
]],
    false
)

-- file type detection for .env and .env.* files
vim.cmd [[
  augroup dotenv
    autocmd!
    autocmd BufNewFile,BufRead .env,.env.* setfiletype sh
  augroup END
]]

-- telescopes

-- local is_inside_work_tree = {}
local find_files_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" }

vim.api.nvim_create_user_command("TelescopeProjectFiles", function()
    local builtin = require "telescope.builtin"
    builtin.find_files { find_command = find_files_command }

    -- local cwd = vim.fn.getcwd()
    -- if is_inside_work_tree[cwd] == nil then
    --     vim.fn.system "git rev-parse --is-inside-work-tree"
    --     is_inside_work_tree[cwd] = vim.v.shell_error == 0
    -- end
    --
    -- if is_inside_work_tree[cwd] then
    --     builtin.git_files { show_untracked = true }
    -- else
    --     builtin.find_files { find_command = find_files_command }
    -- end
end, {})

local telescope = require "telescope.builtin"

vim.api.nvim_create_user_command("TelescopeDotFiles", function()
    telescope.find_files {
        find_command = find_files_command,
        cwd = "~/dotfiles",
    }
end, {})

-- lazysql

local lazysql = require("toggleterm.terminal").Terminal:new {
    cmd = "lazysql",
    direction = "float",
    float_opts = { border = "curved" },
    -- function to run on opening the terminal
    on_open = function(term)
        vim.cmd "startinsert!"
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    on_close = function()
        vim.cmd "startinsert!"
    end,
}

vim.api.nvim_create_user_command("LazySQL", function()
    lazysql:toggle()
end, {})

-- lazydocker

local lazydocker = require("toggleterm.terminal").Terminal:new {
    cmd = "lazydocker",
    direction = "float",
    float_opts = { border = "curved" },
    -- function to run on opening the terminal
    on_open = function(term)
        vim.cmd "startinsert!"
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    on_close = function()
        vim.cmd "startinsert!"
    end,
}

vim.api.nvim_create_user_command("LazyDocker", function()
    lazydocker:toggle()
end, {})

-- Copy file path

vim.api.nvim_create_user_command("CopyFilePath", function()
    local path = vim.fn.expand "%:p"
    vim.fn.setreg("+", path)
    print("copied: " .. path)
end, {})
