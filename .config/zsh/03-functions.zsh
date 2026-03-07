if [[ -d "$XDG_CONFIG_HOME/zsh/functions" ]]; then
    for func_file in "$XDG_CONFIG_HOME"/zsh/functions/*.zsh; do
        [[ -f "$func_file" ]] && source "$func_file"
    done
    unset func_file
fi
