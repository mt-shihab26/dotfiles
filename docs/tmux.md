# Tmux

## Commands

-   `$ init` -> create or attach to default 'init' tmux session
-   `$ sessionizer <session name>` -> create or attach to fuzzy-found projects or specified session
-   `$ sp` -> fuzzy-find project directories, then create or attach tmux session
-   `$ sl` -> fuzzy-find learning-related projects directories, then create or attach tmux session
-   `$ tkill` -> Fuzzy-find active tmux sessions, then kill selected session

## Keymaps

-   prefix
    -   `<c-space>` -> prefix key
-   windows
    -   `<prefix-c>` -> create window
    -   `<prefix-&` -> kill window
    -   `<prefix-'window number'>` -> switch specific window
    -   `<prefix-p`, `<shift-left`, `shift+alt+h` -> switch to previous-window
    -   `<prefix-n`, `<shift-right`, `shift+alt+l` -> switch to next-window
-   panes
    -   `<prefix-%>` -> split pane horizontally
    -   `<prefix-">` -> split pane vertically
    -   `<prefix-arrow>`, `<c-h>`, `<c-j>`, `<c-k>`, `<c-l>` -> navigate panes
    -   `<prefix-q>` -> toggle panes number
    -   `<prefix-{>`, `<prefix-}>` -> swap panes
    -   `<prefix-z>` -> pane take up full window
    -   `<prefix-z>` -> toggle pane take up full window
    -   `<prefix-!>` -> make pane into window
    -   `<prefix-x>` -> close a pane
-   yank
    -   `<prefix-[>`: enter copy mode,
    -   inside copy mod
        -   `v`: start selection
        -   `C-v`: toggle rectangle
        -   `y`: yank and exit copy mode
-   plugins
    -   `<prefix-I>` -> install tpm plugins
