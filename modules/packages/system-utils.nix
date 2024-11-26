{pkgs,...}:
{
  home.packages = with pkgs; [
		#System Utils
		gtk3
		playerctl
		xdg-utils
		xwaylandvideobridge
		wl-clipboard
		man-pages
	];
}

