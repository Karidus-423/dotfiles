{ config, pkgs, ... }:

{
  programs.alacritty = {
  enable = true;
  settings = {
  font = {
	normal.family = "GohuFont 11 Nerd Font";
	bold.family = "GohuFont 14 Nerd Font";
	italic.family = "GohuFont 11 Nerd Font";
	bold_italic.family = "GohuFont 14 Nerd Font";
	size = 15;
	builtin_box_drawing = true;
    };
  window = {
	  decorations = "None";
	  opacity = 0.64;
	  padding = {
		  x = 20;
		  y = 30;
	  };
  };
  shell = {
	  program = "${pkgs.zsh}/bin/zsh";
	  args = ["--interactive"];
  };
  colors = {
	  primary = {
		  background = "#4b4b4b";
	  };
	  normal = {
		  black = "#0F0D0D";
		  red = "#945050";
		  green = "#819E69";
		  yellow = "#B4A71D";
		  blue = "#527FB5";
		  magenta = "#B489C2";
		  cyan = "#75BCBD";
		  white = "#CCCCCC";
	  };
	  bright = {
		  black = "#333333";
		  red = "#BA6D6D";
		  green = "#B2D498";
		  yellow = "#DBCF47";
		  blue = "#70AFFC";
		  magenta = "#D4AEE0";
		  cyan = "#C2EFF0";
		  white = "#F2F2F2";
	  };
  };
  selection = {
	  save_to_clipboard = true;
  };
  mouse = {
	  hide_when_typing = true;
  };
  cursor = {
	  vi_mode_style = {
		  shape="Block";
		  blinking="On";
	  };
  };
  keyboard.bindings = [
  {
	  key = "C";
	  mods = "Control";
	  action = "Copy";
  }
  {
	  key = "V";
	  mods = "Control";
	  action = "Paste";
  }
  ];
  terminal = {
	  osc52 = "CopyPaste";
  };
  };




  };
}