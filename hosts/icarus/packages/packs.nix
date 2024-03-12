{pkgs,...}:
{
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
    wev
    nodejs_21
    grim
    slurp
    swappy
    wf-recorder
  ];
}
