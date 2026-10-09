vim.pack.add {
    {
        src = "https://github.com/mfussenegger/nvim-dap",
        version = "master",
    },
    {
        src = "https://github.com/nvim-neotest/nvim-nio",
        version = vim.version.range "1",
    },
    {
        src = "https://github.com/rcarriga/nvim-dap-ui",
        version = "master",
    },
    {
        src = "https://github.com/leoluz/nvim-dap-go",
        version = "main",
    },
    {
        src = "https://github.com/mfussenegger/nvim-jdtls",
        version = "master",
    },
}

local dap = require "dap"
local dapui = require "dapui"
local debuggers = require "lists.debuggers"

dapui.setup {}

-- closing a window next to the debugger sidebar (e.g. neo-tree) hands its space to the sidebar, which
-- dap-ui then remembers, so it grows every time; put the sidebar back to its width after a window closes
vim.api.nvim_create_autocmd("WinClosed", {
    callback = function()
        local widths = {}
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.bo[vim.api.nvim_win_get_buf(win)].filetype:match "^dapui_" then
                widths[win] = vim.api.nvim_win_get_width(win)
            end
        end
        vim.schedule(function()
            for win, width in pairs(widths) do
                if vim.api.nvim_win_is_valid(win) then
                    vim.api.nvim_win_set_width(win, width)
                end
            end
        end)
    end,
})

-- debug adapters (dlv, codelldb, debugpy, ...) are installed by Mason, see lists/binaries.lua
for _, debugger_name in ipairs(debuggers) do
    require("debuggers." .. debugger_name)
end

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticError" })
vim.fn.sign_define("DapLogPoint", { text = "◉", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticWarn", linehl = "DapStoppedLine" })

-- yellow tinted background for the line the debugger stopped on (like visual studio), mixed from the
-- colorscheme's warning color so it fits every theme, and recomputed when the colorscheme changes
local function set_stopped_line_highlight()
    local warn = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn", link = false }).fg or 0xe0af68
    local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg or 0x000000
    local function mix(shift)
        local a, b = bit.band(bit.rshift(warn, shift), 0xff), bit.band(bit.rshift(normal, shift), 0xff)
        return bit.lshift(math.floor(a * 0.3 + b * 0.7), shift)
    end
    vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = mix(16) + mix(8) + mix(0) })
end
set_stopped_line_highlight()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_stopped_line_highlight })

-- per-project configurations from .dap/debug.json (same format as .vscode/launch.json)
dap.providers.configs["project-debug-json"] = function()
    return require("dap.ext.vscode").getconfigs(vim.fn.getcwd() .. "/.dap/debug.json")
end

-- ask for function parameters in the call stack (e.g. "draw(int count = 6)") when the debugger supports it
-- (gdb does, codelldb doesn't), nvim-dap doesn't request them by itself
local Session = require "dap.session"
local session_request = Session.request
function Session:request(command, arguments, on_result)
    if command == "stackTrace" and arguments and not arguments.format and self.capabilities.supportsValueFormattingOptions then
        local format = { parameters = true, parameterTypes = true, parameterNames = true, parameterValues = true }
        arguments = vim.tbl_extend("force", arguments, { format = format })
    end
    return session_request(self, command, arguments, on_result)
end

-- run a configuration's `preLaunchCommand` (e.g. a build script from .vscode/launch.json) before launching,
-- and abort the launch if it fails
dap.listeners.on_config["pre-launch-command"] = function(config)
    if not config.preLaunchCommand then
        return config
    end
    config = vim.deepcopy(config)

    local co = coroutine.running()
    vim.notify("Running " .. config.preLaunchCommand)
    vim.system({ "sh", "-c", config.preLaunchCommand }, { text = true, cwd = vim.fn.getcwd() }, function(res)
        vim.schedule(function()
            coroutine.resume(co, res)
        end)
    end)
    local res = coroutine.yield()

    if res.code ~= 0 then
        vim.notify(res.stdout .. res.stderr, vim.log.levels.ERROR)
        config.program = dap.ABORT
    end
    return config
end

-- open the ui when a session starts and close it when the session ends
dap.listeners.before.attach.dapui_config = dapui.open
dap.listeners.before.launch.dapui_config = dapui.open
dap.listeners.before.event_terminated.dapui_config = dapui.close
dap.listeners.before.event_exited.dapui_config = dapui.close
