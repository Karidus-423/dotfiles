{pkgs,...}:
{
  home.packages = with pkgs; [
	#TUI Apps
	cava
	lazygit
	btop
	gp-saml-gui
	];
}
