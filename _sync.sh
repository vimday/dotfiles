#!/bin/zsh

echo "[$(date)] sync dotfiles"

rsync -u "$HOME/.tmux.conf" .
rsync -u "$HOME/.zshrc" .
rsync -u "$HOME/.zshenv" .
rsync -u "$HOME/.editorconfig" .
rsync -u "$HOME/.vimrc" .
