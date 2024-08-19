local function blade_parser()
    vim.filetype.add {
        pattern = {
            [".*%.blade%.php"] = "blade",
        },
    }

    local configs = require("nvim-treesitter.parsers").get_parser_configs()

    configs.blade = {
        install_info = {
            url = "https://github.com/EmranMR/tree-sitter-blade",
            files = {
                "src/parser.c",
            },
            branch = "main",
        },
        filetype = "blade",
    }
end

blade_parser()

return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            auto_install = true,
            ensure_installed = {
                "php",
                "php_only",
                "twig",
                "markdown",
                "markdown_inline",
                "sql",
                "templ",
            },
        },
    },
    {
        "windwp/nvim-ts-autotag",
        ft = {
            "templ",
        },
    },
}
