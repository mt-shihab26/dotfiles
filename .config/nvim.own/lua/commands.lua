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

-- Open in browser
vim.api.nvim_create_user_command("OpenInBrowser", function()
    local url = ""

    -- Check if there's a visual selection
    local mode = vim.fn.mode()
    if mode == "v" or mode == "V" or mode == "" then
        -- Get the visual selection
        local start_pos = vim.fn.getpos "'<"
        local end_pos = vim.fn.getpos "'>"
        local lines = vim.fn.getline(start_pos[2], end_pos[2])

        if #lines > 0 then
            -- Adjust the start and end columns
            lines[1] = string.sub(lines[1], start_pos[3])
            lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])

            -- Join the selected lines
            url = table.concat(lines, "")
        end
    else
        -- If no visual selection, get the text under the cursor
        url = vim.fn.expand "<cfile>"
    end

    if url ~= "" then
        -- Escape special characters for the shell
        url = vim.fn.escape(url, ' \\"')

        -- Open the selected text or link in the browser
        if vim.fn.has "mac" == 1 then
            vim.fn.system("open '" .. url .. "'")
        elseif vim.fn.has "unix" == 1 then
            vim.fn.system("xdg-open '" .. url .. "'")
        elseif vim.fn.has "win32" == 1 then
            vim.fn.system("start " .. url)
        end
    else
        print "No link or text selected!"
    end
end, { range = true })
