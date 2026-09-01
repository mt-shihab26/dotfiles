-- composer global require laravel/lsp
return {
    cmd = { "laravel-lsp" },
    filetypes = { "php", "blade" },
    root_markers = { "artisan" },
    workspace_required = true,
}
