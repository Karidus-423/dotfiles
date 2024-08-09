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
	aseprite
	audacious
	audacity
	obsidian
	pandoc
	playerctl
	dart-sass
	xdg-utils
    bat
    calibre
    cargo
    cava
	httrack
    clang-tools #C/C++
    dart-sass
    discord
	figma-linux
	hplip
	rar
    fd
	whatsapp-for-linux
    fzf
    gimp
    go
    godot_4
    grim
    gtk3
    htop
    hyprpicker
    just
    krita
    libgcc
    libreoffice
    lua
    lua-language-server
    neofetch
    nil #Nix Language Server
    nodePackages.bash-language-server
    nodePackages_latest.typescript-language-server
    nodejs_21
    notify
    pcmanfm
    ripgrep
	thunderbird
    rocmPackages.llvm.clang
    rustc
    shellcheck
    slurp
    spotify
    swappy
    swww
    tmux
    unzip
    vscode-langservers-extracted #CSS/HTML/LESS
    watchexec
    wev
    wofi
    xwaylandvideobridge
    zoxide
  ];
}
