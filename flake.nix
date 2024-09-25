{
  description = "Nix dot files";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
    ags.url = "github:Aylur/ags";
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

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs{ inherit system; config = { allowUnfree = true; }; };
  in
  {
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
		logos = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; };
			modules = [
				./hosts/logos/configuration.nix
			];
		  };
    };
  };
}
