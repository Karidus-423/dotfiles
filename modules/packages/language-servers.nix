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
	glslls
	zls
	clang-tools
	ocaml
	ocamlPackages.ocaml-lsp
    nil #Nix Language Server
    nodePackages.bash-language-server
    nodePackages_latest.typescript-language-server
	nodejs
    shellcheck#Bash LSP
	vscode-langservers-extracted #CSS/HTML/LESS
	tree-sitter
	];
}

