#!/bin/bash

set -e

# zsh: https://www.zsh.org/ https://archlinux.org/packages/extra/x86_64/zsh/
# fzf: https://github.com/junegunn/fzf https://archlinux.org/packages/extra/x86_64/fzf/
# zoxide: https://github.com/ajeetdsouza/zoxide https://archlinux.org/packages/extra/x86_64/zoxide/
omarchy pkg add zsh fzf zoxide

chsh -s "$(which zsh)"

echo -e "\nInstallation complete. Please restart your terminal or log out and back in to start using Zsh."
