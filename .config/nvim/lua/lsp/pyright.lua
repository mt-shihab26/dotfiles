-- Finds the nearest .venv directory walking up from `path`.
local function find_venv(path)
    local venv = vim.fs.find(".venv", { path = path, upward = true, type = "directory" })[1]
    if venv and vim.uv.fs_stat(vim.fs.joinpath(venv, "bin/python")) then
        return venv
    end
end

-- Point pyright at the .venv of the project it attaches to, so imports resolve
-- even when the file lives in a different project than the one nvim opened in.
return {
    settings = {
        python = {
            analysis = {
                diagnosticSeverityOverrides = {
                    reportWildcardImportFromLibrary = "none",
                },
            },
        },
    },
    before_init = function(_, config)
        local venv = find_venv(config.root_dir)
        if not venv then return end
        -- mutate in place: the client keeps a reference to this settings table
        config.settings.python = config.settings.python or {}
        config.settings.python.pythonPath = vim.fs.joinpath(venv, "bin/python")
    end,
}
