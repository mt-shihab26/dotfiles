vim.pack.add {
    { src = "https://github.com/kdheepak/lazygit.nvim" },
}

vim.schedule(function()
    local ok, telescope = pcall(require, "telescope")
    if ok then
        telescope.load_extension "lazygit"
    end
end)
