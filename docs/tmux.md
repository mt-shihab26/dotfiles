# Tmux

## Installation

-   `$ brew install tmux` -> install tmux using homebrew
-   `$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm` -> clone tmux plugin manager (tpm)
-   `$ ~/.tmux/plugins/tpm/bin/install_plugins` -> tnstall tmux plugins

## Commands

-   `$ t-init` -> create or attach to default 'init' tmux session
-   `$ t-sessionizer <session name>` -> create or attach to fuzzy-found projects or specified session
-   `$ t-p` -> fuzzy-find project directories, then create or attach tmux session
-   `$ t-l` -> fuzzy-find learning-related projects directories, then create or attach tmux session
-   `$ t-k` -> Fuzzy-find active tmux sessions, then kill selected session
