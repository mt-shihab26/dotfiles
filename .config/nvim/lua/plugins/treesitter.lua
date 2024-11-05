return {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = function()
        require("nvim-treesitter.install").update { with_sync = true }
    end,
    opts = {
        ensure_installed = require "configs.treesitter_parsers",
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true, disable = { "yaml" } },
        rainbow = { enable = true },
    },
    config = function(_, opts)
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

        parser_config.blade = {
            install_info = {
                url = "https://github.com/EmranMR/tree-sitter-blade",
                files = { "src/parser.c" },
                branch = "main",
            },
            filetype = "blade",
        }

        vim.filetype.add {
            pattern = {
                [".*%.blade%.php"] = "blade",
            },
        }

        require("nvim-treesitter.configs").setup(opts)
    end,
}
