############################
# Prompt & Theme Setup
############################

# Silence Powerlevel10k's instant prompt
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Load Powerlevel10k configuration (run `p10k configure` to update)
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


############################
# Plugin Manager: Zinit
############################

# Define Zinit path
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Install Zinit if missing
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# Initialize completion BEFORE plugin loading
autoload -Uz compinit && compinit

# Replay compdefs now that compinit is active
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

# OMZ plugin snippets
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
export GEM_HOME="$(gem env user_gemhome)"
export COMPOSER_HOME="$HOME/.config/composer"
export JAVA_HOME="/usr/lib/jvm/default"

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"
export PATH="$PATH:$HOME/.local/share/bob/nvim-bin"
export PATH="$PATH:$HOME/.local/share/omarchy/bin"
export PATH="$PATH:$HOME/.cache/.bun/bin"
export PATH="$PATH:$GEM_HOME/bin"
export PATH="$PATH:$COMPOSER_HOME/vendor/bin"
export PATH="$PATH:$GO_HOME/bin"
export PATH="$PATH:$JAVA_HOME/bin"

############################
# Aliases
############################

alias ls="ls --color -h"

alias init="$HOME/.scripts/tmux/init.sh"
alias sessionizer="$HOME/.scripts/tmux/sessionizer.sh"
alias kill-session="$HOME/.scripts/tmux/kill-session.sh"

alias projects="sessionizer projects"
alias learns="sessionizer learns"

alias pa="php artisan"
alias wip="git add . && git commit -m 'wip'"

############################
# Shell Integrations
############################

source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"

############################
# Injected Configs
############################

