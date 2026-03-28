# Editor used by CLI
export SUDO_EDITOR="$EDITOR"
export BAT_THEME=ansi

# Defining Home
export OMARCHY_PATH=$HOME/.local/share/omarchy
export OPENCODE_PATH=$HOME/.opencode
export COMPOSER_PATH="$HOME/.config/composer"
export BUN_PATH=$HOME/.bun
export RUST_PATH=$HOME/.cargo

export GOPATH="$HOME/go"

export JAVA_HOME="/usr/lib/jvm/default"

# Defining Paths
export PATH=$PATH:$HOME/.bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/share/nvim/mason/bin
export PATH=$PATH:$HOME/.local/share/mise/shims
export PATH=$PATH:$HOME/.cache/.bun/bin

export PATH=$PATH:$OMARCHY_PATH/bin
export PATH=$PATH:$OPENCODE_PATH/bin
export PATH=$PATH:$COMPOSER_PATH/vendor/bin
export PATH=$PATH:$BUN_PATH/bin
export PATH=$PATH:$RUST_HOME/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$JAVA_HOME/bin

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
