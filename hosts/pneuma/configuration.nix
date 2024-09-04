{config, pkgs, inputs, ...}:
{
	imports = [
		./hardware-configuration.nix
		inputs.home-manager.nixosModules.default
	];

#Bootloader
	boot.loader.systemd-boot.enable = false;
	boot.loader.grub.enable = true;
	boot.loader.grub.device = "nodev";
	boot.loader.grub.useOSProber = true;
	boot.loader.grub.efiSupport = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.efi.efiSysMountPoint = "/boot";
	boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
          pname = "distro-grub-themes";
          version = "3.2";
          src = pkgs.fetchurl {
            url = "https://github.com/AdisonCavani/distro-grub-themes/releases/download/v3.2/nixos.tar";
            hash = "sha256-oW5DxujStieO0JsFI0BBl+4Xk9xe+8eNclkq6IGlIBY";
          };
          unpackPhase = ''mkdir $out && tar -xvf $src -C $out'';
        };
	networking.hostName = "pneuma";

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

	#Standard Interface for Applications to interact with
	xdg.portal= {
		enable = true;
	};


	#Required Services for Aylur's GTK Shell
	services.gvfs.enable = true;
	# Enable sound
	hardware.pulseaudio.enable = false;
	hardware.pulseaudio.package = pkgs.pulseaudiofull;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		# If you want to use JACK applications, uncomment this
		jack.enable = true;
		pulse.enable = true;
		wireplumber.enable = true;
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
	  desktopManager.gnome = {
		enable = true;
	  };
	  videoDrivers = ["nvidia"];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  users.users.kennettp= {
    isNormalUser = true;
    description = "kennettp";
    extraGroups = [ "networkmanager" "wheel" "sound" "video"];
    shell = pkgs.zsh;
    packages = with pkgs; [
	neovim
    firefox
    alacritty
    pavucontrol
    wireplumber
	lazygit
    ];
  };
  programs.zsh.enable=true;

  services.greetd = {
      enable = true;
      settings = rec {
          initial_session = {
           command = "${pkgs.hyprland}/bin/Hyprland";
          user = "kennettp";
      };
          default_session = initial_session;
      };
  };


	#Environment
  environment.sessionVariables = {
	  WLR_NO_HARDWARE_CURSORS = "1";
	  NIXOS_OZONE_WL = "1";
	  MOZ_ENABLE_WAYLAND = "1"; # for firefox to run on wayland
	  MOZ_WEBRENDER = "1";
	  GTK_THEME = "Chicago95";
	  REBUILD_NAME = "pneuma";
  };
  #Home-manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "kennettp" = import ./home.nix;
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
  hardware = {
      opengl = {
		  enable = true;
		  driSupport = true;
		  driSupport32Bit = true;
	  };
	  nvidia = {
		  modesetting.enable=true;
		  # Use the NVidia open source kernel module (not to be confused with the
		  # independent third-party "nouveau" open source driver).
		  # Support is limited to the Turing and later architectures. Full list of 
		  # supported GPUs is at: 
		  # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
		  # Only available from driver 515.43.04+
		  # Currently alpha-quality/buggy, so false is currently the recommended setting.
		  open = false;
		  nvidiaSettings = true;

		  # Optionally, you may need to select the appropriate driver version for your specific GPU.
		  package = config.boot.kernelPackages.nvidiaPackages.stable;

		  prime = {
			  sync.enable = true;

# Make sure to use the correct Bus ID values for your system!
			  nvidiaBusId = "PCI:1:0:1";
			  intelBusId = "PCI:0:2:0";
		  };
	  };
  };
  # List services that you want to enable:
  # Enable the OpenSSH daemon.
   services.flatpak.enable = true;
   services.openssh.enable = true;
   #Syncthing
   services = {
	   syncthing = {
		   enable = true;
		   user = "kennettp";
		   configDir = "/home/kennettp/.config/syncthing";   # Folder for Syncthing's settings and keys
	   };
	   hardware = {
		openrgb.enable = true;
	   };
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
