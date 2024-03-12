{ config, pkgs, ...}:
let
   stylePath = pkgs.writeTextFile {
   	name = "style.css";
	text = builtins.readFile ./style.css;
   };
in
{
programs.wofi = {
	enable = true;
	settings ={
		style = stylePath;
		show = "drun";
		width = 500;
		height = 400;
		always_parse_args = true;
		show_all = false;
		print_command = true;
		layer = "overlay";
		insensitive = true;
		allow_images = false;
	};
};
}
