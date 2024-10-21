return {
    "christoomey/vim-tmux-navigator",
    cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
    },
    keys = {
        { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", docs = "navigate left window" },
        { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", docs = "navigate down window" },
        { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", docs = "navigate up window" },
        { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", docs = "navigate right window" },
        { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", docs = "navigate previous window" },
    },
}
