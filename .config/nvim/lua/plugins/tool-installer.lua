return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
        require("mason").setup()

        require("mason-tool-installer").setup {
            ensure_installed = {
                "stylua",
                "shfmt",
                "sqlfmt",
                "prettier",
                "pint",
                "rubyfmt",
                "goimports",
                "ruff",
            },
            auto_update = false,
            run_on_start = true,
        }
    end,
}
