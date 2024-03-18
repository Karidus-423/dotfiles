{pkgs,...}:
{
  home.packages = with pkgs; [
    # Package override for fine tuning
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # Shell script name 
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    bat
    calcure
    cargo
    cava
    clang-tools #C/C++
    discord
    fzf
    go
    godot_4
    #--Language Servers------#
    #------------------------#
    gotop
    grim
    gtk3
    htop
    hyprpicker
    libreoffice
    imagemagick
    just
    libgcc
    lua
    lua-language-server
    neofetch
    nil #Nix
    nodejs_21
    obs-studio
    oh-my-posh
    oh-my-zsh
    python3
    ranger
    ripgrep
    rocmPackages.llvm.clang
    figma-linux
    neomutt
    rustc
    nodePackages_latest.typescript-language-server
    slurp
    spotify
    notify
    steam-run
    swappy
    swww
    tmux
    unzip
    watchexec
    waybar
    wev
    wf-recorder
    wofi
    zathura
    zoxide
  ];
}
