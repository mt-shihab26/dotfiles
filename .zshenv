# Loaded for every zsh invocation (login, non-login, interactive, script),
# unlike .zshrc which only runs for interactive shells. Keep this file
# limited to environment setup that non-interactive sessions also need.

# /etc/profile.d/locale.sh puts /etc/locale.conf into the environment, but
# only for login shells. Non-login shells (e.g. SSH) miss it and land in the
# C locale, where printf emits \u/\U escapes literally instead of the
# character. Mirror locale.sh for those sessions.
if [[ -z "$LANG" ]]; then
    [[ -r /etc/locale.conf ]] && source /etc/locale.conf
    LANG="${LANG:-C.UTF-8}"
    export LANG LANGUAGE LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY \
        LC_MESSAGES LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT \
        LC_IDENTIFICATION
fi

# Editor used by CLI tools (git commit, sudoedit, crontab -e, ...), which can
# run from non-interactive/non-login shells too (e.g. a bare `ssh host git
# commit`).
export EDITOR="${EDITOR:-omarchy-launch-editor --inline}"
export SUDO_EDITOR="$EDITOR"

# Omarchy environment (OMARCHY_PATH + PATH), needed even for non-interactive
# shells. /etc/omarchy.conf is written by omarchy-dev-link and reset by
# omarchy-dev-unlink; when absent, force the packaged default instead of
# preserving a stale inherited value.
if [[ -f /etc/omarchy.conf ]]; then
    source /etc/omarchy.conf
    : "${OMARCHY_PATH:=/usr/share/omarchy}"
else
    OMARCHY_PATH=/usr/share/omarchy
fi
export OMARCHY_PATH

# Tool-specific paths, referenced by the PATH construction below.
export OPENCODE_PATH=$HOME/.opencode
export COMPOSER_PATH="$HOME/.config/composer"
export BUN_PATH=$HOME/.bun
export RUST_PATH=$HOME/.cargo
export GOPATH="$HOME/go"
export JAVA_HOME="/usr/lib/jvm/default"

# Only prepend in dev-link mode. On a production install, the binaries are
# already on PATH as /usr/bin/omarchy-* via the omarchy package — prepending
# /usr/share/omarchy/bin would just be noise.
if [[ "$OMARCHY_PATH" != /usr/share/omarchy ]]; then
    case ":$PATH:" in
    *":${OMARCHY_PATH%/}/bin:"*) ;;
    *) PATH="${OMARCHY_PATH%/}/bin${PATH:+:$PATH}" ;;
    esac
fi

# User-level tool paths, appended so system binaries keep precedence. This is
# what lets login shells (ssh, zsh -lc) find mise-managed tools without an
# interactive rc.
case ":$PATH:" in
*":$HOME/.local/share/mise/shims:"*) ;;
*) PATH="${PATH:+$PATH:}$HOME/.local/share/mise/shims" ;;
esac
case ":$PATH:" in
*":$HOME/.local/bin:"*) ;;
*) PATH="${PATH:+$PATH:}$HOME/.local/bin" ;;
esac
case ":$PATH:" in
*":$HOME/.bin:"*) ;;
*) PATH="${PATH:+$PATH:}$HOME/.bin" ;;
esac
case ":$PATH:" in
*":$HOME/.local/share/nvim/mason/bin:"*) ;;
*) PATH="${PATH:+$PATH:}$HOME/.local/share/nvim/mason/bin" ;;
esac
case ":$PATH:" in
*":$HOME/.cache/.bun/bin:"*) ;;
*) PATH="${PATH:+$PATH:}$HOME/.cache/.bun/bin" ;;
esac
case ":$PATH:" in
*":$OPENCODE_PATH/bin:"*) ;;
*) PATH="${PATH:+$PATH:}$OPENCODE_PATH/bin" ;;
esac
case ":$PATH:" in
*":$COMPOSER_PATH/vendor/bin:"*) ;;
*) PATH="${PATH:+$PATH:}$COMPOSER_PATH/vendor/bin" ;;
esac
case ":$PATH:" in
*":$BUN_PATH/bin:"*) ;;
*) PATH="${PATH:+$PATH:}$BUN_PATH/bin" ;;
esac
case ":$PATH:" in
*":$RUST_PATH/bin:"*) ;;
*) PATH="${PATH:+$PATH:}$RUST_PATH/bin" ;;
esac
case ":$PATH:" in
*":$GOPATH/bin:"*) ;;
*) PATH="${PATH:+$PATH:}$GOPATH/bin" ;;
esac
case ":$PATH:" in
*":$JAVA_HOME/bin:"*) ;;
*) PATH="${PATH:+$PATH:}$JAVA_HOME/bin" ;;
esac
export PATH

# rustup/cargo shell setup
[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# bob (Neovim version manager) environment
[[ -r "$HOME/.local/share/bob/env/env.sh" ]] && source "$HOME/.local/share/bob/env/env.sh"

# Some tools (e.g. gh) pick up a stray GITHUB_TOKEN from the environment and
# use it over an interactive login; keep it unset unless a shell opts in.
unset GITHUB_TOKEN
