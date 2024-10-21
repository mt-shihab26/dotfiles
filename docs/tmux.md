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
    -   `<prefix-c` -> create new window
    -   `<shift-left`, `shift+alt+h` -> switch to previous-window
    -   `<shift-right`, `shift+alt+l` -> switch to next-window
-   yank
    -   `<prefix-[>`: enter copy mode,
    -   inside copy mod
        -   `v`: start selection
        -   `C-v`: toggle rectangle
        -   `y`: yank and exit copy mode
-   navigation (also work inside neovim)
    -   `<c-h>` -> navigate to left window
    -   `<c-j>` -> navigate to window below
    -   `<c-k>` -> navigate to window above
    -   `<c-l>` -> navigate to right window
-   plugins
    -   `<prefix-I>` -> install tpm plugins
