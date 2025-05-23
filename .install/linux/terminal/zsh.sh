sudo apt update

sudo apt install zsh golang zoxide fzf ripgrep bat eza plocate apache2-utils fd-find tldr -y

go install github.com/junegunn/fzf@latest

chsh -s "$(which zsh)"
