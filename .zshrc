source "$HOME/.config/zsh/envs.zsh"
source "$HOME/.config/zsh/shells.zsh"
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/functions.zsh"
source "$HOME/.config/zsh/init.zsh"

# --------------------------------------

# Environment Variables
export GO_HOME="$HOME/go"
export COMPOSER_HOME="$HOME/.config/composer"
export JAVA_HOME="/usr/lib/jvm/default"
export OMARCHY_HOME="$HOME/.local/share/omarchy"
export ANDROID_HOME="$HOME/Android/Sdk"

# PATH (append safely — do not override mise)
path_add() { export PATH="$PATH:$1"; }

path_add "$HOME/.local/bin"
path_add "$HOME/.local/share/nvim/mason/bin"
path_add "$HOME/.local/share/bob/nvim-bin"
path_add "$HOME/.local/share/omarchy/bin"
path_add "$HOME/.cache/.bun/bin"
path_add "$COMPOSER_HOME/vendor/bin"
path_add "$GO_HOME/bin"
path_add "$JAVA_HOME/bin"
path_add "$ANDROID_HOME/platform-tools"
path_add "$ANDROID_HOME/emulator"
path_add "$ANDROID_HOME/cmdline-tools/latest/bin"

# Aliases
alias ls="ls --color -h"
alias artisan="php artisan"
alias tree='tree --gitignore'
alias cloc='cloc --vcs=git'

# Shell Integrations
source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"

# End
