# Editor
export SUDO_EDITOR="$EDITOR"
export BAT_THEME=ansi

# Bin
export PATH=$PATH:$HOME/.bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/share/nvim/mason/bin

# Omarchy
export OMARCHY_HOME=$HOME/.local/share/omarchy
export PATH=$PATH:$OMARCHY_PATH/bin

# Rust
export RUST_HOME=$HOME/.cargo
export PATH=$PATH:$RUST_HOME/bin
eval "$(rustup completions zsh)"

# PHP
export COMPOSER_HOME=$HOME/.config/composer
export PATH=$PATH:$COMPOSER_HOME/vendor/bin

# JavaScript
export BUN_HOME=$HOME/.bun
export PATH=$PATH:$BUN_HOME/bin
export PATH=$PATH:$HOME/.cache/.bun/bin
[ -s "$BUN_HOME/_bun" ] && source "$BUN_HOME/_bun"

# Python
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# Java
export JAVA_HOME=/usr/lib/jvm/default
export PATH=$PATH:$JAVA_HOME/bin

# Go
export GO_HOME=$HOME/go
export PATH=$PATH:$GO_HOME/bin
