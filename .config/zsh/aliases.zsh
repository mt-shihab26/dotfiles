# File System
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

open() (
    xdg-open "$@" >/dev/null 2>&1 &
)

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Tools
alias t='./.bin/init'
alias n="nvim"
alias co='opencode'
alias ca='claude'
alias cx='claude --allow-dangerously-skip-permissions'

# Projects
alias artisan="php artisan"

alias build="./build"
alias rebase="./rebase"
alias deploy="./deploy"
alias preview="./preview"

alias tree='tree --gitignore'
alias cloc='cloc --vcs=git'
