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
