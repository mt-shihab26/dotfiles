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

---@param session dap.Session
local function is_gdb(session)
    return session.adapter.command ~= nil and vim.fs.basename(session.adapter.command) == "gdb"
end

-- run a gdb cli command (e.g. "reverse-next") in a gdb debug session, errors are shown and logged like dap's own
---@param session dap.Session
---@param command string
local function gdb_command(session, command)
    local frame = session.current_frame
    session:request("evaluate", { expression = command, context = "repl", frameId = frame and frame.id }, function(err)
        if err then
            require("dap.utils").notify(("Error on %s: %s"):format(command, err.message), vim.log.levels.ERROR)
        end
    end)
end

-- gdb can only step back through what it recorded, so record while stopped in code with source
-- (old entries are dropped instead of stopping the program when the record buffer is full)
---@param session dap.Session
local function start_gdb_recording(session)
    if session.gdb_recording then
        return
    end
    session.gdb_recording = true
    gdb_command(session, "record full")
    gdb_command(session, "set record full stop-at-limit off")
end

-- while recording, continue stops at the end of the recorded history and again before the program exits,
-- so stop recording before continuing; it starts again at the next stop
---@param session dap.Session
function M.stop_gdb_recording(session)
    if session.gdb_recording then
        session.gdb_recording = false
        gdb_command(session, "record stop")
    end
end

-- start recording when a gdb session stops in code with source, and stop it when it stops somewhere without
-- (e.g. _exit after stepping off the end of main): there the recorder stops before the exit syscall, steps
-- back land in "???", and the next step never returns, leaving every step with "No stopped threads"
---@param session dap.Session
---@param err table|nil
---@param response table|nil stackTrace response
---@param request table stackTrace request arguments
function M.update_gdb_recording(session, err, response, request)
    -- a late reply arriving after the program was resumed must not start recording, gdb refuses while running
    if err or not response or not is_gdb(session) or not session.stopped_thread_id or (request.startFrame or 0) ~= 0 then
        return
    end
    local top = response.stackFrames[1]
    local retry = session.retry_step
    session.retry_step = nil
    if top and top.source and top.source.path then
        start_gdb_recording(session)
        if retry then
            session.forward_step_retried = true
            vim.schedule(retry)
        end
    else
        M.stop_gdb_recording(session)
    end
end

local forward_steps = {
    next = function()
        require("dap").step_over()
    end,
    stepIn = function()
        require("dap").step_into()
    end,
    stepOut = function()
        require("dap").step_out()
    end,
}

-- remember a forward step (step over, into or out) sent to the adapter, see step_past_history_end
---@param session dap.Session
---@param command string the request command
function M.track_forward_step(session, command)
    session.forward_step = forward_steps[command] and command or nil
end

-- after stepping back, gdb replays the recorded history and a forward step stops early with "Reached end of
-- recorded history" (reason "stopped" instead of "step"), e.g. step out of a function stays inside it;
-- send the same step once more, which then runs live from the end of the history; the recorder stopping before
-- the exit syscall also reports "stopped", so update_gdb_recording only retries when the stop is in code with source
---@param session dap.Session
---@param body table stopped event
function M.step_past_history_end(session, body)
    local command, retried = session.forward_step, session.forward_step_retried
    session.forward_step, session.forward_step_retried = nil, nil
    if body.reason == "stopped" and command and not retried and session.gdb_recording then
        session.retry_step = forward_steps[command]
    end
end

-- step back one line; gdb can do it (reverse-next) while recording, but its debug adapter doesn't say it
-- supports stepping back, so nvim-dap would refuse with "Debug Adapter does not support stepping backwards"
function M.step_back()
    local dap = require "dap"
    local session = dap.session()
    if session and session.stopped_thread_id and not session.capabilities.supportsStepBack and is_gdb(session) then
        if not session.gdb_recording then
            local msg = "Cannot step back here: gdb only records while stopped in code with source"
            require("dap.utils").notify(msg, vim.log.levels.WARN)
            return
        end
        gdb_command(session, "reverse-next")
        return
    end
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

-- open the debugger ui at its configured size, not a size left over from an earlier session
function M.open_ui()
    local dapui = require "dapui"
    dapui.open { reset = true }
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

-- close the toolbar tooltip when some other window closes (e.g. the debugger windows go away), since it
-- otherwise only closes on mouse movement; closing the tooltip itself is ignored
---@param closed_win integer
function M.close_tooltip_after(closed_win)
    if closed_win ~= tooltip.win then
        vim.schedule(close_tooltip)
    end
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

-- closing a window next to the debugger sidebar (e.g. neo-tree) hands its space to the sidebar, which
-- dap-ui then remembers, so it grows every time; put the sidebar back to the width it had before
function M.keep_sidebar_width()
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
end

-- yellow tinted background for the line the debugger stopped on (like visual studio), mixed from the
-- colorscheme's warning color so it fits every theme
function M.set_stopped_line_highlight()
    local warn = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn", link = false }).fg or 0xe0af68
    local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg or 0x000000
    local function mix(shift)
        local a, b = bit.band(bit.rshift(warn, shift), 0xff), bit.band(bit.rshift(normal, shift), 0xff)
        return bit.lshift(math.floor(a * 0.3 + b * 0.7), shift)
    end
    vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = mix(16) + mix(8) + mix(0) })
end

-- per-project configurations from debug.json (same format as .vscode/launch.json)
function M.debug_json_configs()
    return require("dap.ext.vscode").getconfigs(vim.fn.getcwd() .. "/debug.json")
end

-- run a configuration's `preLaunchCommand` (e.g. a build script from .vscode/launch.json) before launching,
-- and abort the launch if it fails
function M.run_pre_launch_command(config)
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
        config.program = require("dap").ABORT
    end
    return config
end

-- ask for function parameters in the call stack (e.g. "draw(int count = 6)") when the debugger supports it
-- (gdb does, codelldb doesn't), nvim-dap doesn't request them by itself
---@param session dap.Session
---@param arguments table stackTrace request arguments
---@return table
function M.stack_trace_with_parameters(session, arguments)
    if arguments.format or not session.capabilities.supportsValueFormattingOptions then
        return arguments
    end
    local format = { parameters = true, parameterTypes = true, parameterNames = true, parameterValues = true }
    return vim.tbl_extend("force", arguments, { format = format })
end

-- nvim-dap marks the thread as running before sending a step, and doesn't undo it when the adapter refuses
-- (e.g. gdb's "finish not meaningful in the outermost frame" when stepping out of main), so every later
-- step fails with "No stopped threads"; the program is still paused, so mark it stopped again
---@param session dap.Session
---@param thread_id integer the thread the step was sent for
function M.restore_stopped_thread(session, thread_id)
    local thread = session.threads[thread_id]
    if not thread or session.stopped_thread_id then
        return
    end
    session.stopped_thread_id = thread.id
    thread.stopped = true
    session:_frame_set(session.current_frame)
    require("dapui.controls").refresh_control_panel()
end

-- a log of dap errors that survives restarts (nvim-dap's own dap.log is cleared on each start and doesn't
-- get the errors it only shows as notifications)
M.error_log_path = vim.fn.stdpath "log" .. "/dap-errors.log"

-- append a line to the error log with the time, the debugger type and the given messages or values
function M.log_error(...)
    local session = require("dap").session()
    local parts = { os.date "%Y-%m-%d %H:%M:%S", session and session.config.type or "-" }
    for _, part in ipairs { ... } do
        parts[#parts + 1] = type(part) == "string" and part or vim.inspect(part, { newline = " ", indent = "" })
    end
    local file = io.open(M.error_log_path, "a")
    if file then
        file:write(table.concat(parts, "  "), "\n")
        file:close()
    end
end

-- log a message from the debug adapter if it is a failed response, together with the request it answers
---@param session dap.Session
---@param body string raw json message from the adapter
function M.log_failed_response(session, body)
    if not body:find '"success"%s*:%s*false' then
        return
    end
    local ok, decoded = pcall(vim.json.decode, body)
    if ok and decoded.request_seq then
        M.log_error("failed response", { request = session.message_requests[decoded.request_seq], response = decoded })
    end
end

function M.open_error_log()
    vim.cmd.tabedit(M.error_log_path)
end

return M
