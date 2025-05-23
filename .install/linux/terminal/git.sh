sudo apt install git -y

# Set common git aliases
git config --global pull.rebase true

# Set identification from install inputs
git config --global user.name "Shihab Mahamud"
git config --global user.email "shihab4t@gmail.com"

command_to_check="gh"

if ! command -v "$command_to_check" &> /dev/null; then
  echo "The command '$command_to_check' does not exist."
  echo "Installing '$command_to_check' browser"

  # install gh
  (type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
        && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y
else
  echo "The command '$command_to_check' exists."
fi

# login to github cli
gh auth login

