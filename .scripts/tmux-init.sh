#!/usr/bin/env zsh

# Check if a tmux session named "init" exists
if tmux has-session -t init 2>/dev/null; then
    # If it exists, attach to the session
    tmux attach-session -t init
else
    # If it doesn't exist, create a new session named "init"
    tmux new-session -s init
fi
