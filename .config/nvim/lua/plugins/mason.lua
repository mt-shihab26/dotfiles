return {
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup()

        local mr = require "mason-registry"

        for _, tool in ipairs(require "configs.bins") do
            local p = mr.get_package(tool)
            if not p:is_installed() then
                p:install()
            end
        end
    end,
}
