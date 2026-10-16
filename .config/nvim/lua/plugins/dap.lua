local lazy = require "lib.lazy"

-- loads on the first debugger keymap (<leader>b...), :Dap... command or require of a dap module
lazy.add({
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
        src = "https://github.com/jonboh/nvim-dap-rr",
        version = "main",
    },
    {
        src = "https://github.com/leoluz/nvim-dap-go",
        version = "main",
    },
    {
        src = "https://github.com/mfussenegger/nvim-jdtls",
        version = "master",
    },
}, {
    modules = { "dap", "dapui", "dap-go", "nvim-dap-rr", "jdtls", "nio" },
    commands = {
        "DapErrorLog",
        "DapSetLogLevel",
        "DapShowLog",
        "DapContinue",
        "DapToggleBreakpoint",
        "DapClearBreakpoints",
        "DapToggleRepl",
        "DapStepOver",
        "DapStepInto",
        "DapStepOut",
        "DapPause",
        "DapTerminate",
        "DapDisconnect",
        "DapRestartFrame",
        "DapNew",
        "DapEval",
    },
    setup = function()
        local dap = require "dap"
        local dapui = require "dapui"
        local lib_dap = require "lib.dap"
        local debuggers = require "lists.debuggers"

        dapui.setup {}

        -- debug adapters (dlv, codelldb, debugpy, ...) are installed by Mason, see lists/binaries.lua
        for _, debugger_name in ipairs(debuggers) do
            require("debuggers." .. debugger_name)
        end

        vim.api.nvim_create_autocmd("WinClosed", { callback = lib_dap.keep_sidebar_width })

        -- tooltips on the dap-ui toolbar buttons (the <MouseMove> keymap is in keymaps.lua), nvim only reports mouse
        -- movement with mousemoveevent on
        vim.opt.mousemoveevent = true
        vim.api.nvim_create_autocmd("WinClosed", {
            callback = function(args)
                lib_dap.close_tooltip_after(tonumber(args.match))
            end,
        })

        vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
        vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticError" })
        vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticError" })
        vim.fn.sign_define("DapLogPoint", { text = "◉", texthl = "DiagnosticInfo" })
        vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticWarn", linehl = "DapStoppedLine" })

        lib_dap.set_stopped_line_highlight()
        vim.api.nvim_create_autocmd("ColorScheme", { callback = lib_dap.set_stopped_line_highlight })

        dap.providers.configs["project-debug-json"] = lib_dap.debug_json_configs
        dap.listeners.on_config["pre-launch-command"] = lib_dap.run_pre_launch_command

        local Session = require "dap.session"
        local step_commands =
            { next = true, stepIn = true, stepOut = true, stepBack = true, continue = true, reverseContinue = true }
        local session_request = Session.request
        function Session:request(command, arguments, on_result)
            if command == "stackTrace" and arguments then
                arguments = lib_dap.stack_trace_with_parameters(self, arguments)
            end
            if step_commands[command] and on_result and arguments and arguments.threadId then
                local callback = on_result
                on_result = function(err, result)
                    if err then
                        lib_dap.restore_stopped_thread(self, arguments.threadId)
                    end
                    return callback(err, result)
                end
            end
            return session_request(self, command, arguments, on_result)
        end

        -- log every dap error to lib_dap.error_log_path: errors nvim-dap shows to the user (e.g. "Error on stepOut: ..."
        -- or "No stopped threads. Cannot move") and requests the debug adapter answered with a failure
        local dap_utils = require "dap.utils"
        local dap_notify = dap_utils.notify
        function dap_utils.notify(msg, level)
            if level and level >= vim.log.levels.WARN then
                lib_dap.log_error(msg)
            end
            return dap_notify(msg, level)
        end

        local handle_body = Session.handle_body
        function Session:handle_body(body)
            lib_dap.log_failed_response(self, body)
            return handle_body(self, body)
        end

        vim.api.nvim_create_user_command("DapErrorLog", lib_dap.open_error_log, { desc = "open the log of dap errors" })

        -- open the ui when a session starts and close it when the session ends
        dap.listeners.before.attach.dapui_config = lib_dap.open_ui
        dap.listeners.before.launch.dapui_config = lib_dap.open_ui
        dap.listeners.before.event_terminated.dapui_config = dapui.close
        dap.listeners.before.event_exited.dapui_config = dapui.close

        -- the toolbar buttons step like the keymaps, so they go the right direction while replaying an rr recording
        require "dapui.controls"
        _G._dapui.play = lib_dap.play
        _G._dapui.step_into = lib_dap.step_into
        _G._dapui.step_over = lib_dap.step_over
        _G._dapui.step_out = lib_dap.step_out
        _G._dapui.step_back = lib_dap.step_back
    end,
})
