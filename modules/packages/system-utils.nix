{pkgs,...}:
{
  home.packages = with pkgs; [
		#System Utils
		gtk3
		man-pages
		playerctl
		xdg-utils
		xwaylandvideobridge
		wl-clipboard
	];
}

