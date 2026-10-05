local M = {}

--- build a greeting for a name
---@param name string
---@return string
function M.greet(name)
    return "Hello, " .. name .. "!"
end

--- add up a list of numbers
---@param numbers number[]
---@return number
function M.sum(numbers)
    local total = 0
    for _, n in ipairs(numbers) do
        total = total + n
    end
    return total
end

for _, name in ipairs { "world", "Neovim" } do
    print(M.greet(name))
end

print(("sum: %d"):format(M.sum { 1, 2, 3 }))

return M
