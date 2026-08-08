return {
    filetypes = { "php", "blade" },
    root_markers = { "wp-config.php", "composer.json" },
    get_language_id = function(_, ftype)
        if ftype == "blade" then
            return "php"
        end
        return ftype
    end,
}
