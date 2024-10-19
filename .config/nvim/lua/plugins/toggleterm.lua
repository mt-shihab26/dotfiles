-- Toogleterm for floating tools

return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
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
    end,
    keys = {
        { "<leader>ld", "<cmd>LazyDocker<cr>", desc = "toggle lazydocker", mode = "n" },
        { "<leader>ls", "<cmd>LazySQL<cr>", desc = "toggle lazysql", mode = "n" },
    },
}
