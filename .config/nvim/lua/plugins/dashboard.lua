return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        theme = "hyper",
        hide = {
            statusline = true,
            tabline = true,
            winbar = true,
        },
        config = {
            week_header = { enable = true },
            shortcut = {
                {
                    action = "Lazy",
                    desc = " Lazy",
                    icon = "󰒲 ",
                    key = "l",
                    group = "Label",
                },
                {
                    action = "Mason",
                    desc = "Mason",
                    icon = " ",
                    key = "m",
                    group = "@property",
                },
                {
                    action = function()
                        local telescope = require "telescope.builtin"
                        telescope.find_files {
                            prompt_title = "Find Dotfiles",
                            cwd = vim.fn.expand "~/dotfiles",
                        }
                    end,
                    desc = " Config",
                    icon = " ",
                    key = "c",
                    group = "@property",
                },
                {
                    action = function()
                        local oldfiles = vim.v.oldfiles
                        if #oldfiles > 0 then
                            vim.cmd("e " .. oldfiles[1])
                        else
                            vim.notify("No recently opened files found", vim.log.levels.WARN)
                        end
                    end,
                    desc = " Last",
                    icon = "󰄉 ",
                    key = "l",
                    group = "Label",
                },
                {
                    action = function()
                        vim.api.nvim_input "<cmd>qa<cr>"
                    end,
                    desc = " Quit",
                    icon = " ",
                    key = "q",
                    group = "Label",
                },
            },
        },
    },
}
