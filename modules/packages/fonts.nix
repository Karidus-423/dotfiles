{ pkgs, ...}:
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
  	(nerdfonts.override{fonts = ["Gohu" "Go-Mono"];})
  	(google-fonts.override{fonts = [
		"Libre Baskerville"
		"Baskervville SC"
		"Baskervville"
	];})
	monaspace
  ];

}

