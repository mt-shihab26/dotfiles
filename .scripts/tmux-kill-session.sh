#!/usr/bin/env zsh

# Check if tmux is running
tmux_running=$(pgrep tmux)

if [[ -z $tmux_running ]]; then
    echo "Tmux is not running. No sessions to kill."
    exit 0
fi

# Get list of tmux sessions
sessions=$(tmux list-sessions -F "#S")

if [[ -z $sessions ]]; then
    echo "No active tmux sessions found."
    exit 0
fi

# Use fzf to select a session
selected=$(echo "$sessions" | fzf --prompt="Select session to kill: " --header="Active Tmux Sessions")

if [[ -z $selected ]]; then
    echo "No session selected. Exiting."
    exit 0
fi

# Kill the selected session
tmux kill-session -t "$selected"
echo "Killed session: $selected"
