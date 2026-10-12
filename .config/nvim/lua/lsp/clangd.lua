-- --query-driver lets clangd run gcc to read its system include paths and
-- target, so projects built with gcc get gcc's headers instead of clang's.
-- The compiler itself is chosen in ~/.config/clangd/config.yaml.
return {
    cmd = {
        "clangd",
        "--query-driver=/usr/bin/gcc,/usr/bin/g++",
    },
}
