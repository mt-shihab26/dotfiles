local dap = require "dap"

dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "js-debug-adapter",
        args = { "${port}" },
    },
}

local configurations = {
    {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
    },
    {
        type = "pwa-node",
        request = "attach",
        name = "Attach to process",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
    },
}

for _, filetype in ipairs { "javascript", "javascriptreact", "typescript", "typescriptreact" } do
    dap.configurations[filetype] = configurations
end
