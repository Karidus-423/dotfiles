{config, pkgs, inputs, ...}:
{
	imports = [
		./hardware-configuration.nix
		inputs.home-manager.nixosModules.default
	];

#Bootloader
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "logos";

# Enable networking
	networking.networkmanager.enable = true;

# Enable bluetooth /currently disabled/
	hardware.bluetooth.powerOnBoot = false;
	hardware.bluetooth = {
		enable = false;
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
	services.blueman.enable = false;
	
	#Standard Interface for Applications to interact with
	xdg.portal= {
		enable = false;
	};


	#Required Services for Aylur's GTK Shell
	services.gvfs.enable = true;
	services.upower.enable = true;

	# Enable sound
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
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

  services.xserver = {
	  displayManager.gdm.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  users.users.karidus= {
    isNormalUser = true;
    description = "Karidus";
    extraGroups = [ "networkmanager" "wheel" "sound" "video"];
    shell = pkgs.zsh;
    packages = with pkgs; [
	neovim
    firefox
    alacritty
    pavucontrol
    wireplumber
    ];
  };

  services.greetd = {
      enable = true;
      settings = rec {
          initial_session = {
           command = "${pkgs.hyprland}/bin/Hyprland";
          user = "karidus";
      };
          default_session = initial_session;
      };
  };

  #Home-manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "karidus" = import ./home.nix;
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
      xwayland.enable = false;
  };
  hardware = {
      opengl.enable = true;
  };
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
