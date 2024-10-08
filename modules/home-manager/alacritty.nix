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
          opacity = 0.94;
          padding = {
              x = 15;
              y = 25;
        };
      };
      shell = {
          program = "${pkgs.zsh}/bin/zsh";
          args = ["--interactive"];
      };
      colors = {
          primary = {
              background = "0x${config.colorScheme.palette.base01}";
          };
          normal = {
              black = "0x${config.colorScheme.palette.base00}";
              red =   "0x${config.colorScheme.palette.base08}";
              green = "0x${config.colorScheme.palette.base0B}";
              yellow ="0x${config.colorScheme.palette.base0A}";
              blue =  "0x${config.colorScheme.palette.base0D}";
              magenta="0x${config.colorScheme.palette.base0E}";
              cyan =  "0x${config.colorScheme.palette.base0C}";
              white = "0x${config.colorScheme.palette.base07}";
          };
          bright = {
              black = "#333333";
              red =   "#BA6D6D";
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
