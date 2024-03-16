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

  networking.hostName = "icarus"; # Define your hostname.
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
  services.blueman.enable = true;
  services.gvfs.enable = true;

    # Enable Syncthing
 # services = {
 #     syncthing = {
 #         enable = true;
 #         user = "myusername";
 #         dataDir = "/home/myusername/Documents";
 #         configDir = "/home/myusername/Documents/.config/syncthing";
 #         overrideDevices = true;     # overrides any devices added or deleted through the WebUI
 #             overrideFolders = true;     # overrides any folders added or deleted through the WebUI
 #             settings = {
 #                 devices = {
 #                     "device1" = { id = "DEVICE-ID-GOES-HERE"; };
 #                     "device2" = { id = "DEVICE-ID-GOES-HERE"; };
 #                 };
 #                 folders = {
 #                     "Documents" = {         # Name of folder in Syncthing, also the folder ID
 #                         path = "/home/myusername/Documents";    # Which folder to add to Syncthing
 #                             devices = [ "device1" "device2" ];      # Which devices to share the folder with
 #                     };
 #                     "Example" = {
 #                         path = "/home/myusername/Example";
 #                         devices = [ "device1" ];
 #                         ignorePerms = false;  # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
 #                     };
 #                 };
 #             };
 #     };
 # };

# Enable sound
  security.rtkit.enable = true;
  services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
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

  #Enable Display Manger
    services.xserver.enable = true;
    services.xserver.displayManager.lightdm ={
        enable = true;
        greeter = {
            enable = true;
        };
    };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  fonts.packages = with pkgs; [
  	(nerdfonts.override{fonts = ["Gohu" "Mononoki"];})
  ];

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
    brightnessctl
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    kitty
    vim 
    git
    lazygit
    syncthing
  ];
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
  programs.hyprland.enable = true;
  programs.zsh.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "23.11";

}
