{...}:{
    imports = [
	# Packages Settings
	../../modules/home-manager/hypr_temp.nix
	../../modules/home-manager/tmux.nix
    ../../modules/home-manager/sh.nix
    ../../modules/home-manager/alacritty.nix
    ../../modules/home-manager/foot.nix
    ../../modules/home-manager/fzf.nix
    ../../modules/home-manager/wofi/wofi.nix
	../../modules/home-manager/starship.nix
	../../modules/home-manager/lf/lf.nix
	../../modules/home-manager/zathura.nix
	../../modules/home-manager/spicetify.nix
	../../modules/home-manager/cava.nix

	# Packages Groups
	../../modules/packages/system-utils.nix
	../../modules/packages/tui-apps.nix
	../../modules/packages/gui-apps.nix
	../../modules/packages/command-line-tools.nix
	../../modules/packages/language-servers.nix
	../../modules/packages/fonts.nix
    ];
}
