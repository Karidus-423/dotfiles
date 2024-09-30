{ pkgs, inputs,  ... }:

{
  imports =
    [ # Include the results of the hardware scan.
		./hardware-configuration.nix
       inputs.home-manager.nixosModules.home-manager
    ];

  # Bootloader.
  #______________________________________#
	boot.loader = {
		systemd-boot.enable = false;
		grub = {
			enable = true;
			device = "nodev";
			useOSProber = true;
			efiSupport = true;
		};
		efi ={
			canTouchEfiVariables = true;
			efiSysMountPoint = "/boot";
		};
	};
  #______________________________________#

  #______________________________________#
  # Network #
	networking.hostName = "ontos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
	networking.networkmanager.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  #______________________________________#

  #______________________________________#
  # Enable bluetooth
  hardware.bluetooth = {
      enable = true;
	  powerOnBoot = true;
      settings = {
          General = {
              Name = "Hello";
              ControllerMode = "dual";
              FastConnectable = "true";
              Experimental = "true";
          };
          Policy = {
              AutoEnable = "true";
          };
      };
  };
  #______________________________________#



  #______________________________________#
  # User Account. Don't forget to set a password with ‘passwd’.
  users.users.kapud = {
    isNormalUser = true;
    description = "Kennett Puerto";
    extraGroups = [ "networkmanager" "wheel" "sound" "video"];
    shell = pkgs.zsh;
    packages = with pkgs; [
    firefox
    alacritty
    pavucontrol
    wireplumber
    brightnessctl
    ];
  };
  #______________________________________#

  #______________________________________#
  #Programs
  programs.zsh = {
	  enable = true;
  };
  programs.neovim= {
		enable = true;
		defaultEditor = true;
		package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };
  programs.hyprland = {
      enable = true;
      xwayland.enable = true;
  };
  #______________________________________#

  #______________________________________#
  #Environment
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.pathsToLink = ["/share/zsh"];
  environment.systemPackages = with pkgs; [
	  alacritty
	  kitty
	  vim 
	  git
	  lazygit
	  obsidian
	  inputs.zen-browser.packages."x86_64-linux".default
  ];

  environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
      GTK_THEME = "Chicago95";
  };
  #______________________________________#

  #______________________________________#
  #Home-manager
  home-manager = {
	extraSpecialArgs = { inherit inputs; };
    users = {
      "kapud" = import ./home.nix;
    };
  };
  #______________________________________#


  #______________________________________#
  #Graphics
  hardware = {
      opengl.enable = true;
  };
  #______________________________________#

  #______________________________________#
  #Services 

  #Syncthing
   services.syncthing = {
	   enable = true;
	   user = "kapud";
	   dataDir = "home/kapud/syncthing";    # Default folder for new synced folders
	   configDir = "/home/kapud/.config/syncthing";   # Folder for Syncthing's settings and keys
   };

   #SSHD
   services.sshd = {
		enable = true;
   };

   services.blueman.enable = true;
   services.gvfs.enable = true;
   services.upower.enable = true;
   services.printing = {
	  enable = true;
   };

  # X11 Keymap Configuration
   services.xserver.xkb = {
     layout = "us";
     variant = "";
   };

  #Display Manager
   services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverridePackages = [
      ];
    };
  };


   environment.gnome.excludePackages = with pkgs.gnome; [
    baobab      # disk usage analyzer
    cheese      # photo booth
    eog         # image viewer
    epiphany    # web browser
    pkgs.gedit       # text editor
    simple-scan # document scanner
    totem       
    yelp        
    evince      
    file-roller
    geary      
    seahorse    
    # these should be self explanatory
    gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-contacts
    gnome-font-viewer gnome-logs gnome-maps gnome-music gnome-screenshot
    gnome-system-monitor gnome-weather gnome-disk-utility pkgs.gnome-connections
  ];

  services.greetd = {
      enable = true;
      settings = rec {
          initial_session = {
           command = "${pkgs.hyprland}/bin/Hyprland";
          user = "kapud";
      };
          default_session = initial_session;
      };
  };
  #______________________________________#

  #______________________________________#
  # Sound Configuration
  services.pipewire = {
	  enable = true;
	  alsa.enable = true;
	  alsa.support32Bit = true;
	  pulse.enable = true;
	# If you want to use JACK applications, uncomment this
	#jack.enable = true;
  };
  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false;
  #______________________________________#


  #______________________________________#
  # Miscellaneous
  xdg.portal.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11";

# Auto-Upgrade
  system.autoUpgrade = {
	  enable = true;
	  flake = inputs.self.outPath;
	  flags = [
		  "--update-input"
			  "nixpkgs"
			  "-L"
	  ];
	  dates = "09:00";
	  randomizedDelaySec = "45min";
  };

# Set your time zone.
  time.timeZone = "America/New_York";

# Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
	  LC_ADDRESS = "en_US.UTF-8";
	  LC_IDENTIFICATION = "en_US.UTF-8";
	  LC_MEASUREMENT = "en_US.UTF-8";
	  LC_MONETARY = "en_US.UTF-8";
	  LC_NAME = "en_US.UTF-8";
	  LC_NUMERIC = "en_US.UTF-8";
	  LC_PAPER = "en_US.UTF-8";
	  LC_TELEPHONE = "en_US.UTF-8";
	  LC_TIME = "en_US.UTF-8";
  };
  #______________________________________#
}
