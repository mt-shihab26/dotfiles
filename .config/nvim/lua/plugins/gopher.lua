-- Plugin for go

return {
    "olexsmir/gopher.nvim",
    ft = "go",
    build = function()
        vim.cmd.GoInstallDeps()
    end,
    keys = {
        { "<leader>gne", "<cmd>GoIfErr<cr>", desc = "generate go 'if err != nil {}' block", mode = "n" },
        { "<leader>gta", "<cmd>GoTagAdd json<cr>", desc = "add go json tags to struct fields", mode = "n" },
    },
}
