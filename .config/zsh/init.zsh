if command -v mise &>/dev/null; then
    eval "$(mise activate zsh)"
fi

if command -v zoxide &>/dev/null; then
    eval "$(zoxide init --cmd cd zsh)"
fi

if command -v fzf &>/dev/null; then
    source <(fzf --zsh)
fi

[ -s "$BUN_PATH/_bun" ] && source "$BUN_PATH/_bun"

if command -v uv &>/dev/null; then
    eval "$(uv generate-shell-completion zsh)"
fi
if command -v uvx &>/dev/null; then
    eval "$(uvx --generate-shell-completion zsh)"
fi

source "$HOME/.config/zsh/completions.zsh"
