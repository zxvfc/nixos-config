{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		agenix = {
			url = "github:ryantm/agenix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		disko = {
			url = "github:nix-community/disko";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		alacritty-theme = {
			url = "github:alacritty/alacritty-theme";
			flake = false;
		};
	};

	outputs = { nixpkgs, ... }@inputs: let
		mk = { host, profile, extra ? [ ] }: nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				./profiles/${profile}.nix
				./hosts/${host}
			] ++ extra;
		};
	in {
		nixosConfigurations = {
			nixtest = mk { host = "nixtest"; profile = "local-machine"; };
			nixtest-sway = mk { host = "nixtest"; profile = "local-machine"; extra = [ ./modules/desktop-sway.nix ]; };
			redmibook-15-amd-2021 = mk { host = "redmibook-15-amd-2021"; profile = "local-machine"; extra = [ 
					./modules/desktop-sway.nix 
					./modules/social.nix 
					./modules/dev.nix 
				];
			};
			server = mk { host = "server"; profile = "server"; };
		};

		templates = {
			jvm = {
				path = ./templates/jvm;
				description = "Java/Kotlin dev shell";
			};
		};
	};
}
