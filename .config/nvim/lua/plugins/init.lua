return {
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        config = function()
            require "configs.conform"
        end,
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require "configs.lspconfig"
        end,
    },
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                -- defaults
                "lua-language-server",
                "stylua",

                --  HTML, CSS, TailwindCSS
                "html-lsp",
                "css-lsp",
                "tailwindcss-language-server",

                --  PHP
                "intelephense",
                "phpcs",

                --  JavaScript/Typescript
                "typescript-language-server",
                "eslint-lsp",
                "prettier",
                "astro-language-server",

                --  Go
                "gopls",

                --  C/C++
                "clangd",
                "clang-format",
                "codelldb",

                -- Elixir
                "elixir-ls",
            },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                -- defaults
                "vim",
                "lua",
                "vimdoc",

                -- HTML, CSS, TailwindCSS
                "html",
                "css",

                --  PHP
                "php",
                "twig",

                -- JavaScript/Typescript
                "json",
                "javascript",
                "typescript",
                "tsx",
                "astro",

                --  Go
                "go",

                --  C/C++
                "c",
                "cpp",

                -- Elixir
                "elixir",
            },
        },
    },

    {
        "windwp/nvim-ts-autotag",
        ft = {
            -- HTML, CSS, TailwindCSS
            "html",

            --  PHP
            "php",
            "twig",

            -- JavaScript/Typescript
            "javascriptreact",
            "typescriptreact",
        },
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },

    {
        "NvChad/nvim-colorizer.lua",
        opts = {
            user_default_options = {
                tailwind = true,
            },
        },
    },
}
