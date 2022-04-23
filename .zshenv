. "$HOME/.cargo/env"

export PATH="$HOME/.local/bin/:$PATH"

export GO111MODULE=on
export GOPROXY=https://arti.freewheel.tv/api/go/go
export GOSUMDB=off

export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

