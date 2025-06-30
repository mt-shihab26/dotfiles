#!/usr/bin/env zsh

if [[ $1 == "projects" ]]; then
    selected=$(find ~/projects -mindepth 1 -maxdepth 1 -type d | fzf)
elif [[ $1 == "learns" ]]; then
    selected=$(find ~/learns/courses/ ~/learns/crash_courses/ ~/learns/imaginative_research/ ~/learns/projects/ ~/learns/manual/ ~/learns/dsa_library/ \
        -mindepth 1 -maxdepth 1 -type d \
        -not -path "*/.git*" | fzf)
elif [[ $# -eq 1 ]]; then
    selected=$1
else
    echo "Invalid argument. Usage: $0 [directory|learns|projects]"
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
