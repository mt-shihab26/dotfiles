# mise - version manager (MUST load first)
if command -v mise &>/dev/null
    mise activate fish | source
end

# fzf - fuzzy finder
if command -v fzf &>/dev/null
    fzf --fish | source
end

# rustup - Rust toolchain installer
if test -f $HOME/.cargo/env.fish
    source $HOME/.cargo/env.fish
end
