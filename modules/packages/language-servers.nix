{pkgs,...}:
{
  home.packages = with pkgs; [
	#Language Servers
	dart-sass
    go
    lua
    lua-language-server
	python3
	pyright
	libgcc
    nil #Nix Language Server
    nodePackages.bash-language-server
    nodePackages_latest.typescript-language-server
    nodejs_21
    shellcheck#Bash LSP
    vscode-langservers-extracted #CSS/HTML/LESS
	];
}

