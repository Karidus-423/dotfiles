{ inputs, pkgs, ...}:
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

	home.username = "kennettp";
	home.homeDirectory = "/home/kennettp";
	nixpkgs.config.allowUnfreePredicate = _: true;
	nixpkgs.config.cudaSupport = true;
# You should not change this value, even if you update Home Manager. If you do
# want to update the value, then make sure to first check the Home Manager
# release notes.
	home.stateVersion = "23.11";

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

	programs.ags = {
		enable = true;
		configDir = ../../modules/home-manager/ags_pneuma;
		extraPackages = with pkgs; [
			gtksourceview
				webkitgtk
				accountsservice
				gvfs
		];
	};
	# home.packages = [
	# inputs.astal.packages.${pkgs.system}.astal
	# inputs.astal.packages.${pkgs.system}.notifd
	# ];

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
		enableZshIntegration = true; # see note on other shells below
			enableBashIntegration = true;
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
		BROWSER = "firefox";
		TERMINAL = "foot";
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

	hyprlandGeneral = {
		gaps_in = 4;
		border_size = 3;
		allow_tearing = false;
		layout = "dwindle";
		"col.active_border" = "rgba(b2d498ee) rgba(b3dcdda8) 0deg";
		"col.inactive_border" = "rgba(acafadee) rgba(110f0fa5) 90deg";
	};

	hyprlandWallpaper = ../../modules/wallpapers/Trandheim.jpg;

	hyprlandMonitors = "DP-2,addreserved,0,0,512,512,3440x1440@165.00Hz,0x0,1";


	footWindowDimensions = "1220x1430";
}
