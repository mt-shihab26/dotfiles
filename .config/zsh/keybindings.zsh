# zsh's analog of bash's inputrc (bound there via `bind -f` from rc).
# Keybindings live in their own file to mirror that split, even though zsh
# has no readline-format config to translate 1:1.

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# Arrow keys match what you've typed so far against your command history
# (inputrc: "\e[A"/"\e[B" -> history-search-backward/forward)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Immediately add a trailing slash when completing symlinks to directories
# (inputrc: set mark-symlinked-directories on)
setopt MARK_DIRS

# Not ported: inputrc's "TAB: menu-complete" / "\e[Z": menu-complete-backward
# cycling. shell.zsh sets `zstyle ':completion:*' menu no` so fzf-tab owns
# the completion popup; binding TAB to the classic menu-complete widget
# would bypass fzf-tab instead of complementing it.