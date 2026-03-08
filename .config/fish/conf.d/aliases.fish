# Open 
function open
    xdg-open $argv >/dev/null 2>&1 &
end

# Tools
alias t='./.bin/init'
alias c='opencode'
alias n='nvim'

# Simplify
alias tree='tree --gitignore'
alias cloc='cloc --vcs=git'

# Projects
alias artisan='./artisan'
alias rebase='./rebase'
alias preview='./preview'
alias deploy='./deploy'

