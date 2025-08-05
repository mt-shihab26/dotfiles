local setup = function()
    local dap = require "dap"

    dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
            command = "codelldb",
            args = { "--port", "${port}" },
        },
    }

    dap.configurations.rust = {
        {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = function()
                -- Find the executable in target/debug/
                local cwd = vim.fn.getcwd()
                local cargo_toml = cwd .. "/Cargo.toml"

                if vim.fn.filereadable(cargo_toml) == 1 then
                    -- Read package name from Cargo.toml
                    local handle = io.open(cargo_toml, "r")
                    if handle then
                        local content = handle:read "*a"
                        handle:close()
                        local package_name = content:match 'name%s*=%s*"([^"]+)"'
                        if package_name then
                            local executable = cwd .. "/target/debug/" .. package_name
                            if vim.fn.executable(executable) == 1 then
                                return executable
                            end
                        end
                    end
                end

                -- Fallback: ask user for executable path
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},
            runInTerminal = false,
        },
        {
            name = "Launch with arguments",
            type = "codelldb",
            request = "launch",
            program = function()
                local cwd = vim.fn.getcwd()
                local cargo_toml = cwd .. "/Cargo.toml"

                if vim.fn.filereadable(cargo_toml) == 1 then
                    local handle = io.open(cargo_toml, "r")
                    if handle then
                        local content = handle:read "*a"
                        handle:close()
                        local package_name = content:match 'name%s*=%s*"([^"]+)"'
                        if package_name then
                            local executable = cwd .. "/target/debug/" .. package_name
                            if vim.fn.executable(executable) == 1 then
                                return executable
                            end
                        end
                    end
                end

                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = function()
                local args_string = vim.fn.input "Arguments: "
                return vim.split(args_string, " ")
            end,
            runInTerminal = false,
        },
        {
            name = "Attach to process",
            type = "codelldb",
            request = "attach",
            pid = function()
                return require("dap.utils").pick_process()
            end,
            args = {},
        },
    }
end

return {
    setup = setup,
}
