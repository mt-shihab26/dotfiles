local parsers = require "nvim-treesitter.parsers"

parsers.get_parser_configs().blade = {
    install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = {
            "src/parser.c",
        },
        branch = "main",
    },
    filetype = "blade",
}

vim.filetype.add {
    pattern = {
        [".*%.blade%.php"] = "blade",
    },
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            auto_install = true,
            ensure_installed = {
                "php",
                "php_only",
                "twig",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                intelephense = {
                    filetypes = { "php", "blade", "php_only" },
                    settings = {
                        intelephense = {
                            filetypes = { "php", "blade", "php_only" },
                            files = {
                                associations = { "*.php", "*.blade.php" }, -- Associating .blade.php files as well
                                maxSize = 5000000,
                            },
                        },
                    },
                },
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                php = { "pint" },
                blade = { "prettier" },
            },
        },
    },

    -- {
    --     "williamboman/mason.nvim",
    --     opts = {
    --         ensure_installed = {
    --             "phpcs",
    --         },
    --     },
    -- },
    -- {
    --     "mfussenegger/nvim-dap",
    --     optional = true,
    --     opts = function()
    --         local dap = require "dap"
    --         local path = require("mason-registry").get_package("php-debug-adapter"):get_install_path()
    --         dap.adapters.php = {
    --             type = "executable",
    --             command = "node",
    --             args = { path .. "/extension/out/phpDebug.js" },
    --         }
    --     end,
    -- },
    -- {
    --     "nvimtools/none-ls.nvim",
    --     optional = true,
    --     opts = function(_, opts)
    --         local nls = require "null-ls"
    --         opts.sources = opts.sources or {}
    --         table.insert(opts.sources, nls.builtins.diagnostics.phpcs)
    --     end,
    -- },
    -- {
    --     "mfussenegger/nvim-lint",
    --     optional = true,
    --     opts = {
    --         linters_by_ft = {
    --             php = { "phpcs" },
    --         },
    --     },
    -- },
}
