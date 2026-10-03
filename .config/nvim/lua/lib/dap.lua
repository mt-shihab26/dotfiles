local M = {}

function M.conditional_breakpoint()
    local dap = require "dap"
    vim.ui.input({ prompt = "Breakpoint condition: " }, function(condition)
        if condition and condition ~= "" then
            dap.set_breakpoint(condition)
        end
    end)
end

function M.step_back()
    local dap = require "dap"
    dap.step_back()
end

function M.run_last()
    local dap = require "dap"
    dap.run_last()
end

function M.toggle_ui()
    local dapui = require "dapui"
    dapui.toggle()
end

function M.eval()
    local dapui = require "dapui"
    dapui.eval()
end

function M.debug_go_test()
    local dap_go = require "dap-go"
    dap_go.debug_test()
end

return M
