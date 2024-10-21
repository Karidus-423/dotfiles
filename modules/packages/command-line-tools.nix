{pkgs,...}:
{
  home.packages = with pkgs; [
	#Command Line Tools
	bat
	cargo
	fzf
	fd	
	grim
	hyprpicker
	just
	neofetch
	notify
	ripgrep
	pandoc
	slurp
	swappy
	jq
	glslviewer
	swww
	tmux
	unzip
	unrar
	watchexec
	wev
	unzip
	zoxide
  ];
}

