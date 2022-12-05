#!/bin/zsh

echo "[$(date)] sync dotfiles"

rsync -u "$HOME/.tmux.conf" .
rsync -u "$HOME/.zshrc" .
rsync -u "$HOME/.zshenv" .
rsync -u "$HOME/.editorconfig" .
rsync -u "$HOME/.vimrc" .

rsync -u -r "$HOME/.config/lvim/config.lua" ./lvim/
rsync -u -r "$HOME/.config/nvim/lua/custom" ./nvchad/

brew bundle dump
