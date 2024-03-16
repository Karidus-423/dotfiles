{
  description = "Nix dot files";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager ={
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";
    ags.url = "github:Aylur/ags";

  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
  nixosConfigurations = {
  	icarus = nixpkgs.lib.nixosSystem {
		specialArgs = { inherit inputs; };
		modules = [
			./hosts/icarus/configuration.nix
		];
	  };
       };
     };
}
