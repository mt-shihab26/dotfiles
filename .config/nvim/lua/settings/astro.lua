return {
    before_init = function(_, config)
        local util = require "lspconfig.util"
        if config.init_options and config.init_options.typescript and not config.init_options.typescript.tsdk then
            local tsdk = util.get_typescript_server_path(config.root_dir)
            if tsdk == "" then
                tsdk = vim.fn.stdpath "data"
                    .. "/mason/packages/astro-language-server/node_modules/typescript/lib"
            end
            config.init_options.typescript.tsdk = tsdk
        end
    end,
}
