local dap = require "dap"

-- Uses the nearest .venv walking up from nvim's working directory, like lsp/pyright.lua.
local function python_path()
    local venv = vim.fs.find(".venv", { path = vim.fn.getcwd(), upward = true, type = "directory" })[1]
    local python = venv and vim.fs.joinpath(venv, "bin/python")
    if python and vim.uv.fs_stat(python) then
        return python
    end
    return vim.fn.exepath "python3"
end

dap.adapters.python = {
    type = "executable",
    command = "debugpy-adapter",
}

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        pythonPath = python_path,
    },
}
