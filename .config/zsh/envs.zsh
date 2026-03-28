# Editor used by CLI
export SUDO_EDITOR="$EDITOR"
export BAT_THEME=ansi

# Duplicated from .config/uwsm/env so SSH works too
export OMARCHY_PATH=$HOME/.local/share/omarchy
export PATH=$PATH:$OMARCHY_PATH/bin

# General binaries
export PATH=$PATH:$HOME/.bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/share/nvim/mason/bin
export PATH=$PATH:$HOME/.local/share/mise/shims
export PATH=$PATH:$HOME/.opencode/bin
