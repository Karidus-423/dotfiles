{ config, pkgs, ... }:

{
  imports = [
    ./modules-home.nix
  ];
  home.username = "kapud";
  home.homeDirectory = "/home/kapud";
  nixpkgs.config.allowUnfreePredicate = _: true;
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11";
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Package override for fine tuning
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # Shell script name 
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    fzf
    bat
    htop
    gotop
    waybar
    swww
    ranger
    wofi
    oh-my-zsh
    oh-my-posh
    tmux
    spotify
    neofetch
    godot_4
    discord
    cava
    zathura
    rustc
    libgcc
    python3
    lua
    go
    cargo
    ripgrep
    nodejs_21
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

      };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kapud/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  services.gpg-agent = {
   enable = true;
   defaultCacheTtl = 1800;
   enableSshSupport = true;
  };

}
