if command -v mise &>/dev/null; then
    eval "$(mise activate zsh)"
fi

if command -v zoxide &>/dev/null; then
    eval "$(zoxide init --cmd cd zsh)"
fi

if command -v fzf &>/dev/null; then
    source <(fzf --zsh)
fi
