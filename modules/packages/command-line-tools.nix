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
	swww
	tmux
	unzip
	libclang
	watchexec
	wev
	unzip
	zoxide
  ];
}

