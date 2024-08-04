local options = {
    ensure_installed = {
        "lua",
        "html",
        "css",
        "json",
        "markdown",
        "markdown_inline",
        "c",
        "cpp",
        "javascript",
        "typescript",
        "php",
        "php_only",
        "twig",
        "elixir",
        "heex",
        "go",
        "rust",
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
}

local config = function()
    local configs = require "nvim-treesitter.configs"
    local parsers = require "nvim-treesitter.parsers"

    configs.setup(options)

    parsers.get_parser_configs().blade = {
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
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = config,
    },
}
