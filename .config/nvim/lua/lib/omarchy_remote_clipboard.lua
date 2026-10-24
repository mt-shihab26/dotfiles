-- Clipboard for sessions whose yanks may need to reach another machine:
-- every copy is emitted as OSC 52 (inside tmux this becomes a tmux buffer,
-- rebroadcast to every attached client, local or SSH). Paste prefers the
-- local Wayland clipboard when one is available, so content copied in other
-- apps remains pasteable; without a display, paste is an OSC 52 query that
-- tmux (or the terminal) answers.
local M = {}

local function proc_lines(pid, file)
    local ok, lines = pcall(vim.fn.readfile, "/proc/" .. pid .. "/" .. file)
    return ok and lines or {}
end

local function proc_ppid(pid)
    for _, line in ipairs(proc_lines(pid, "status")) do
        local ppid = line:match("^PPid:%s+(%d+)")
        if ppid then
            return tonumber(ppid)
        end
    end
end

local function ancestor_process_named(name)
    local pid = vim.fn.getpid()

    for _ = 1, 16 do
        local ppid = proc_ppid(pid)
        if not ppid or ppid <= 1 then
            return false
        end

        local comm = proc_lines(ppid, "comm")[1] or ""
        if comm:find(name, 1, true) then
            return true
        end

        pid = ppid
    end

    return false
end

function M.setup()
    local in_tmux = vim.env.TMUX ~= nil
    local in_ssh = vim.env.SSH_TTY ~= nil or vim.env.SSH_CONNECTION ~= nil
    local in_herdr = vim.env.HERDR_PANE_ID ~= nil or ancestor_process_named("herdr")

    if not (in_tmux or in_ssh or in_herdr) then
        return
    end

    local osc52 = require("vim.ui.clipboard.osc52")
    local has_wayland = vim.env.WAYLAND_DISPLAY ~= nil
        and vim.fn.executable("wl-copy") == 1
        and vim.fn.executable("wl-paste") == 1

    -- wl-copy runs in the background, a yank (or dd, x) waited ~4ms for it otherwise. One at a time
    -- per register, so a quick run of yanks can't finish out of order and leave an older one on the
    -- clipboard; only the latest yank made while one runs is copied after it
    local copies = {} -- by register: { running = bool, pending = text, latest = text }

    local function wl_copy(register, text)
        local state = copies[register]
        state.running = true
        local cmd = { "wl-copy", "--sensitive", "--type", "text/plain" }
        if register == "*" then
            cmd[#cmd + 1] = "--primary"
        end
        vim.system(cmd, { stdin = text }, function()
            vim.schedule(function()
                state.running = false
                local next_text = state.pending
                if next_text then
                    state.pending = nil
                    wl_copy(register, next_text)
                end
            end)
        end)
    end

    local function copy(register)
        local emit = osc52.copy(register)
        copies[register] = { running = false }

        return function(lines)
            if has_wayland then
                -- the same bytes system() wrote: every line ends with a newline
                local text = table.concat(lines, "\n") .. "\n"
                local state = copies[register]
                state.latest = text
                if state.running then
                    state.pending = text
                else
                    wl_copy(register, text)
                end
            end

            if vim.g.omarchy_remote_clipboard_osc52 ~= false then
                emit(lines)
            end
        end
    end

    local function paste(register)
        if not has_wayland then
            return osc52.paste(register)
        end

        return function()
            -- a copy still on its way (a paste right after a yank, e.g. yyp in a macro) would read
            -- the clipboard from before it, so hand out what's being copied, split like wl-paste's
            local state = copies[register]
            if state.running then
                return vim.split(state.latest, "\n", { plain = true })
            end

            local cmd = { "wl-paste", "--no-newline" }
            if register == "*" then
                cmd[#cmd + 1] = "--primary"
            end

            local lines = vim.fn.systemlist(cmd, "", 1)
            return vim.v.shell_error == 0 and lines or {}
        end
    end

    vim.g.clipboard = {
        name = "OmarchyRemoteClipboard",
        copy = { ["+"] = copy("+"), ["*"] = copy("*") },
        paste = { ["+"] = paste("+"), ["*"] = paste("*") },
        cache_enabled = 0,
    }
end

return M
