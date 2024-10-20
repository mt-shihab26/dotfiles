#!/usr/bin/env zsh

# Check if tmux is running
tmux_running=$(pgrep tmux)

if [[ -z $tmux_running ]]; then
    echo "tmux is not running. no sessions to kill."
    exit 0
fi

# Get list of tmux sessions
sessions=$(tmux list-sessions -F "#S")

if [[ -z $sessions ]]; then
    echo "no active tmux sessions found."
    exit 0
fi

# Use fzf to select a session
selected=$(echo "$sessions" | fzf)

if [[ -z $selected ]]; then
    echo "no session selected. exiting."
    exit 0
fi

# Kill the selected session
tmux kill-session -t "$selected"
echo "killed session: $selected"
