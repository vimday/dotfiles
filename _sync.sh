#!/bin/bash

rsync -u "$HOME/.tmux.conf" .
rsync -u "$HOME/.zshrc" .
rsync -u "$HOME/.zshenv" .
rsync -u "$HOME/.editorconfig" .

mkdir -p .config/lvim
rsync -u -r "$HOME/.config/lvim/config.lua" ./lvim/
rsync -u -r "$HOME/.config/nvim/lua/custom" ./nvchad/
