# Core Zsh Settings
# Set interactive shell check
[[ $- != *i* ]] && return

# History control
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

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# Completion Settings
# Add custom completion directory to fpath
fpath=("${XDG_DATA_HOME:-$HOME/.local/share}/zsh/site-functions" $fpath)

# Zsh completion configuration (set BEFORE compinit)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# fzf-tab configuration (set BEFORE loading fzf-tab plugin)
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-flags --height=60% --layout=reverse --info=inline

# Show command completions first, then files/directories
# This ensures rustup, cargo, etc show their subcommands
zstyle ':fzf-tab:*' accept-line enter
zstyle ':completion:*:*:-command-:*:*' group-order commands builtins functions

# Enable preview only for file/directory completions
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
# Show preview for general file/directory completions
zstyle ':fzf-tab:complete:*:*' fzf-preview '[[ -d $realpath ]] && ls --color $realpath || [[ -f $realpath ]] && bat -n --color=always $realpath 2>/dev/null || ls --color $realpath'

# Prompt & Theme Setup
# Powerlevel10k theme configuration

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet 
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Plugin Manager: Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Initialize completion system
autoload -Uz compinit && compinit

# Load Plugins with Zinit
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Load completions first
zinit light zsh-users/zsh-completions

# Load fzf-tab before other completion-related plugins
zinit light Aloxaf/fzf-tab

# Load other plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions

# Load OMZ plugins
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Replay compdefs from plugins
zinit cdreplay -q

