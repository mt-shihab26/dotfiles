return {
    -- Priority order: wp-config.php > .git > composer.json > index.php > file dir
    root_dir = function(fname)
        local lspconfig = require "lspconfig"

        local wp_root = lspconfig.util.root_pattern "wp-config.php"(fname)
        if wp_root then
            return wp_root
        end

        local git_root = lspconfig.util.root_pattern ".git"(fname)
        if git_root then
            return git_root
        end

        local composer_root = lspconfig.util.root_pattern "composer.json"(fname)
        if composer_root then
            return composer_root
        end

        local index_root = lspconfig.util.root_pattern "index.php"(fname)
        if index_root then
            return index_root
        end

        return lspconfig.util.path.dirname(fname)
    end,
}
