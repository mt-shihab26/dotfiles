-- slangd comes with the shader-slang-bin AUR package (yay -S shader-slang-bin), not Mason.
-- It installs to /opt/shader-slang-bin, which isn't on PATH.
return {
    cmd = { "/opt/shader-slang-bin/bin/slangd" },
}
