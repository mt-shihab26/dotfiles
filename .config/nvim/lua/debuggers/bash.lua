local dap = require "dap"

local bashdb_dir = vim.fn.stdpath "data" .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir"

dap.adapters.bashdb = {
    type = "executable",
    command = "bash-debug-adapter",
    name = "bashdb",
}

dap.configurations.sh = {
    {
        type = "bashdb",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        file = "${file}",
        cwd = "${workspaceFolder}",
        pathBashdb = bashdb_dir .. "/bashdb",
        pathBashdbLib = bashdb_dir,
        pathBash = "bash",
        pathCat = "cat",
        pathMkfifo = "mkfifo",
        pathPkill = "pkill",
        args = {},
        env = {},
        terminalKind = "integrated",
    },
}
