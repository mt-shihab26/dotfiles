# Bun completions
if command -v bun &>/dev/null
    bun completions | source
end

# Rustup completions
if command -v rustup &>/dev/null
    rustup completions fish rustup | source
end
