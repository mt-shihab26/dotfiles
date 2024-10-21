# Tmux

## Commands

-   `$ t-init` -> create or attach to default 'init' tmux session
-   `$ t-sessionizer <session name>` -> create or attach to fuzzy-found projects or specified session
-   `$ t-p` -> fuzzy-find project directories, then create or attach tmux session
-   `$ t-l` -> fuzzy-find learning-related projects directories, then create or attach tmux session
-   `$ t-k` -> Fuzzy-find active tmux sessions, then kill selected session

## Keymaps

-   prefix
    -   `<c-b>` -> prefix key
-   plugins
    -   `<prefix-I>` -> install tpm plugins
-   navigation (also work inside neovim)
    -   `<c-h>` -> navigate to left window
    -   `<c-j>` -> navigate to window below
    -   `<c-k>` -> navigate to window above
    -   `<c-l>` -> navigate to right window
