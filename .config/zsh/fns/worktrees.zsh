# Create a new worktree and branch from within current git directory.
ga() {
    if [[ -z "$1" ]]; then
        echo "Usage: ga [branch name]"
        return 1
    fi

    local branch="$1"
    local base="$(basename "$PWD")"
    # slashes in the branch (feat/x) would nest the worktree a level deeper
    local dir="../${base}--${branch//\//-}"

    git worktree add -b "$branch" "$dir"
    mise trust "$dir"
    cd "$dir"
}

# Remove worktree and branch from within active worktree directory.
gd() {
    if gum confirm "Remove worktree and branch?"; then
        local cwd branch main

        cwd="$(git rev-parse --show-toplevel)" || return 1
        # read the branch from git, the directory name has slashes replaced
        branch="$(git branch --show-current)"
        # the first entry of `git worktree list` is always the main worktree
        main="$(git worktree list --porcelain | sed -n '1s/^worktree //p')"

        # Protect against accidentally nuking the main worktree or a non-ga directory
        if [[ "$(basename "$cwd")" == *--* && -n "$branch" && -n "$main" && "$main" != "$cwd" ]]; then
            cd "$main"
            git worktree remove "$cwd" --force || return 1
            git branch -D "$branch"
        fi
    fi
}
