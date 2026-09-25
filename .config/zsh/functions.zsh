if [[ -d "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/fns" ]]; then
    for func_file in "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/fns/*.zsh; do
        [[ -f "$func_file" ]] && source "$func_file"
    done
    unset func_file
fi
