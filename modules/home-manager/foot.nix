{config,lib,pkgs,...}:
let

inherit (lib) mkOption types;

in
{
	config = {
	programs.foot = {
		enable = true;
		server.enable = false;
		package = pkgs.foot;
		settings = {
			main = {
				term = "screen-256color";
				font = config.footFontProps;
				dpi-aware = "yes";
				initial-window-size-pixels=config.footWindowDimensions;
				pad = "25x15";
			};

			mouse = {
				hide-when-typing = "yes";
			};

			key-bindings = {
				clipboard-paste="Control+v XF86Paste";
				clipboard-copy="Control+c XF86Copy";
			};
			
			colors = with config.colorScheme.palette;{
				alpha = 0.9;
				background = "${base01}";
				foreground = "cccccc";

				## Normal/regular colors (color palette 0-7)
				regular0="${base00}"; #black
				regular1="${base08}"; #red
				regular2="${base0B}"; #green
				regular3="${base0A}"; #yellow
				regular4="${base0D}"; #blue
				regular5="${base0E}"; #magenta
				regular6="${base0C}"; #cyan
				regular7="${base07}"; #white

				## Bright colors (color palette 8-15)
				bright0="616161";   # bright black
				bright1="ff4d51";   # bright red
				bright2="35d450";   # bright green
				bright3="e9e836";   # bright yellow
				bright4="5dc5f8";   # bright blue
				bright5="feabf2";   # bright magenta
				bright6="24dfc4";   # bright cyan
				bright7="ffffff";   # bright white

				## dimmed colors (see foot.ini(5) man page)
				#dim0=<not set>;
				# ...
				#dim7=<not-set>;
			};
		};
	};
	};

	options = {
		footFontProps = mkOption{
			type = types.str;
			default = "GoMono Nerd Font:size=13";
			example = "GoMono Nerd Font:size=15";
		};
		footWindowDimensions = mkOption{
			type = types.str;
			default = "500x500";
			example = "WxH";
		};
	};
}
