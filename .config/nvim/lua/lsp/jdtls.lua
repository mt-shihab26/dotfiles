-- load the java-debug bundle (Mason's java-debug-adapter) so jdtls can start debug sessions
local bundles = vim.fn.glob(
    vim.fn.stdpath "data" .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
    true,
    true
)

return {
    init_options = {
        bundles = bundles,
    },
}
