{
  description = "Nix dot files";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
	ags.url = "github:Aylur/ags?ref=v1";
	astal = {
		url = "github:aylur/astal";
		inputs.nixpkgs.follows = "nixpkgs";
	};
	neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
	zen-browser.url = "github:MarceColl/zen-browser-flake";
	spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	home-manager ={
		url = "github:nix-community/home-manager";
		inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = { self, nixpkgs,astal, ... }@inputs: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs{ inherit system; config = { allowUnfree = true; }; };
  in
  {
	packages.${system}.default = astal.lib.mkLuaPackage {
		inherit pkgs;
		name = "astal-shell"; # how to name the executable
		src = ./modules/home-manager/astal_pneuma; # should contain init.lua

		# add extra glib packages or binaries
		extraPackages = [
			astal.packages.battery
			pkgs.dart-sass
		];
	};
  nixosConfigurations = {
		pneuma = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; };
			modules = [
				./hosts/pneuma/configuration.nix
			];
		  };
		ontos = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; };
			modules = [
				./hosts/ontos/configuration.nix
			];
		  };
    };
  };
}
