# File System
if command -v eza &>/dev/null; then
    alias ls='eza -lh --group-directories-first --icons=auto'
    alias lsa='ls -a'
    alias lt='eza --tree --level=2 --long --icons --git'
    alias lta='lt -a'
else
    alias ls="ls --color -h"
fi

if [[ "$TERM" == "xterm-kitty" ]]; then
    alias ff="fzf --preview 'case \$(file --mime-type -b {}) in image/*) kitty icat --clear --transfer-mode=memory --stdin=no --place=\${FZF_PREVIEW_COLUMNS}x\${FZF_PREVIEW_LINES}@0x0 {} ;; *) bat --style=numbers --color=always {} ;; esac'"
else
    alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
fi
alias eff='$EDITOR "$(ff)"'
sff() {
    if [ $# -eq 0 ]; then
        echo "Usage: sff <destination> (e.g. sff host:/tmp/)"
        return 1
    fi
    local file
    file=$(find . -type f -printf '%T@\t%p\n' | sort -rn | cut -f2- | ff) && [ -n "$file" ] && scp "$file" "$1"
}

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

# Git
alias g='git'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'

# Custom

# Tools
alias t='./.bin/init'
alias n='nvim'
alias r='run'

# Coding Agent
alias co='opencode'
alias cox='opencode --auto'
alias ca='claude'
alias cax='claude --dangerously-skip-permissions'
alias cx='codex'
alias cxx='codex -s danger-full-access -a never'
alias cg="copilot"
alias cgx="copilot --allow-all"

# Tools with options
alias artisan="php artisan"
alias tree='tree --gitignore'
alias cloc='cloc --vcs=git'

# Projects scripts
_run_script() {
    local s="$1"
    [[ -f "./$s" ]] && "./$s" || "./${s}.sh"
}

build() { _run_script build; }
rebase() { _run_script rebase; }
deploy() { _run_script deploy; }
preview() { _run_script preview; }
