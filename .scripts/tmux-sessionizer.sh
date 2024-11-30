#!/usr/bin/env zsh

if [[ $1 == "project" ]]; then
    selected=$(find ~/Code ~/Code/paystubhero -mindepth 1 -maxdepth 1 -type d | fzf)
elif [[ $1 == "learn" ]]; then
    selected=$(find ~/Code/courses/ ~/Code/crash_courses/ ~/Code/imaginative_research/ ~/Code/projects/ ~/Code/manual/ -mindepth 1 -maxdepth 2 -type d | fzf)
elif [[ $# -eq 1 ]]; then
    selected=$1
else
    echo "Invalid argument. Usage: $0 [directory|learn|project]"
    exit 1
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2>/dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name
