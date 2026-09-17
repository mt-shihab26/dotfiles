-- ruby-lsp is installed via `gem install ruby-lsp ruby-lsp-rails` under
-- mise's active Ruby (not Mason) so `cmd` resolves through mise/PATH to the
-- version pinned by each project's .ruby-version, instead of Mason's copy
-- which is hardcoded to /usr/bin/ruby and breaks on version mismatches.
-- Reinstall with: gem install ruby-lsp ruby-lsp-rails (after `mise use ruby <version>`).
return {
    enabled = true,
    root_markers = { "Gemfile" },
    filetypes = { 'ruby', 'eruby' },
    cmd = { "ruby-lsp" },
    init_options = {
        formatter = "none",
        enabledFeatures = {
            formatting = false,
        },
    },
}
