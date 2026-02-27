# ZSH Configuration Entry Point
# All configuration is modular and sourced from .config/zsh/

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Source all modular zsh configuration files
if [[ -d "$XDG_CONFIG_HOME/zsh" ]]; then
  for config_file in "$XDG_CONFIG_HOME"/zsh/[0-9][0-9]-*.zsh; do
    [[ -f "$config_file" ]] && source "$config_file"
  done
  unset config_file
fi
