local M = {}

-- How many du processes count folders at the same time, the rest wait in a queue
local max_jobs = 8

-- How long to wait after a size comes in before redrawing, so a burst of them draws once
local redraw_delay = 30

-- How long changes have to stop before the folders they touched are counted again, so a build or
-- an install writing files nonstop doesn't start counting over on every file
local settle_delay = 500

-- How many levels of folders below a counted one du reports sizes for; du reads the whole tree
-- either way, deeper folders are counted with their own du when opened, which keeps a tree opened
-- at a huge folder like ~ from holding the size of every folder in it
local max_depth = 3

-- Sizes of the folders shown, kept between sessions in one file per working directory, as
-- "<size> <time counted> <path>" lines with paths relative to that directory (see to_cache),
-- most recently shown first, so a project only loads its own.
-- A cached size is used without a du while the folder's date is older than when it was counted;
-- that date only changes when something right inside it is added, removed or renamed, so a file
-- edited or added deeper in it outside nvim keeps the old size until it changes in the tree, or
-- sizes are turned off and on again (<leader>tS), which counts everything again
local cache_dir = vim.fn.stdpath "state" .. "/folder_size/"

-- How many folders each cache file keeps, the ones not shown this session are dropped first; 5000 lines are
-- about 370KB, load in about 4ms and take about 1MB of memory
local max_cached = 5000

-- size in bytes of each folder du has counted, by path; false when du couldn't count it
local sizes = {}

-- when each size in `sizes` was counted, the time du started, by path
local counted_at = {}

-- { size, time counted } from the cache file of `cache_cwd` by path, loaded when the first size
-- is asked for
local cached, cache_cwd

-- folders shown this session, so only they're saved to the cache file and not every folder du reported
local shown = {}

-- folders whose size is out of date, by path, with the change number that made them so; they
-- keep showing the old size until they're counted again
local outdated = {}

-- folders queued or being counted
local requested = {}

-- folders waiting for a free du, in the order they were asked for (top to bottom in the tree)
local queue = {}

-- counts every batch of changes, so a du that started before one doesn't mark its folders as up to date
local change = 0

-- folders changed since the last batch, applied once changes settle
local changes = {}

local running = 0

-- bumped when everything is dropped, so a du still running then doesn't store its sizes
local epoch = 0
local redraw_pending = false
local settle_timer = assert(vim.uv.new_timer())

-- set by the tree to redraw itself once new sizes are in
M.on_update = function() end

local function redraw()
    if redraw_pending then
        return
    end
    redraw_pending = true
    vim.defer_fn(function()
        redraw_pending = false
        M.on_update()
    end, redraw_delay)
end

-- up to date when counted and not changed since
local function is_current(path)
    return sizes[path] ~= nil and not outdated[path]
end

local function store(path, size, started, time)
    counted_at[path] = time
    sizes[path] = size
    -- a change after this du started still needs a recount
    if outdated[path] and outdated[path] <= started then
        outdated[path] = nil
    end
end

-- a folder above `path` is queued or being counted, its du will likely count `path` too
local function has_requested_parent(path)
    local dir = vim.fs.dirname(path)
    while dir ~= path do
        if requested[dir] then
            return true
        end
        path, dir = dir, vim.fs.dirname(dir)
    end
    return false
end

local function pump()
    local i = 1
    while running < max_jobs and i <= #queue do
        local path = queue[i]
        if is_current(path) then
            -- counted meanwhile by a du of a folder above it
            table.remove(queue, i)
            requested[path] = nil
        elseif has_requested_parent(path) then
            -- wait for that du instead of reading the same files twice at once
            i = i + 1
        else
            table.remove(queue, i)
            running = running + 1
            local started, started_epoch, time = change, epoch, os.time()
            -- no -s: du walks the same files either way, and printing the folders below costs
            -- nothing extra, so opening them later shows their size right away without a du;
            -- -b: apparent size in bytes like the file sizes, -0: NUL ended, as names can hold newlines
            vim.system({ "du", "-b0", "--max-depth=" .. max_depth, path }, { text = false }, function(result)
                vim.schedule(function()
                    running = running - 1
                    -- everything was dropped meanwhile
                    if started_epoch ~= epoch then
                        pump()
                        return
                    end
                    requested[path] = nil
                    -- du exits with an error on folders it can't read, but still prints the rest
                    for line in (result.stdout or ""):gmatch "%Z+" do
                        local size, dir = line:match "^(%d+)\t(.*)$"
                        if size then
                            store(dir, tonumber(size), started, time)
                        end
                    end
                    if sizes[path] == nil then
                        store(path, false, started, time)
                    end
                    redraw()
                    pump()
                end)
            end)
        end
    end
end

local home = assert(vim.uv.os_homedir())

-- paths in the cache are written with ~ for the home folder, shorter and the same on every machine
local function shorten_home(path)
    if path == home or vim.startswith(path, home .. "/") then
        return "~" .. path:sub(#home + 1)
    end
    return path
end

-- a path as written in the cache file of `cache_cwd`: relative to it when inside it ("." for
-- itself), as the file already names it, otherwise with ~ for the home folder
local function to_cache(path)
    if path == cache_cwd then
        return "."
    end
    if vim.startswith(path, cache_cwd .. "/") then
        return path:sub(#cache_cwd + 2)
    end
    return shorten_home(path)
end

-- back to the absolute path; counted paths are absolute, so only a path from the cache starts
-- with ~ or doesn't start with /
local function from_cache(path)
    if path == "." then
        return cache_cwd
    end
    local first = path:sub(1, 1)
    if first == "~" then
        return home .. path:sub(2)
    end
    if first ~= "/" then
        return cache_cwd .. "/" .. path
    end
    return path
end

-- the cache file of a working directory, named after it with "%" for "/" like nvim's undo files,
-- e.g. "~%projects%app"
local function cache_path(cwd)
    return cache_dir .. shorten_home(cwd):gsub("/", "%%")
end

local function load_cache()
    cached, cache_cwd = {}, vim.fn.getcwd()
    local file = io.open(cache_path(cache_cwd), "rb")
    if not file then
        return
    end
    for line in file:read("*a"):gmatch "[^\n]+" do
        -- matched per line from its start, so a line in another format is skipped as a whole
        local size, time, path = line:match "^(%d+) (%d+) (.+)$"
        if size then
            cached[from_cache(path)] = { tonumber(size), tonumber(time) }
        end
    end
    file:close()
end

-- the size of the folder at `path` in bytes, nil until it's counted; asking queues a du for it in
-- the background, and `M.on_update` runs as soon as it's done. A cached size is used as it is when
-- the folder hasn't changed since (see `cache_dir`); otherwise, and after a change, the old size
-- shows while it's counted again.
function M.get(path)
    if not cached then
        load_cache()
    end
    shown[path] = true
    local entry = cached[path]
    if entry and sizes[path] == nil and not requested[path] then
        local stat = vim.uv.fs_stat(path)
        if stat and stat.mtime.sec < entry[2] then
            sizes[path], counted_at[path] = entry[1], entry[2]
        end
    end
    if not is_current(path) and not requested[path] then
        requested[path] = true
        queue[#queue + 1] = path
        pump()
    end
    return sizes[path] or entry and entry[1]
end

-- keep the counted sizes of the folders shown in the cache, as `sizes` is about to be dropped or saved
local function update_cache()
    for path in pairs(shown) do
        if sizes[path] and counted_at[path] then
            cached[path] = { sizes[path], counted_at[path] }
        end
    end
end

-- write the cache file of the working directory it was loaded for, the folders shown this session
-- first; written to a temporary file first, so a crash or another nvim saving at the same time
-- can't leave half a file. Writes `cached` as it is, see M.save for the sizes counted this session
local function write_cache()
    local lines = {}
    for path in pairs(shown) do
        local entry = cached[path]
        if entry and not path:find("\n", 1, true) then
            lines[#lines + 1] = entry[1] .. " " .. entry[2] .. " " .. to_cache(path)
        end
    end
    for path, entry in pairs(cached) do
        if #lines >= max_cached then
            break
        end
        if not shown[path] then
            lines[#lines + 1] = entry[1] .. " " .. entry[2] .. " " .. to_cache(path)
        end
    end
    -- a cache file that can't be written is only a slower start next time, not worth an error on quit
    if not pcall(vim.fn.mkdir, cache_dir, "p") then
        return
    end
    local path = cache_path(cache_cwd)
    local temp = path .. ".tmp" .. vim.uv.os_getpid()
    local file = io.open(temp, "wb")
    if not file then
        return
    end
    file:write(table.concat(lines, "\n", 1, math.min(#lines, max_cached)), "\n")
    file:close()
    vim.uv.fs_rename(temp, path)
end

-- save the sizes shown this session to the cache file, on quit; about 1ms for a full one
function M.save()
    if not cached then
        return
    end
    update_cache()
    write_cache()
end

-- drop every size and every folder waiting for a du, freeing their memory; used when sizes are
-- turned off and when the working directory changes, as the old project's sizes won't be shown.
-- The sizes of the folders shown are saved to the cache file first, the next size asked for loads
-- the file of the working directory then. With `recount`, every cached size is counted again the
-- next time it's shown, while still showing until then.
function M.clear(recount)
    if cached then
        update_cache()
        if recount then
            -- counted at 0: older than any folder's date
            for _, entry in pairs(cached) do
                entry[2] = 0
            end
        end
        -- not M.save, which would copy the sizes counted this session back over the zeroed times
        write_cache()
        cached, shown = nil, {}
    end
    epoch = epoch + 1
    sizes, counted_at, outdated, requested, queue, changes = {}, {}, {}, {}, {}, {}
    settle_timer:stop()
end

local function apply_changes()
    change = change + 1
    for path in pairs(changes) do
        -- the folder and every folder above it change with it, the ones below don't
        local dir = path
        while dir do
            if sizes[dir] ~= nil then
                outdated[dir] = change
            end
            -- a cached size not shown yet this session: its folder's date may not have changed, as
            -- the change can be deeper in it, so mark it as counted at 0 to count it again
            if cached and cached[dir] then
                cached[dir][2] = 0
            end
            local parent = vim.fs.dirname(dir)
            dir = parent ~= dir and parent or nil
        end
    end
    changes = {}
    redraw()
end

-- something in the folder at `path` changed; once changes stop for `settle_delay`, it and every
-- folder above it are counted again. Nothing to do while sizes are off (vim.g.tree_sizes)
function M.changed(path)
    if not vim.g.tree_sizes then
        return
    end
    changes[path] = true
    settle_timer:stop()
    settle_timer:start(settle_delay, 0, vim.schedule_wrap(apply_changes))
end

return M
