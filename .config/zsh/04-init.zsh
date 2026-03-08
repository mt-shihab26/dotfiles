# Tool Integrations
# mise - version manager (MUST load first)
if command -v mise &>/dev/null; then
    eval "$(mise activate zsh)"
fi

# fzf - fuzzy finder
if command -v fzf &>/dev/null; then
    source <(fzf --zsh)
fi

# zoxide - smart directory navigation
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init --cmd cd zsh)"
fi

# starship - cross-shell prompt (optional, only if configured)
# if command -v starship &> /dev/null; then
#   __sanitize_prompt() { printf '\r\033[K'; }
#   PROMPT_COMMAND="__sanitize_prompt${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
#   eval "$(starship init zsh)"
# fi

# Shell completions
# Generate rustup/cargo completions if they don't exist
if command -v rustup &>/dev/null; then
    COMPLETION_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/site-functions"

    # Generate completion files if they don't exist
    if [[ ! -f "$COMPLETION_DIR/_rustup" ]] || [[ ! -f "$COMPLETION_DIR/_cargo" ]]; then
        mkdir -p "$COMPLETION_DIR"
        rustup completions zsh rustup >"$COMPLETION_DIR/_rustup"
        rustup completions zsh cargo >"$COMPLETION_DIR/_cargo"
    fi

    unset COMPLETION_DIR
fi

# Disable command hashing for mise
set +h
