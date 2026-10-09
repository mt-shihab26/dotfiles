local M = {}

-- start debugging, or continue if a session is already running.
-- when the project's .dap/debug.json defines exactly one configuration, start it without asking,
-- otherwise show the usual configuration menu
function M.continue()
    local dap = require "dap"
    if not dap.session() then
        local configs = dap.providers.configs["project-debug-json"](vim.api.nvim_get_current_buf())
        if #configs == 1 then
            dap.run(configs[1])
            return
        end
    end
    dap.continue()
end

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

function M.run_to_cursor()
    local dap = require "dap"
    dap.run_to_cursor()
end

function M.run_last()
    local dap = require "dap"
    dap.run_last()
end

-- stop the debug session (if any) and close every debugger window
function M.close()
    local dap = require "dap"
    local dapui = require "dapui"
    if dap.session() then
        dap.terminate()
    end
    dapui.close()
    dap.repl.close()
end

function M.toggle_ui()
    local dapui = require "dapui"
    dapui.toggle { reset = true }
end

function M.eval()
    local dapui = require "dapui"
    dapui.eval()
end

function M.debug_go_test()
    local dap_go = require "dap-go"
    dap_go.debug_test()
end

-- toggle a breakpoint when clicking the sign column or line numbers, like the margin in visual studio,
-- otherwise behave like a normal click
function M.click_breakpoint()
    local pos = vim.fn.getmousepos()
    local info = vim.fn.getwininfo(pos.winid)[1]
    local in_margin = info and pos.line > 0 and pos.wincol <= info.textoff
    if not in_margin or vim.bo[vim.api.nvim_win_get_buf(pos.winid)].buftype ~= "" then
        return "<LeftMouse>"
    end
    vim.schedule(function()
        vim.api.nvim_set_current_win(pos.winid)
        vim.api.nvim_win_set_cursor(pos.winid, { pos.line, 0 })
        require("dap").toggle_breakpoint()
    end)
    return ""
end

return M
