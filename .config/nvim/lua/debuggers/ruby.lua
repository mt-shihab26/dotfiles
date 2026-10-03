local dap = require "dap"

-- ask the os for an unused tcp port
local function free_port()
    local tcp = assert(vim.uv.new_tcp())
    tcp:bind("127.0.0.1", 0)
    local port = tcp:getsockname().port
    tcp:close()
    return port
end

-- rdbg ships with the `debug` gem bundled in mise's active Ruby
dap.adapters.ruby = function(callback, config)
    local port = free_port()
    callback {
        type = "server",
        host = "127.0.0.1",
        port = port,
        executable = {
            command = "rdbg",
            args = { "--open", "--port", tostring(port), "-c", "--", "ruby", config.program },
        },
    }
end

dap.configurations.ruby = {
    {
        type = "ruby",
        request = "attach",
        name = "Launch file",
        program = "${file}",
        localfs = true,
    },
}
