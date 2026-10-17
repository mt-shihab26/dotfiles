-- --query-driver lets clangd run gcc to read its system include paths and
-- target, so projects built with gcc get gcc's headers instead of clang's.
-- The compiler itself is chosen in ~/.config/clangd/config.yaml.

-- clangd marks inactive #if branches as "comment" semantic tokens, which override
-- treesitter and grey the whole branch out. Clear them so every branch stays highlighted;
-- real comments are still coloured by treesitter. Re-applied after a colorscheme change.
local function show_inactive_regions()
    vim.api.nvim_set_hl(0, "@lsp.type.comment.c", {})
    vim.api.nvim_set_hl(0, "@lsp.type.comment.cpp", {})
end

show_inactive_regions()
vim.api.nvim_create_autocmd("ColorScheme", { callback = show_inactive_regions })

return {
    cmd = {
        "clangd",
        "--query-driver=/usr/bin/gcc,/usr/bin/g++",
    },
}
