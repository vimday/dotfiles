# User configuration

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "spwhitt/nix-zsh-completions"
zplug "paulirish/git-open"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
# zplug "jeffreytse/zsh-vi-mode"

# Then, source plugins and add commands to $PATH
zplug load

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -z $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# alias
alias x=xplr
alias rm=trash
alias v=nvim
alias nv='neovide'
alias sed=gsed
alias proxy-enable='export https_proxy=http://127.0.0.1:7890;export http_proxy=http://127.0.0.1:7890;export all_proxy=socks5://127.0.0.1:7890'
alias proxy-disable='unset https_proxy http_proxy all_proxy'

# --------------- APPs ----------------

[ -f ~/.my.env ] && source ~/.my.env

# vi-mode
# VI_MODE_SET_CURSOR=true

# zk
export ZK_NOTEBOOK_DIR=~/notes

# todo.sh
export TODOTXT_DEFAULT_ACTION=ls
alias t='todo.sh -d ~/.todo.cfg'

# mcfly: sub <C-r> search history
eval "$(mcfly init zsh)"
export MCFLY_RESULTS=50

# starship prompt
source <(/usr/local/bin/starship init zsh --print-full-init)

# ===== homebrew ====
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
