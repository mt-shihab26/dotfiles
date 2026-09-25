local M = {}

-- Cells the border takes on each side of the image
local border_size = 1

-- Highlight group the border is drawn with
local border_hl = "FloatBorder"

-- How far the image's aspect ratio may drift from the real one after rounding to whole cells
local ratio_tolerance = 0.02

-- Smallest fraction of the fitting size to shrink to while looking for a better aspect ratio
local min_scale = 0.75

-- Snacks writes each image cell as a placeholder character followed by two diacritics encoding its row and column
local chars_per_cell = 3

-- Snacks can only encode this many rows and columns of image cells
local max_cells = 297

-- How much each zoom in or out scales the image
local zoom_step = 1.2

-- Lua has no round(), and a 0 cell image can't be placed
local function round(n)
    return math.max(1, math.floor(n + 0.5))
end

-- Snacks shows image files in buffers with this filetype, the only ones changed here
local function is_image(buf)
    return vim.bo[buf].filetype == "image"
end

-- Offset that centers a bordered image of `size` cells within `area` cells
local function center(area, size)
    return math.max(0, math.floor((area - size - 2 * border_size) / 2))
end

-- A horizontal border line spanning `width` image cells between two corners
local function border_line(left, right, width)
    return { left .. ("─"):rep(width) .. right, border_hl }
end

-- Snacks sizes images in whole cells, so a small image can get stretched by the rounding.
-- Find the largest whole-cell size inside the window that keeps the aspect ratio within a
-- small tolerance. It's fine to leave some space unused when no exact size fits, but only
-- shrink down to 3/4 of the window looking for one, then settle for the closest ratio.
---@param ratio number width / height of the image in cells
local function contain_cells(ratio, max_width, max_height)
    local width = math.max(1, math.min(max_width, math.floor(max_height * ratio)))
    local best, best_error
    for w = width, math.ceil(width * min_scale), -1 do
        local size = { width = w, height = math.min(max_height, round(w / ratio)) }
        local err = math.abs(size.width / size.height - ratio) / ratio
        if err <= ratio_tolerance then
            return size
        end
        if not best_error or err < best_error then
            best, best_error = size, err
        end
    end
    return best
end

-- Snacks only shrinks large images to fit the window. For image buffers, also scale small
-- images up so they always fill the window's width or height (like css `object-fit: contain`),
-- then scale that by the image's zoom level.
local function contain_images(snacks)
    local util = snacks.image.util
    local placement = snacks.image.placement

    local fit = util.fit
    local state = placement.state
    -- the image placement being sized, if it is an image buffer
    local current

    util.fit = function(file, cells, opts)
        if not current then
            return fit(file, cells, opts)
        end
        local info = opts and opts.info
        local pixels = info
            and { width = info.size.width / info.dpi.width, height = info.size.height / info.dpi.height }
            or util.dim(file)
        local cell = snacks.image.terminal.size()
        local ratio = (pixels.width / pixels.height) * (cell.cell_height / cell.cell_width)
        -- leave room for the border around the image
        local room = 2 * border_size
        local max_width, max_height = math.max(1, cells.width - room), math.max(1, cells.height - room)
        local base = contain_cells(ratio, max_width, max_height)
        -- keep the zoom where it changes the image: at least 1 cell and at most what snacks can encode
        local zoom = math.min(current.zoom or 1, max_cells / math.max(base.width, base.height))
        zoom = math.max(zoom, 1 / math.min(base.width, base.height))
        current.zoom = zoom
        if zoom == 1 then
            return base
        end
        local function scale(n)
            return math.min(max_cells, math.max(1, math.floor(n * zoom)))
        end
        return contain_cells(ratio, scale(max_width), scale(max_height))
    end

    placement.state = function(self, ...)
        current = is_image(self.buf) and self or nil
        local ok, result = pcall(state, self, ...)
        current = nil
        if not ok then
            error(result, 0)
        end
        return result
    end
end

-- Snacks hides an image once its buffer leaves every window, but only inline docs ever show
-- it again. Un-hide image buffers when they are displayed so switching back re-renders them.
local function reshow_images(snacks)
    local placement = snacks.image.placement

    local state = placement.state

    placement.state = function(self, ...)
        if is_image(self.buf) and self.hidden and #self:wins() > 0 then
            self.hidden = false
        end
        return state(self, ...)
    end
end

-- Size of the smallest window showing the buffer, measured the same way snacks sizes the image
local function win_area(placement)
    local width, height = vim.o.columns, vim.o.lines
    for _, win in ipairs(placement:wins()) do
        width = math.min(width, vim.api.nvim_win_get_width(win))
        height = math.min(height, vim.api.nvim_win_get_height(win))
    end
    return width, height
end

-- The image rows snacks renders, as highlight chunks: an overlay on the first line plus virtual
-- lines for the rest, or a single inline row for images one cell tall.
local function image_rows(extmarks)
    local first, rest = extmarks[1], extmarks[2]
    if not (first and first.virt_text) then
        return
    end
    if #extmarks == 1 and first.virt_text_pos == "inline" then
        return { first.virt_text[1] }
    elseif #extmarks == 2 and rest.virt_lines then
        local rows = { first.virt_text[1] }
        for _, line in ipairs(rest.virt_lines) do
            rows[#rows + 1] = line[2]
        end
        return rows
    end
end

-- Draw a square border around image buffers and center them in the window. Snacks renders the
-- first image row over the buffer's only line and the remaining rows as virtual lines below it,
-- so the top border takes the place of that first row and everything else moves down into the
-- virtual lines. Centering pads the left with spaces and the top with blank virtual lines.
local function border_images(snacks)
    local placement = snacks.image.placement

    local render = placement._render
    local state = placement.state

    -- Snacks skips re-rendering when the image size is unchanged, but resizing the window
    -- still moves the center, so make the window size part of the state.
    placement.state = function(self, ...)
        local result = state(self, ...)
        if is_image(self.buf) then
            local width, height = win_area(self)
            result.area = { width = width, height = height }
        end
        return result
    end

    placement._render = function(self, extmarks)
        local rows = is_image(self.buf) and image_rows(extmarks)
        if rows then
            local first = extmarks[1]
            local bar = { ("│"):rep(border_size), border_hl }
            -- measure the rendered rows, as snacks caps them at the number of cell positions
            -- it can encode, which can be less than the size in the state
            local width, height = vim.fn.strchars(rows[1][1]) / chars_per_cell, #rows
            local area_width, area_height = win_area(self)
            -- a zoomed in image can be larger than the window, so show only its center
            local max_width = math.max(1, area_width - 2 * border_size)
            local max_height = math.max(1, area_height - 2 * border_size)
            if width > max_width then
                local skip = math.floor((width - max_width) / 2)
                for i, cells in ipairs(rows) do
                    local text = vim.fn.strcharpart(cells[1], skip * chars_per_cell, max_width * chars_per_cell)
                    rows[i] = { text, cells[2] }
                end
                width = max_width
            end
            if height > max_height then
                local skip = math.floor((height - max_height) / 2)
                rows = vim.list_slice(rows, skip + 1, skip + max_height)
                height = max_height
            end
            local left, top = center(area_width, width), center(area_height, height)
            local pad = { (" "):rep(left) }
            local lines = {}
            for i, cells in ipairs(rows) do
                lines[i] = { pad, bar, cells, bar }
            end
            lines[#lines + 1] = { pad, border_line("└", "┘", width) }
            first.virt_text = { border_line("┌", "┐", width) }
            first.virt_text_pos = "overlay"
            first.virt_text_hide = false
            first.virt_text_win_col = left
            extmarks = { first, { row = first.row, col = 0, virt_lines = lines, virt_text_hide = false } }
            if top > 0 then
                local blank = {}
                for i = 1, top do
                    blank[i] = { { "" } }
                end
                extmarks[#extmarks + 1] = { row = first.row, col = 0, virt_lines = blank, virt_lines_above = true }
            end
            -- snacks leaves its last "loading …" spinner on the line once the image is ready,
            -- which shows next to the centered image, so clear it before drawing
            vim.api.nvim_buf_clear_namespace(self.buf, placement.ns, 0, -1)
            render(self, extmarks)
            -- windows keep their old count of virtual lines shown above the first line when the
            -- padding changes, which pushes the image to the top, so scroll them all into view
            for _, win in ipairs(self:wins()) do
                vim.api.nvim_win_call(win, function()
                    vim.fn.winrestview { topline = 1, topfill = top }
                end)
            end
            return
        end
        return render(self, extmarks)
    end
end

-- Zoom image buffers in and out with the scroll wheel (or a trackpad) and with shift + / shift -,
-- and reset the zoom with r.
-- The zoom level lives on the placement, so reopening the image resets it.
local function zoom_images(snacks)
    local placement = snacks.image.placement

    local new = placement.new

    placement.new = function(buf, ...)
        local self = new(buf, ...)
        if not is_image(buf) then
            return self
        end

        local function zoom(factor)
            self.zoom = (self.zoom or 1) * factor
            self:update()
        end

        local function map(lhs, factor, desc)
            vim.keymap.set("n", lhs, function()
                zoom(factor)
            end, { buffer = buf, desc = desc })
        end

        -- scroll other windows as usual when the mouse isn't over this image
        local function map_wheel(lhs, factor, desc)
            vim.keymap.set("n", lhs, function()
                local win = vim.fn.getmousepos().winid
                if win ~= 0 and vim.api.nvim_win_get_buf(win) == buf then
                    zoom(factor)
                else
                    vim.api.nvim_feedkeys(vim.keycode(lhs), "n", false)
                end
            end, { buffer = buf, desc = desc })
        end

        map("+", zoom_step, "Zoom image in")
        map("_", 1 / zoom_step, "Zoom image out")
        map_wheel("<ScrollWheelUp>", zoom_step, "Zoom image in")
        map_wheel("<ScrollWheelDown>", 1 / zoom_step, "Zoom image out")
        vim.keymap.set("n", "r", function()
            self.zoom = 1
            self:update()
        end, { buffer = buf, desc = "Reset image zoom" })
        return self
    end
end

---@param snacks table the loaded snacks module
function M.setup(snacks)
    contain_images(snacks)
    reshow_images(snacks)
    border_images(snacks)
    zoom_images(snacks)
end

return M
