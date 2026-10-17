{
	inputs = {
		self.submodules = true;
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		agenix = {
			url = "github:ryantm/agenix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, agenix, ... }: let
		mk = host: extra: nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				home-manager.nixosModules.home-manager
				./modules/common.nix
				./hosts/${host}
				agenix.nixosModules.default
				({ pkgs, ... }: {
					environment.systemPackages = [ agenix.packages.${pkgs.stdenv.hostPlatform.system}.default ];
				})
			] ++ extra;
		};
	in {
		nixosConfigurations = {
			nixtest = mk "nixtest" [ ];
			nixtest-sway = mk "nixtest" [ ./modules/desktop-sway.nix ];
			redmibook-15-amd-2021 = mk "redmibook-15-amd-2021" [ 
				./modules/desktop-sway.nix 
				./modules/social.nix 
			];
		};
	};
}
