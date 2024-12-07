{ pkgs, inputs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
		./hardware-configuration.nix
       inputs.home-manager.nixosModules.home-manager
	   # <nixpkgs/nixos/modules/services/network-filesystems/nfs.nix>
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
   networking.firewall.enable = false;
   networking.firewall.allowedTCPPorts = [ 22 111 ];
   networking.firewall.allowedUDPPorts = [ 111 ];
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
	  MANPAGER = "nvim +Man!";
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
      graphics.enable = true;
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
   services = {
	   sshd. enable = true;
		openssh = {
			enable = true;
			ports = [ 22 ];
			settings = {
				PasswordAuthentication = false;
				AllowUsers = null; 
				# Allows all users by default. Can be [ "user1" "user2" ]
				UseDns = true;
				X11Forwarding = false;
				PermitRootLogin = "prohibit-password"; 
				# "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
			};
		};
   };

   boot.supportedFilesystems = ["nfs"];
   services.nfs.server.enable = true;
	  environment.etc."rpc".text = lib.mkForce ''
	  #ident	"@(#)rpc	1.11	95/07/14 SMI"	/* SVr4.0 1.2	*/
#
#	rpc
#
portmapper	100000	portmap sunrpc rpcbind
rstatd		100001	rstat rup perfmeter rstat_svc
rusersd		100002	rusers
nfs		100003	nfsprog
ypserv		100004	ypprog
mountd		100005	mount showmount
ypbind		100007
walld		100008	rwall shutdown
yppasswdd	100009	yppasswd
etherstatd	100010	etherstat
rquotad		100011	rquotaprog quota rquota
sprayd		100012	spray
3270_mapper	100013
rje_mapper	100014
selection_svc	100015	selnsvc
database_svc	100016
rexd		100017	rex
alis		100018
sched		100019
llockmgr	100020
nlockmgr	100021
x25.inr		100022
statmon		100023
status		100024
bootparam	100026
ypupdated	100028	ypupdate
keyserv		100029	keyserver
sunlink_mapper	100033
tfsd		100037
nsed		100038
nsemntd		100039
showfhd		100043	showfh
ioadmd		100055	rpc.ioadmd
NETlicense	100062
sunisamd	100065
debug_svc 	100066  dbsrv
ypxfrd		100069  rpc.ypxfrd
bugtraqd	100071
kerbd		100078
event		100101	na.event	# SunNet Manager
logger		100102	na.logger	# SunNet Manager
sync		100104	na.sync
hostperf	100107	na.hostperf
activity	100109	na.activity	# SunNet Manager
hostmem		100112	na.hostmem
sample		100113	na.sample
x25		100114	na.x25
ping		100115	na.ping
rpcnfs		100116	na.rpcnfs
hostif		100117	na.hostif
etherif		100118	na.etherif
iproutes	100120	na.iproutes
layers		100121	na.layers
snmp		100122	na.snmp snmp-cmc snmp-synoptics snmp-unisys snmp-utk
traffic		100123	na.traffic
nfs_acl		100227
sadmind		100232
nisd		100300	rpc.nisd
nispasswd	100303	rpc.nispasswdd
ufsd		100233	ufsd
fedfs_admin	100418
pcnfsd		150001	pcnfs
amd		300019  amq
sgi_fam		391002	fam
bwnfsd		545580417
fypxfrd		600100069 freebsd-ypxfrd
ssnfs       31110023 nfsprog
'';

   services.rpcbind.enable = true;
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
      enable = false;
      extraGSettingsOverridePackages = [
      ];
    };
  };

   systemd.services.rpcbind.environment = {
		   RPCBIND_OPTIONS = "-w";
   };

   environment.gnome.excludePackages = with pkgs; [
    baobab      # disk usage analyzer
    cheese      # photo booth
    eog         # image viewer
    epiphany    # web browser
    gedit       # text editor
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
  # system.autoUpgrade = {
  #  enable = true;
  #  flake = inputs.self.outPath;
  #  flags = [
  #   "--update-input"
  # 	  "nixpkgs"
  # 	  "-L"
  #  ];
  #  dates = "09:00";
  #  randomizedDelaySec = "45min";
  # };

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
