############################
# mise MUST load first
############################
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

# Ensure mise shims always have priority
export PATH="$HOME/.local/share/mise/shims:$PATH"


############################
# Prompt & Theme Setup
############################

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


############################
# Plugin Manager: Zinit
############################

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz compinit && compinit
zinit cdreplay -q


############################
# Completion Settings
############################

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


############################
# Load Plugins with Zinit
############################

zinit ice depth=1
zinit light romkatv/powerlevel10k

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found


############################
# History Settings
############################

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


############################
# Keybindings
############################

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region


############################
# Environment Variables
############################

export GO_HOME="$HOME/go"
export COMPOSER_HOME="$HOME/.config/composer"
export JAVA_HOME="/usr/lib/jvm/default"
export OMARCHY_HOME="$HOME/.local/share/omarchy"
export ANDROID_HOME="$HOME/Android/Sdk"


############################
# PATH (append safely — do not override mise)
############################

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


############################
# Aliases
############################

alias ls="ls --color -h"
alias artisan="php artisan"
alias tree='tree --gitignore'
alias cloc='cloc --vcs=git'


############################
# Shell Integrations
############################

source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"


############################
# End
############################
