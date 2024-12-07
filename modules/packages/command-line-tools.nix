{pkgs,...}:
{
  home.packages = with pkgs; [
	#Command Line Tools
	android-tools
	tree
	bat
	tlrc
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
	gpclient
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
	qemu_kvm
  ];
}

