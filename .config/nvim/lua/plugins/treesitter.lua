local function blade_parser()
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
end

blade_parser()

return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "php",
                "php_only",
                "twig",
                "markdown",
                "markdown_inline",
                "sql",
            },
        },
    },
}
