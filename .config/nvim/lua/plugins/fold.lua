-- Fold html class

return {
    "razak17/tailwind-fold.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    ft = {
        "html",
        "svelte",
        "astro",
        "vue",
        "typescriptreact",
        "php",
        "blade",
    },
    config = function()
        vim.cmd [[TailwindFoldDisable]]
    end,
}
