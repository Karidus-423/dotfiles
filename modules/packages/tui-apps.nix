{pkgs,...}:
{
  home.packages = with pkgs; [
	#TUI Apps
	cava
	lf
	btop
	gp-saml-gui
	];
}
