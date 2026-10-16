local lazy = require "lib.lazy"

-- loads right after startup
lazy.add({
    {
        src = "https://github.com/NvChad/nvim-colorizer.lua",
        version = "master",
    },
    {
        src = "https://github.com/lukas-reineke/indent-blankline.nvim",
        version = vim.version.range "3",
    },
}, {
    defer = true,
    setup = function()
        local colorizer = require "colorizer"
        local ibl = require "ibl"

        colorizer.setup {
            filetypes = { "*", "!bigfile" },
            user_default_options = {
                names = false,
                tailwind = true,
            },
        }

        -- colorizer attaches on FileType, which already fired for the files opened at startup
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= "" then
                vim.api.nvim_buf_call(buf, function()
                    vim.api.nvim_exec_autocmds("FileType", { group = "ColorizerSetup", pattern = vim.bo[buf].filetype })
                end)
            end
        end

        ibl.setup {
            scope = { show_start = false },
            exclude = { filetypes = { "dashboard", "bigfile" } },
        }
    end,
})
