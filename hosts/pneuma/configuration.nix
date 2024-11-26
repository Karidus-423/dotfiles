{config, pkgs, inputs,...}:
{
	imports = [
		./hardware-configuration.nix
		inputs.home-manager.nixosModules.default
	];

#Bootloader
	time.hardwareClockInLocalTime = true;
	boot.loader = {
		systemd-boot.enable = false;
		efi.canTouchEfiVariables = true;
		efi.efiSysMountPoint = "/boot";
		grub.enable = true;
		grub.device = "nodev";
		grub.useOSProber = true;
		grub.efiSupport = true;
		grub.theme = pkgs.stdenv.mkDerivation {
			  pname = "distro-grub-themes";
			  version = "3.2";
			  src = pkgs.fetchurl {
				url = "https://github.com/AdisonCavani/distro-grub-themes/releases/download/v3.2/nixos.tar";
				hash = "sha256-oW5DxujStieO0JsFI0BBl+4Xk9xe+8eNclkq6IGlIBY";
			  };
			  unpackPhase = ''mkdir $out && tar -xvf $src -C $out'';
		};
	};


# Enable networking
	networking.hostName = "pneuma";
	networking.networkmanager= {
		enable = true;
		plugins = with pkgs;[
		  networkmanager-fortisslvpn
          networkmanager-iodine
          networkmanager-l2tp
          networkmanager-openconnect
          networkmanager-openvpn
          networkmanager-vpnc
          networkmanager-sstp
		];
	};
	networking.firewall.enable = false;
	networking.firewall.allowedTCPPorts = [22 111];
    networking.firewall.allowedUDPPorts = [111];

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
	boot.supportedFilesystems = [ "nfs" ];
	services.rpcbind.enable = true;

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
	  enable = true;
	  displayManager.gdm.enable = true;
	  desktopManager.gnome = {
		enable = false;
	  };
	  videoDrivers = ["nvidia"];
	  excludePackages = with pkgs;[
		xterm
	  ];
  };

	systemd.services.rpcbind.environment = {
	  RPCBIND_OPTIONS = "-w";
	};

   environment.gnome.excludePackages = with pkgs; [
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
    gnome-system-monitor gnome-weather gnome-disk-utility gnome-connections
  ];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  users.users.kennettp= {
    isNormalUser = true;
    description = "kennettp";
    extraGroups = [ "networkmanager" "wheel" "sound" "video" "libvirtd"];
    shell = pkgs.zsh;
    packages = with pkgs; [
    firefox
    foot
    pavucontrol
    wireplumber
	lazygit
    ];
  };
  
  

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
  environment.systemPackages = with pkgs; [
	wlr-randr
  ];

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
  programs.nix-ld.enable = true;
  programs.gnupg.agent = {
	  enable = true;
	  enableSSHSupport = true;
  };

  programs.hyprland = {
	  enable = true;
	  xwayland.enable = true;
  };
  programs.zsh.enable=true;
  programs.neovim= {
	  enable = true;
	  defaultEditor = true;
	  viAlias = true;
	  vimAlias = true;
	  package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };
  # Enable graphics driver in NixOS unstable/NixOS 24.11
  hardware.graphics.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # OBS
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
	  obs-3d-effect
    ];
  };
   boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

  boot.kernelModules = ["v4l2loopback" "nvidia-uvm"];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  services.udev.extraRules =
	  ''
	  KERNEL=="nvidia_uvm", RUN+="${pkgs.stdenv.shell} -c 'mknod -m 666 /dev/nvidia-uvm c $(grep nvidia-uvm /proc/devices | cut -d \  -f 1) 0'"
  '';
  security.polkit.enable = true;
# List services that you want to enable:
# Enable the OpenSSH daemon.
  services.openssh = {
	  enable = true;
# require public key authentication for better security
	  settings.PasswordAuthentication = false;
	  settings.KbdInteractiveAuthentication = false;
	  ports = [22];
  };
  users.users."kennettp".openssh.authorizedKeys.keys = [
  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINIGSab3NDsabO8qQCoPp6LOXbpB/uaF0w34GmN1LPbc kapud"
  ];
#Syncthing
  services = {
	  syncthing = {
		  enable = true;
		  user = "kennettp";
		  configDir = "/home/kennettp/.config/syncthing";   # Folder for Syncthing's settings and keys
	  };
	  hardware = {
		  openrgb = {
			  enable = true;
			  package = pkgs.openrgb-with-all-plugins; 
			  motherboard = "intel";
		  };
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

  # Virtualization
  virtualisation.libvirtd = {
  enable = true;
  qemu = {
    package = pkgs.qemu_kvm;
    runAsRoot = true;
    swtpm.enable = true;
    ovmf = {
      enable = true;
      packages = [(pkgs.OVMF.override {
        secureBoot = true;
        tpmSupport = true;
      }).fd];
    };
  };
};

}
