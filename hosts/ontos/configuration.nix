{ config, pkgs, inputs,  ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
       inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ontos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable bluetooth
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth = {
      enable = true;
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

  xdg.portal= {
      enable = true;
  };
  services.blueman.enable = true;
  services.gvfs.enable = true;
  services.upower.enable = true;

# Enable sound
  security.rtkit.enable = true;
  services.pipewire = {
	  enable = true;
	  alsa.enable = true;
	  alsa.support32Bit = true;
	  # If you want to use JACK applications, uncomment this
	  #jack.enable = true;
  };
  hardware.pulseaudio.enable = false;

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

  #Enable Display Manger
    services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverridePackages = [
          pkgs.nautilus-open-any-terminal
      ];
    };
  };

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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  fonts.packages = with pkgs; [
  	(nerdfonts.override{fonts = ["Gohu"];})
	libre-baskerville
  ];
  programs.zsh.enable=true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kapud = {
    isNormalUser = true;
    description = "Kennett Puerto";
    extraGroups = [ "networkmanager" "wheel" "sound" "video"];
    shell = pkgs.zsh;
    packages = with pkgs; [
	neovim
    firefox
    alacritty
    pavucontrol
    wireplumber
    brightnessctl
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.pathsToLink = ["/share/zsh"];
  environment.systemPackages = with pkgs; [
	alacritty
    kitty
    vim 
    git
    lazygit
  ];
  environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
      GTK_THEME = "Chicago95";

  };
  #Home-manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "kapud" = import ./home.nix;
    };
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
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  hardware = {
      opengl.enable = true;
  };
  # List services that you want to enable:
  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

   #Syncthing
   services = {
	   syncthing = {
		   enable = true;
		   user = "kapud";
		   dataDir = "home/kapud/syncthing";    # Default folder for new synced folders
		   configDir = "/home/kapud/.config/syncthing";   # Folder for Syncthing's settings and keys
	   };
   };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

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

}
