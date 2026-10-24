local M = {}

-- size in bytes of each folder du has counted, by path
local sizes = {}

-- folders whose subfolders du is counting or has counted, so each is only run once until a change
local counted = {}

-- bumped on every change, so a du that was running during one doesn't store its outdated sizes
local generation = 0

-- the size of `path` in bytes, nil until it's counted; asking starts a du in the background for the
-- folder holding it, which counts all its subfolders at once and calls `on_counted` when done
function M.get(path, on_counted)
    if sizes[path] then
        return sizes[path]
    end
    local parent = vim.fs.dirname(path)
    if counted[parent] then
        return nil
    end
    counted[parent] = true

    local started = generation
    -- -b: apparent size in bytes like the file sizes, -0: NUL separated, as names can hold newlines
    vim.system({ "du", "-b0", "--max-depth=1", parent }, { text = false }, function(result)
        -- outdated by a change while it ran: count again on the next redraw
        if started ~= generation then
            counted[parent] = nil
            vim.schedule(on_counted)
            return
        end
        -- du exits with an error on folders it can't read, but still prints the rest
        for _, line in ipairs(vim.split(result.stdout or "", "\0", { plain = true, trimempty = true })) do
            local size, dir = line:match "^(%d+)\t(.*)$"
            if size then
                sizes[dir] = tonumber(size)
            end
        end
        vim.schedule(on_counted)
    end)
    return nil
end

-- forget the sizes of `path` and every folder above it, they all change with it; folders counted
-- before are counted again the next time they're shown
function M.changed(path)
    generation = generation + 1
    for dir in pairs(sizes) do
        if path == dir or vim.startswith(path, dir .. "/") then
            sizes[dir] = nil
        end
    end
    for dir in pairs(counted) do
        if path == dir or vim.startswith(path, dir .. "/") then
            counted[dir] = nil
        end
    end
end

return M
