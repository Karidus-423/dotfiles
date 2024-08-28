{
  description = "Nix dot files";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
    ags.url = "github:Aylur/ags";
	home-manager ={
		url = "github:nix-community/home-manager";
		inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs{
		inherit system;
		config = {
			allowUnfree = true;
		};
	};
  in
  {
  nixosConfigurations = {
		pneuma = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs system; };
			modules = [
				./hosts/pneuma/configuration.nix
			];
		  };
		ontos = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs system; };
			modules = [
				./hosts/ontos/configuration.nix
			];
		  };
		logos = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs system; };
			modules = [
				./hosts/logos/configuration.nix
			];
		  };
    };
  };
}
