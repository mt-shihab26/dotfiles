return {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
    },
    keys = {
        { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "navigate left window" },
        { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "navigate down window" },
        { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "navigate up window" },
        { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "navigate right window" },
    },
}
