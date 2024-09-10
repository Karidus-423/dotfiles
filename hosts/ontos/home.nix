{ inputs, pkgs, ... }:
let
    chicago95 = import ../../modules/gtk_themes/chicago95.nix {inherit pkgs;};
in
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    inputs.ags.homeManagerModules.default
	inputs.spicetify-nix.homeManagerModules.default
    ./packs-conf.nix
  ];

#_____________________________________#
# Home Manager #
  home = {
	  username = "kapud";
	  homeDirectory = "/home/kapud";
	  stateVersion = "23.11";
  };
  home.sessionVariables = {
	  EDITOR = "nvim";
	  GDK_BACKEND="wayland";
  };
  home.pointerCursor = {
	  gtk.enable = true;
      # x11.enable = true;
	  package = pkgs.bibata-cursors;
	  name = "Bibata-Modern-Ice";
	  size = 24;
  };
# Let Home Manager install and manage itself.
	  programs.home-manager.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
# # Building this configuration will create a copy of 'dotfiles/screenrc' in
# # the Nix store. Activating the configuration will then make '~/.screenrc' a
# # symlink to the Nix store copy.
# ".screenrc".source = dotfiles/screenrc;

# # You can also set the file content immediately.
# ".gradle/gradle.properties".text = ''
#   org.gradle.console=verbose
#   org.gradle.daemon.idletimeout=3600000
# '';
  home.file = {
       ".config/swappy/config".source = ../../modules/home-manager/swappy/config;
   };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kapud/etc/profile.d/hm-session-vars.sh
  #
# You should not change this value, even if you update Home Manager. If you do
# want to update the value, then make sure to first check the Home Manager
# release notes.
#_____________________________________#

#_____________________________________#
# Simple Home Manager Options
  nixpkgs.config.allowUnfreePredicate = _: true;
  programs.ags = {
	  enable = true;
	  configDir = ../../modules/home-manager/ags_ontos;
	  extraPackages = with pkgs; [
		  gtksourceview
		  webkitgtk
		  accountsservice
		  gvfs
	  ];
  };

  programs.git = {
	  enable = true;
	  userName = "Karidus-423";
	  userEmail = "kapuerto23@gmail.com";
	  extraConfig = {
		  init.defaultBranch = "main";
		  safe.directory = "/etc/nixos";
	  };
  };

  programs.direnv = {
	  enable = true;
	  nix-direnv.enable = true;
  };

  services.gpg-agent = {
   enable = true;
   defaultCacheTtl = 1800;
   enableSshSupport = true;
  };

  services.gammastep = {
	  enable = true;
	  provider = "manual";
	  temperature.day = 5000;
	  temperature.night = 3200;
	  latitude = 38.2;
	  longitude = -84.87;
  };
#_____________________________________#

#_____________________________________#
# Theming #
  colorScheme = inputs.nix-colors.lib.schemeFromYAML "sainte-adresse" 
	  (builtins.readFile ../../modules/home-manager/custom_base16/sainte-adresse.yaml);
#colorScheme = nix-colors-lib.colorSchemeFromPicture {
#  path = ./wallpapers/forest.png;
#  variant = "light";
#};
  gtk = {
	  enable = true;
	  font = {
		  name = "TeX Gyre Adventor";
	  };
	  theme = {
		  package = chicago95;
		  name = "Chicago95";
	  };
	  iconTheme = {
		  package = chicago95;
		  name = "Chicago95";
	  };
  };

  #Options
  hyprlandGeneral = {
		gaps_in = 3;
		border_size = 3;
		allow_tearing = false;
		layout = "dwindle";
		"col.active_border" = "rgb(b2d498)";
		"col.inactive_border" = "rgba(acafadee)";
	};
  hyprlandWallpaper = ../../modules/wallpapers/Regatta.jpg;
  footFontProps = "GoMono Nerd Font:size=8.7";
  footWindowDimensions = "850x790";
#_____________________________________#

}
