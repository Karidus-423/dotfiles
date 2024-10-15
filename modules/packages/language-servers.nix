{pkgs,...}:
{
  home.packages = with pkgs; [
	#Language Servers
	dart-sass
    go
	gopls
	gotools
    lua
    lua-language-server
	zig
	zls
    nil #Nix Language Server
	libgcc
    nodePackages.bash-language-server
    nodePackages_latest.typescript-language-server
	nodejs
    shellcheck#Bash LSP
	vscode-langservers-extracted #CSS/HTML/LESS
	tree-sitter
	];
}

