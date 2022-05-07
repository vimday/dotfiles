#!/bin/bash

rsync -u "$HOME/.tmux.conf" .
rsync -u "$HOME/.zshrc" .
rsync -u "$HOME/.zshenv" .
rsync -u "$HOME/.editorconfig" .

mkdir -p .config/lvim
rsync -u -r "$HOME/.config/lvim" .config

mkdir -p .config/nvim
rsync -u -r "$HOME/.config/nvim" .config
