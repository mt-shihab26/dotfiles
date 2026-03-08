# Editor
set -x SUDO_EDITOR "$EDITOR"
set -x BAT_THEME ansi

# Bin
set -x PATH $PATH $HOME/.bin
set -x PATH $PATH $HOME/.local/bin
set -x PATH $PATH $HOME/.local/share/nvim/mason/bin

# Omarchy
set -x OMARCHY_HOME $HOME/.local/share/omarchy
set -x PATH $PATH $OMARCHY_PATH/bin

# Rust
set -x CARGO_HOME $HOME/.cargo
set -x PATH $PATH $CARGO_HOME/bin

# PHP
set -x COMPOSER_HOME $HOME/.config/composer
set -x PATH $PATH $COMPOSER_HOME/vendor/bin

# JavaScript
set -x BUN_HOME $HOME/.bun
set -x PATH $PATH $BUN_HOME/bin
set -x PATH $PATH $HOME/.cache/.bun/bin

# Java
set -x JAVA_HOME /usr/lib/jvm/default
set -x PATH $PATH $JAVA_HOME/bin

# Go
set -x GO_HOME $HOME/go
set -x PATH $PATH $GO_HOME/bin
