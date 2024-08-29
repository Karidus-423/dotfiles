{pkgs, ...}:{
	programs.lf = {
		enable = true;
		commands = {
			dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
		};
		settings = {
			preview = true;
			hidden = true;
		};
	};
}
