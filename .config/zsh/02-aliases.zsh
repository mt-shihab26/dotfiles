# File System Aliases
if command -v eza &>/dev/null; then
    alias ls='eza -lh --group-directories-first --icons=auto'
    alias lsa='ls -a'
    alias lt='eza --tree --level=2 --long --icons --git'
    alias lta='lt -a'
else
    alias ls="ls --color -h"
fi

alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias eff='$EDITOR "$(ff)"'

# Custom cd function with zoxide
if command -v zoxide &>/dev/null; then
    alias cd="zd"
    zd() {
        if [ $# -eq 0 ]; then
            builtin cd ~ && return
        elif [ -d "$1" ]; then
            builtin cd "$1"
        else
            z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
        fi
    }
fi

# Navigation Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Tools
alias t='./.bin/init'
alias c='opencode'
n() { if [ "$#" -eq 0 ]; then command nvim .; else command nvim "$@"; fi; }

# File Operations
open() (
    xdg-open "$@" >/dev/null 2>&1 &
)

# Compression
compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
alias decompress="tar -xzf"

# Custom project aliases
alias artisan="./artisan"
alias rebase="./rebase"
alias deploy="./deploy"
alias cloc='cloc --vcs=git'
