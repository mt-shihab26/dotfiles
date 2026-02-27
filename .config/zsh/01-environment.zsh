# Environment Variables
export OMARCHY_HOME="$HOME/.local/share/omarchy"
export GO_HOME="$HOME/go"
export COMPOSER_HOME="$HOME/.config/composer"
export JAVA_HOME="/usr/lib/jvm/default"
export ANDROID_HOME="$HOME/Android/Sdk"
export SUDO_EDITOR="$EDITOR"
export BAT_THEME=ansi

# PATH Management
path_add() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$PATH:$1"
    fi
}

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
