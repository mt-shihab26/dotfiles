command_to_check="google-chrome"

if ! command -v "$command_to_check" &> /dev/null; then
  echo "The command '$command_to_check' does not exist."
  echo "Installing '$command_to_check' browser"
  
  # Browse the web with the most popular browser. See https://www.google.com/chrome/
  cd /tmp
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo apt install -y ./google-chrome-stable_current_amd64.deb
  rm google-chrome-stable_current_amd64.deb
  cd -
else
  echo "The command '$command_to_check' exists."
fi

