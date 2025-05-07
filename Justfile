init:
    @./init.sh

restore-home-nix:
    #!/bin/bash
    if [ ! -f ~/.cache/hm-current-config.nix ]; then
        echo "No current config found. Please run home-manager switch first."
        exit 1
    fi
    if [ -f ./home-manager/home.nix ]; then
        echo "home.nix already exists. Please remove it first."
        exit 1
    fi
    cat ~/.cache/hm-current-config.nix > ./home-manager/home.nix
