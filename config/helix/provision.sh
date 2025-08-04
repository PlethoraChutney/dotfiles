#!/bin/zsh
set -e

if (( $+commands[brew] )); then
  brew install helix
  brew install ruff
  brew install markman
else
  echo "Manually install helix"
  python -m pip install --upgrade pipx
  pipx install ruff jedi-language-server
fi
npm install -g bash-language-server
npm install -g @olrtg/emmet-language-server
npm install -g typescript typescript-language-server
npm install -g vscode-langservers-extracted
cargo install --git https://github.com/estin/simple-completion-language-server.git
cargo install codebook-lsp

