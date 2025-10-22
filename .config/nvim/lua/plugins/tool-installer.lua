return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    enabled = true,
    dependencies = {
        "williamboman/mason.nvim",
    },
    config = function()
        require("mason").setup()

        require("mason-tool-installer").setup {
            ensure_installed = {
                -- "delve",
                -- "codelldb",
                -- "ruff",
                "vue-language-server",
            },
            auto_update = false,
            run_on_start = true,
        }
    end,
}
