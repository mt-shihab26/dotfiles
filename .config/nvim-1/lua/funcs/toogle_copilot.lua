return function()
    -- Check if Copilot is already disabled
    local is_disabled = vim.g.copilot_enabled == false

    if is_disabled then
        -- Enable Copilot
        vim.g.copilot_enabled = true
        vim.cmd "Copilot enable"
        print "copilot enabled"
    else
        -- Disable Copilot
        vim.g.copilot_enabled = false
        vim.cmd "Copilot disable"
        print "copilot disabled"
    end
end
