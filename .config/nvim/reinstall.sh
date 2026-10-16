#!/usr/bin/env bash

# Reinstall Neovim from scratch: deletes all of nvim's state and data (history, undo, logs, plugins,
# treesitter parsers, mason tools), then installs every plugin again at the revision pinned in
# nvim-pack-lock.json and builds telescope-fzf-native. Your config (~/.config/nvim) is not touched.
# Treesitter parsers and mason tools are downloaded again the next time nvim starts.

set -e

state=${XDG_STATE_HOME:-$HOME/.local/state}/nvim
data=${XDG_DATA_HOME:-$HOME/.local/share}/nvim

# ~/.local/state/nvim: shada/ (command and search history, marks, registers), undo/ and swap/
# files, netrw/ history, and the logs (nvim.log, lsp.log, luasnip.log)
rm -rf "$state"
# ~/.local/share/nvim: site/pack/ (every vim.pack plugin), site/parser/, site/parser-info/ and
# site/queries/ (treesitter parsers and their queries), and mason/ (installed servers and tools)
rm -rf "$data"

# On the first vim.pack.add() vim.pack installs every plugin of the lockfile in one blocking step
# and gives up after 120s, so a fresh start fails with a timeout. Install them here instead, at the
# locked revisions, the same way vim.pack does.
lock="$(dirname "$(realpath "$0")")/nvim-pack-lock.json"
export dir=$data/site/pack/core/opt
mkdir -p "$dir"

install() {
    local path=$dir/$1
    git clone --quiet --no-checkout --filter=blob:none "$2" "$path"
    git -C "$path" checkout --quiet "$3"
    git -C "$path" submodule --quiet update --init --recursive --filter=blob:none
    echo "Installed $1"
}
export -f install

jq -r '.plugins | to_entries[] | "\(.key) \(.value.src) \(.value.rev)"' "$lock" |
    xargs -P 8 -n 3 bash -c 'install "$@"' _

# the PackChanged hook in plugins/telescope.lua doesn't run for plugins installed here
if command -v make >/dev/null; then
    make -C "$dir/telescope-fzf-native.nvim" >/dev/null
fi
