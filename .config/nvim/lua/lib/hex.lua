local M = {}

-- How much of a file is checked for a NUL byte to decide it's binary (git checks the same amount)
local sniff_size = 8000

-- Larger binaries open in normal view, xxd turns each 16 bytes into a ~68 character line
local max_size = 10 * 1024 * 1024

-- true when a NUL byte shows up in the first `sniff_size` bytes of the file
local function is_binary(path)
    local file = io.open(path, "rb")
    if not file then
        return false
    end
    local head = file:read(sniff_size) or ""
    file:close()
    return head:find("\0", 1, true) ~= nil
end

-- run xxd with `input` on stdin and return its stdout, nil and an error when it fails
local function xxd(args, input)
    local result = vim.system(vim.list_extend({ "xxd" }, args), { stdin = input }):wait()
    if result.code ~= 0 then
        return nil, result.stderr
    end
    return result.stdout
end

-- split on "\n" without the empty string after a trailing newline; also returns whether there was one
local function split_lines(text)
    local lines = vim.split(text, "\n", { plain = true })
    local trailing = #lines > 1 and lines[#lines] == ""
    if trailing then
        lines[#lines] = nil
    end
    return lines, trailing
end

-- the file's bytes as the buffer holds them, in either view
local function buffer_bytes(buf)
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local text = table.concat(lines, "\n")
    if vim.b[buf].hex_view then
        return xxd({ "-r" }, text .. "\n")
    end
    -- the api hands back NUL bytes as they are, so joining the lines gives the original bytes
    return text .. (vim.b[buf].hex_eol and "\n" or "")
end

-- replace the buffer's lines without an undo step, undoing past this would mix the two views;
-- the modified flag is kept, so unsaved edits are still unsaved after switching views
local function replace_lines(buf, lines)
    local modified = vim.bo[buf].modified
    local undolevels = vim.bo[buf].undolevels
    vim.bo[buf].undolevels = -1
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].undolevels = undolevels
    vim.bo[buf].modified = modified
end

local function show_hex(buf, bytes)
    local hex, err = xxd({}, bytes)
    if not hex then
        vim.notify("xxd failed: " .. err, vim.log.levels.ERROR)
        return
    end
    replace_lines(buf, (split_lines(hex)))
    vim.b[buf].hex_view = true
    vim.bo[buf].filetype = "xxd"
end

local function show_normal(buf, bytes)
    -- NUL bytes inside the lines are fine, the api stores them the way a file read would
    local lines, trailing = split_lines(bytes)
    replace_lines(buf, lines)
    vim.b[buf].hex_view = false
    vim.b[buf].hex_eol = trailing
    vim.bo[buf].filetype = "binary"
end

-- write the bytes behind either view, so :w in hex view saves the binary and not the xxd dump
local function write(buf, path)
    local bytes, err = buffer_bytes(buf)
    if not bytes then
        vim.notify("xxd -r failed: " .. err, vim.log.levels.ERROR)
        return
    end
    local file, open_err = io.open(path, "wb")
    if not file then
        vim.notify("can't write " .. path .. ": " .. open_err, vim.log.levels.ERROR)
        return
    end
    file:write(bytes)
    file:close()

    if path == vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":p") then
        vim.bo[buf].modified = false
    end
    vim.api.nvim_echo({ { string.format('"%s" %dB written', vim.fn.fnamemodify(path, ":~:."), #bytes) } }, false, {})
end

-- switch the buffer between the xxd dump and the raw bytes, keeping any unsaved edits
function M.toggle(buf)
    buf = buf or vim.api.nvim_get_current_buf()
    local bytes, err = buffer_bytes(buf)
    if not bytes then
        vim.notify("xxd -r failed: " .. err, vim.log.levels.ERROR)
        return
    end
    if vim.b[buf].hex_view then
        show_normal(buf, bytes)
    else
        show_hex(buf, bytes)
    end
end

-- before the read: read binary files with 'binary', so the buffer holds the bytes as they are and
-- not run through 'fileformat' and 'fileencoding'
function M.prepare(buf)
    local path = vim.api.nvim_buf_get_name(buf)
    local binary = path ~= "" and vim.bo[buf].buftype == "" and is_binary(path)

    -- :e of a file that was binary and isn't anymore
    if not binary and vim.b[buf].hex_binary then
        vim.api.nvim_clear_autocmds { group = vim.api.nvim_create_augroup("hex_view", { clear = false }), buffer = buf }
        pcall(vim.keymap.del, "n", "<leader>tx", { buffer = buf })
        vim.bo[buf].binary = false
    end

    vim.b[buf].hex_binary = binary
    if binary then
        vim.bo[buf].binary = true
    end
end

-- after the read: open binary files in hex view, or in normal view over `max_size`, the buffer then
-- writes the file's bytes itself
function M.attach(buf)
    if not vim.b[buf].hex_binary then
        return
    end

    vim.b[buf].hex_view = false
    vim.b[buf].hex_eol = vim.bo[buf].eol
    -- setting a filetype here keeps the BufReadPost detection from running, so snacks bigfile never
    -- marks a binary; there's nothing in one to highlight or for a language server to read anyway
    vim.bo[buf].filetype = "binary"
    if vim.fn.getfsize(vim.api.nvim_buf_get_name(buf)) <= max_size then
        show_hex(buf, buffer_bytes(buf))
    end

    local group = vim.api.nvim_create_augroup("hex_view", { clear = false })
    vim.api.nvim_clear_autocmds { group = group, buffer = buf }
    vim.api.nvim_create_autocmd("BufWriteCmd", {
        group = group,
        buffer = buf,
        callback = function(args)
            write(buf, vim.fn.fnamemodify(args.file, ":p"))
        end,
    })

    vim.keymap.set("n", "<leader>tx", function()
        M.toggle(buf)
    end, { buffer = buf, desc = "toggle hex view of a binary file (xxd)" })
end

return M
