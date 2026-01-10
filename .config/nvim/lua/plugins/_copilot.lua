return {
    "zbirenbaum/copilot.lua",
    enabled = false,
    config = function()
        require("copilot").setup {
            suggestion = { enabled = false },
            panel = { enabled = false },
        }
        -- vim.cmd "Copilot disable"
    end,
}
