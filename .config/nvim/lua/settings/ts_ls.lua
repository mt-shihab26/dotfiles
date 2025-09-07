local vue_language_server =
    "/home/shihab/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server"

return {
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = vue_language_server,
                languages = { "vue" },
            },
        },
    },
    filetypes = { "vue" },
}
