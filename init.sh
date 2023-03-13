#!/bin/zsh

cur_dir=$(dirname $0)
cd cur_dir

cur_dir=$(pwd)

echo "[$(date)] init dotfiles"

backup() {
  mv $1 "$1.$(date -u -Iseconds).bak"
}

link() {
  echo "link $1 to $2"
  if [[ -e $2 ]]; then
    echo "file exists, make backup"
    backup $2
  elif [[ -L $2 ]]; then
    echo "link exists, rm it"
    rm $2
  fi

  ln -s $1 $2
}

link "$cur_dir/.tmux.conf" "$HOME/.tmux.conf"
link "$cur_dir/.zshrc" "$HOME/.zshrc"
link "$cur_dir/.zshenv" "$HOME/.zshenv"
link "$cur_dir/.editorconfig" "$HOME/.editorconfig"
link "$cur_dir/.vimrc" "$HOME/.vimrc"
