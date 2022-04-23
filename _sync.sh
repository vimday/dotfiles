#!/bin/bash

cp "$HOME/.tmux.conf" .
cp "$HOME/.zshrc" .
cp "$HOME/.zshenv" .
cp "$HOME/.editorconfig" .

mkdir -p .config/lvim
cp -r "$HOME/.config/lvim" .config

mkdir -p .config/nvim
cp -r "$HOME/.config/nvim" .config
