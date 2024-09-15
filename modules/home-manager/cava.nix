{pkgs,...}:
{
	programs.cava = {
		enable = true;
		package = pkgs.cava;
		settings = {
			general = {
				framerate = 165;
			};
			colors = {
				background = "#cccccc";
				foreground = "#b8aeff";
			};
		};
	};
}
