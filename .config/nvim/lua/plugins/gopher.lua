-- Plugin for go

return {
    "olexsmir/gopher.nvim",
    ft = "go",
    build = function()
        vim.cmd.GoInstallDeps()
    end,
    keys = {
        { "<leader>gne", "<CMD>GoIfErr<CR>", desc = "generate go 'if err != nil {}' block", mode = "n" },
        { "<leader>gta", "<CMD>GoTagAdd json<CR>", desc = "add go json tags to struct fields", mode = "n" },
    },
}
