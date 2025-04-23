#!/usr/bin/env zsh

echo "🛠  Starting Neovim setup for macOS..."

echo "📦 Installing dependencies..."
brew install neovim
brew install ripgrep     # for telescope grep
brew install fd          # for telescope find_files
brew install lazygit     # optional but handy in Neovim
brew install tree-sitter # for syntax parsing
brew install lua         # useful for Neovim config
brew install luarocks    # optional Lua package manager

# Optional: Neovim Python support
if command -v python3 >/dev/null 2>&1; then
    python3 -m pip install --user pynvim
else
    echo "⚠️  Python3 not found. Skipping pynvim install."
fi

# Optional: Neovim Node.js support (e.g., for LSPs)
if ! command -v node >/dev/null 2>&1; then
    echo "🌐 Installing Node.js..."
    brew install node
fi

npm install -g neovim

echo "🎉 Neovim and required tools installed!"
echo "👉 You can now launch Neovim with 'nvim'"
