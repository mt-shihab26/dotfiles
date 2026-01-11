return {
    root_dir = function(fname)
        local util = require "lspconfig.util"
        return util.root_pattern("wp-config.php", "composer.json")(fname) or util.find_git_ancestor(fname)
    end,
}
