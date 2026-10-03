local dap = require "dap"

-- needs the xdebug extension with xdebug.mode=debug, see .setup/php/00_php.sh
dap.adapters.php = {
    type = "executable",
    command = "php-debug-adapter",
}

dap.configurations.php = {
    {
        type = "php",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
        port = 0,
        runtimeArgs = { "-dxdebug.start_with_request=yes" },
        env = {
            XDEBUG_MODE = "debug,develop",
            XDEBUG_CONFIG = "client_port=${port}",
        },
    },
    {
        type = "php",
        request = "launch",
        name = "Listen for Xdebug",
        port = 9003,
    },
}
