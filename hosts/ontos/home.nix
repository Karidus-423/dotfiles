{ inputs, pkgs, ... }:
let
    chicago95 = import ../../modules/gtk_themes/chicago95.nix {inherit pkgs;};
in
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    inputs.ags.homeManagerModules.default
    ./packages/packs-conf.nix
    ./packages/packs-ontos.nix
  ];
  home.username = "kapud";
  home.homeDirectory = "/home/kapud";
  nixpkgs.config.allowUnfreePredicate = _: true;
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11";
  programs.ags = {
      enable = true;
	  configDir = ../../modules/home-manager/ags;
      extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
      gvfs
      ];
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  colorScheme = inputs.nix-colors.lib.schemeFromYAML "sainte-adresse" 
  (builtins.readFile ../../modules/home-manager/custom_base16/sainte-adresse.yaml);
  #colorScheme = nix-colors-lib.colorSchemeFromPicture {
  #  path = ./wallpapers/forest.png;
  #  variant = "light";
  #};
  home.pointerCursor = {
  gtk.enable = true;
  # x11.enable = true;
  package = pkgs.bibata-cursors;
  name = "Bibata-Modern-Ice";
  size = 24;
};
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
  home.sessionVariables = {
    EDITOR = "nvim";
    GDK_BACKEND="wayland";
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

}
