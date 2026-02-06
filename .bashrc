# mise MUST load first (for ALL shells)
if command -v mise &>/dev/null; then
    eval "$(mise activate bash)"
fi

# Ensure mise shims always have priority
export PATH="$HOME/.local/share/mise/shims:$PATH"

# Composer bin path
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# Stop here for non-interactive shells AFTER env setup
[[ $- != *i* ]] && return

# Load Omarchy defaults
source ~/.local/share/omarchy/default/bash/rc
