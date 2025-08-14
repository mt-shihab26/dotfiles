return {
    lsp_start = function()
        vim.cmd "LspStart"
    end,

    lsp_stop = function()
        vim.cmd "LspStop"
    end,

    lsp_restart = function()
        vim.cmd "LspRestart"
    end,
}
