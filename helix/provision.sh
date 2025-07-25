#!/bin/zsh
set -e

if (( $+commands[brew] )); then
  brew install helix ruff
else
  echo "Manually install helix"
  mamba activate base
  mamba install ruff
  ln -s $(command -v ruff) ~/.local/bin/
done
npm install -g bash-language-server
npm install -g @olrtg/emmet-language-server
cargo install --git https://github.com/estin/simple-completion-language-server.git

