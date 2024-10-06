#!/bin/zsh

cur_dir=$(pwd)

echo "[$(date)] init dotfiles"

backup() {
  mv $1 "$1.$(date -u -Iseconds).bak"
}

link() {
  echo "link $1 to $2"
  if [[ -e $2 ]]; then
    echo "$2 exists, skip"
    # backup $2
  elif [[ -L $2 ]]; then
    echo "$2 link exists, skip"
    # rm $2
  else
    ln -s $1 $2
    echo "linked"
  fi
}

link2dot_config() {
  frm="$cur_dir/$1"
  name=$(basename $frm)
  link $frm "$HOME/.config/$name"
}

link2home() {
  frm="$cur_dir/$1"
  name=$(basename $frm)
  link $frm "$HOME/$name"
}

# link for HOME
link2homes=(
  .tmux.conf
  .editorconfig
  .vimrc
  .gitconfig
  .todo.cfg
  .condarc
  .Xmodmap
)

for file in $link2homes; do
  link2home $file
done

if [[ ! -d "$HOME/.config" ]]; then
  mkdir "$HOME/.config"
fi

# link for .config
link2dot_configs=(
  starship.toml
  zellij
  i3/i3
  i3/i3blocks
  picom.conf
)

for file in $link2dot_configs; do
  link2dot_config $file
done

# special links
link "$cur_dir/awesomewm" "$HOME/.config/awesome"
link "$cur_dir/nvchad/lua" "$HOME/.config/nvim/lua"
