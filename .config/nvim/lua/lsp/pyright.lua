-- Point pyright at the .venv of the project it attaches to, so imports resolve
-- even when the file lives in a different project than the one nvim opened in.
return {
    before_init = function(_, config)
        local venv = require "lib.venv".find(config.root_dir)
        if not venv then return end
        -- mutate in place: the client keeps a reference to this settings table
        config.settings.python = config.settings.python or {}
        config.settings.python.pythonPath = vim.fs.joinpath(venv, "bin/python")
    end,
}
