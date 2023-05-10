# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/hrli/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="refined"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  history
  vi-mode
  # emoji
  git
  gitignore
  safe-paste
  colored-man-pages
  autojump
  tmux
  rust
  nvm
  fancy-ctrl-z
  # command-not-found
)

# custom completion
fpath+=~/.zfunc

source $ZSH/oh-my-zsh.sh

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

# perl
export PATH="$PATH:/usr/local/Cellar/perl/5.34.0/bin/"

# freewheel
export GO111MODULE=on
export GOPROXY=https://arti.freewheel.tv/api/go/go
export GOSUMDB=off

# display when login
if [[ -e ~/Script/hello.sh ]]; then
  source ~/Script/hello.sh | fsays -w 90
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
    . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
  else
    export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
  fi
fi
unset __conda_setup
# <<< conda initialize <<<

# export GOPATH=/Users/hrli/workspace/common/src/go # freewheel workspace
# export PATH="$GOPATH/bin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"

# ===== set g environment variables =====
# export GOROOT="${HOME}/.g/go"
# export PATH="${HOME}/bin:${HOME}/.g/go/bin:$PATH"
# export G_MIRROR=https://golang.google.cn/dl/
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin" unalias g

# ===== homebrew ====
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"

export GOPATH="$HOME/go/1.20.1"; export GOROOT="$HOME/.goenv/versions/1.20.1"; export PATH="$GOPATH/bin:$PATH"; # g-install: do NOT edit, see https://github.com/stefanmaric/g

export PATH=~/Github/my-busybox:$PATH
