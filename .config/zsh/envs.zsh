# Used by terminal programs (like gh) to open URLs detached from the terminal
# process tree. Shell-scoped on purpose: exporting BROWSER session-wide makes
# xdg-settings refuse to change the default browser.
export BROWSER="${BROWSER:-omarchy-launch-browser}"
export BAT_THEME=ansi

# Color man pages with bat
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Generate rustup/cargo completions if they don't exist
if command -v rustup &>/dev/null; then
    COMPLETION_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/site-functions"

    # Generate completion files if they don't exist
    if [[ ! -f "$COMPLETION_DIR/_rustup" ]] || [[ ! -f "$COMPLETION_DIR/_cargo" ]]; then
        mkdir -p "$COMPLETION_DIR"
        rustup completions zsh rustup >"$COMPLETION_DIR/_rustup"
        rustup completions zsh cargo >"$COMPLETION_DIR/_cargo"
    fi

    unset COMPLETION_DIR
fi
