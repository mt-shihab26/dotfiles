local M = {}

-- start debugging, or continue if a session is already running.
-- when the project's debug.json defines exactly one configuration, start it without asking,
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

-- buttons in dap-ui's winbar, in the order dapui/controls.lua draws them: two spaces then a one cell icon each
local controls = { "play", "step_into", "step_over", "step_out", "step_back", "run_last", "terminate", "disconnect" }
local tooltip = { win = nil, text = nil }

local function close_tooltip()
    if tooltip.win and vim.api.nvim_win_is_valid(tooltip.win) then
        vim.api.nvim_win_close(tooltip.win, true)
    end
    tooltip.win, tooltip.text = nil, nil
end

-- the description and key of the keymap whose desc starts with the icon, e.g. "step into", "<leader>bi"
local function keymap_for(icon)
    for _, keymap in ipairs(vim.api.nvim_get_keymap "n") do
        if keymap.desc and vim.startswith(keymap.desc, icon .. " ") then
            local desc = keymap.desc:sub(#icon + 2):gsub(" %(dap%)$", "")
            local lhs = keymap.lhs:gsub("^" .. vim.pesc(vim.g.mapleader), "<leader>"):gsub("^<Space>", "<leader>")
            return desc, lhs
        end
    end
end

-- show what a dap-ui winbar button does and its keymap while the mouse is over it
function M.hover_controls()
    local pos = vim.fn.getmousepos()
    local on_winbar = pos.winid ~= 0 and pos.line == 0 and pos.winrow == 1
        and vim.wo[pos.winid].winbar:find("_dapui", 1, true)
    local name = on_winbar and pos.wincol % 3 == 0 and controls[pos.wincol / 3]
    if not name then
        close_tooltip()
        return
    end

    local session = require("dap").session()
    if name == "play" and session and not session.stopped_thread_id then
        name = "pause"
    end
    local desc, lhs = keymap_for(require("dapui.config").controls.icons[name])
    local text = desc and (" %s  %s "):format(desc, lhs) or (" %s "):format(name:gsub("_", " "))
    if text == tooltip.text then
        return
    end

    close_tooltip()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { text })
    vim.bo[buf].bufhidden = "wipe"
    tooltip.win = vim.api.nvim_open_win(buf, false, {
        relative = "mouse",
        row = 1,
        col = 0,
        width = vim.fn.strdisplaywidth(text),
        height = 1,
        style = "minimal",
        border = "rounded",
        focusable = false,
        zindex = 250,
    })
    tooltip.text = text
end


-- nvim only reports mouse movement with mousemoveevent on
vim.opt.mousemoveevent = true
vim.keymap.set({ "n", "i", "v" }, "<MouseMove>", M.hover_controls, { desc = "show what a debugger toolbar button does on hover (dap-ui)" })

return M
