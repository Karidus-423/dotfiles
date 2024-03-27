{pkgs,...}:
{
  home.packages = with pkgs; [
    # Package override for fine tuning
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # Shell script name 
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    #------------------------#
    #--Language Servers------#
    bat
    calcure
    cargo
    cava
    clang-tools #C/C++
    discord
    fzf
    go
    godot_4
    grim
    gtk3
    htop
    hyprpicker
    just
    aseprite
    calibre
    mailspring
    libgcc
    libreoffice
    lua
    lua-language-server
    neofetch
    nil #Nix
    nodePackages.bash-language-server
    nodePackages_latest.typescript-language-server
    nodejs_21
    notify
    oh-my-posh
    python3
    ranger
    ripgrep
    rocmPackages.llvm.clang
    rustc
    shellcheck
    slurp
    spotify
    swappy
    vscode-langservers-extracted #CSS/HTML/LESS
    swww
    tmux
    unzip
    xwaylandvideobridge
    gimp
    krita
    pcmanfm
    watchexec
    waybar
    wev
    wofi
    zathura
    zoxide
  ];
}
