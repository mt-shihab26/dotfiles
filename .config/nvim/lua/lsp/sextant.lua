-- sextant is built and symlinked to ~/.local/bin by .setup/nvim/sextant.sh (not Mason).
-- Rebuild/update with: .setup/nvim/sextant.sh
-- Debug logging: SEXTANT_LOG=1 nvim
return {
    enabled = true,
    cmd = { "sextant" },
    filetypes = { "lisp" },
    -- Let treesitter handle highlighting: semantic tokens (priority 125) override
    on_init = function(client)
        client.server_capabilities.semanticTokensProvider = nil
    end,
    root_dir = function(bufnr, on_dir)
        local util = require "lspconfig.util"
        local root = util.root_pattern("*.asd", "*.asdf", ".git")(vim.api.nvim_buf_get_name(bufnr))
        on_dir(root or vim.fn.getcwd())
    end,
}
