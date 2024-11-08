{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "hrli";
  home.homeDirectory = "/home/hrli";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.zsh
    pkgs.curl
    pkgs.git
    pkgs.htop
    pkgs.mcfly
    pkgs.neovim
    pkgs.podlet
    pkgs.python3
    pkgs.starship
    pkgs.todo-txt-cli
    pkgs.trash-cli
    pkgs.zoxide
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    pkgs.lazygit
    pkgs.lazydocker
    pkgs.fzf
    pkgs.ripgrep
    pkgs.fd
    pkgs.tmux
    pkgs.nodejs_20
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".editorconfig".source = ~/.config/home-manager/d/.editorconfig;
    ".condarc".source = ~/.config/home-manager/d/.condarc;
    ".gitconfig".source = ~/.config/home-manager/d/.gitconfig;
    ".tmux.conf".source = ~/.config/home-manager/d/.tmux.conf;
    ".todo.cfg".source = ~/.config/home-manager/d/.todo.cfg;
    ".vimrc".source = ~/.config/home-manager/d/.vimrc;
    ".config/containers".source = ~/.config/home-manager/d/containers;
    ".config/picom.conf".source = ~/.config/home-manager/d/picom.conf;
    ".config/starship.toml".source = ~/.config/home-manager/d/starship.toml;
    ".config/kitty/kitty.conf".source = ~/.config/home-manager/d/kitty.conf;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/hrli/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
    };
    shellAliases = {
      v = "nvim";
      j = "z";
      t = "todo.sh";
      rm = "trash";
      code = "flatpak run com.visualstudio.code ";
      lazypodman = "DOCKER_HOST=unix:///run/user/1000/podman/podman.sock lazydocker";
    };
    syntaxHighlighting = {
      enable = true;
    };
    defaultKeymap = "emacs";
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "fancy-ctrl-z"
      ];
    };
    initExtraBeforeCompInit = ''
      todo.sh list
    '';
    initExtra = ''
      eval "$(/home/hrli/miniconda3/bin/conda shell.zsh hook)"
    '';
    # initExtraFirst = '' '';
    envExtra = ''
      . $HOME/.cargo/env
      export PATH=$HOME/.local/bin:$HOME/repos/my-busybox/bin:$PATH
    '';
  };
  programs.mcfly = {
    enable = true;
  };
  programs.starship = {
    enable = true;
  };
  programs.zoxide = {
    enable = true;
  };
}
