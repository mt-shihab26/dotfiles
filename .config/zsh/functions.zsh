if [[ -d "$XDG_CONFIG_HOME/zsh/fns" ]]; then
    for func_file in "$XDG_CONFIG_HOME"/zsh/fns/*.zsh; do
        [[ -f "$func_file" ]] && source "$func_file"
    done
    unset func_file
fi
