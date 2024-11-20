{pkgs,...}:
{
  home.packages = with pkgs; [
	#Command Line Tools
	android-tools
	bat
	cargo
	gdb
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
	zip
	gowall
	unzip
	unrar
	watchexec
	wev
	unzip
	zoxide
	pcsx2
  ];
}

