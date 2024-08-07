-- telescopes

local is_inside_work_tree = {}

vim.api.nvim_create_user_command("TelescopeProjectFiles", function()
    local cwd = vim.fn.getcwd()
    if is_inside_work_tree[cwd] == nil then
        vim.fn.system "git rev-parse --is-inside-work-tree"
        is_inside_work_tree[cwd] = vim.v.shell_error == 0
    end

    local builtin = require "telescope.builtin"

    if is_inside_work_tree[cwd] then
        builtin.git_files { show_untracked = true }
    else
        builtin.find_files { find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" } }
    end
end, {})

-- lazysql

local lazysql = require("toggleterm.terminal").Terminal:new {
    cmd = "lazysql",
    direction = "float",
    float_opts = {
        border = "curved",
    },
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

-- Copy file path

vim.api.nvim_create_user_command("CopyFilePath", function()
    local path = vim.fn.expand "%:p"
    vim.fn.setreg("+", path)
    print("copied: " .. path)
end, {})
