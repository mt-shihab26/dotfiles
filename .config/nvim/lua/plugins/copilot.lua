return {
    "zbirenbaum/copilot.lua",
    config = function()
        require("copilot").setup {
            suggestion = { enabled = false },
            panel = { enabled = false },
        }
        -- vim.cmd "Copilot disable"
    end,
}
