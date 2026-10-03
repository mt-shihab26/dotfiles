local dap = require "dap"
local jdtls_dap = require "jdtls.dap"

-- talks to the java-debug bundle loaded into jdtls, see lsp/jdtls.lua
jdtls_dap.setup_dap { hotcodereplace = "auto" }

dap.configurations.java = {
    {
        type = "java",
        request = "launch",
        name = "Launch file",
    },
}
