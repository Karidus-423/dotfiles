{pkgs,...}:{
	programs.ranger = {
		enable = true;
		extraConfig = "
		set preview_images true
		";
	};
  home.packages = with pkgs; [
	  w3m
  ];
}
