return function()
    local message = vim.fn.input "commit message (empty for 'wip'): "
    if message == "" then
        message = "wip"
    end
    vim.fn.system(string.format("git add . && git commit -m '%s' && git push origin HEAD", message))
    if vim.v.shell_error == 0 then
        print("\ncommitted and pushed: " .. message)
    else
        print "\nerror running git wip"
    end
end
