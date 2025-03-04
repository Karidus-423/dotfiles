{
  description = "Home Manager Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
	home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
  };

  outputs = {nixpkgs, home-manager, ...}:
  let
	system = "x86_64-linux";
	pkgs = nixpkgs.legacyPackages.${system};
  in
  {
	  homeConfigurations.karidus = home-manager.lib.homeManagerConfiguration{
		  inherit pkgs;
		  modules = [./home.nix];
	  };
  };
}
