# ZSH Configuration Entry Point
# This file sources all modular configuration from .config/zsh/

# Ensure XDG base directory is set
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Source all zsh configuration files from .config/zsh/
# Files are sourced in numerical order (00, 01, 02, etc.)
if [[ -d "$XDG_CONFIG_HOME/zsh" ]]; then
  for config_file in "$XDG_CONFIG_HOME"/zsh/[0-9][0-9]-*.zsh; do
    [[ -f "$config_file" ]] && source "$config_file"
  done
  unset config_file
fi

# Prompt & Theme Setup (after all configs are loaded)
# Using Powerlevel10k theme
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet 
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Plugin Manager: Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz compinit && compinit
zinit cdreplay -q

# Load Plugins with Zinit
zinit ice depth=1
zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found
