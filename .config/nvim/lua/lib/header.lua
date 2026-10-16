local M = {}

local extensions = { h = true, hpp = true }

--- start an empty C/C++ header (.h, .hpp) with "#pragma once"; a loaded buffer gets it in place with
--- the cursor below it, a file that's only on disk gets it written; anything with content is left alone
---
--- example: add_pragma_once("include/camera.hpp")
---@param path string
function M.add_pragma_once(path)
    if not extensions[vim.fn.fnamemodify(path, ":e")] then
        return
    end

    local buf = vim.fn.bufnr(vim.fn.fnamemodify(path, ":p"))
    if buf ~= -1 and vim.api.nvim_buf_is_loaded(buf) then
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        if #lines > 1 or lines[1] ~= "" then
            return
        end
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "#pragma once", "", "" })
        local win = vim.fn.bufwinid(buf)
        if win ~= -1 then
            vim.api.nvim_win_set_cursor(win, { 3, 0 })
        end
        return
    end

    local stat = vim.uv.fs_stat(path)
    if stat and stat.type == "file" and stat.size == 0 then
        vim.fn.writefile({ "#pragma once", "" }, path)
    end
end

return M
