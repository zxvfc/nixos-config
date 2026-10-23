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
		nix-on-droid = {
			url = "github:newAM/nix-on-droid/update-proot";
			inputs.nixpkgs.follows = "nixpkgs";
		};

	};

	outputs = { self, nixpkgs, home-manager, agenix, nix-on-droid, ... }@inputs: let
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
					./modules/droidcam.nix
				];
			};
			server-a = mk { host = "server-a"; profile = "server"; };
			server-b = mk { host = "server-b"; profile = "server"; };
		};
		nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
			pkgs = import nixpkgs {
				system = "aarch64-linux";
				overlays = [ nix-on-droid.overlays.default ];
			};
			modules = [ ./hosts/phone ];
		};

		templates = {
			jvm = {
				path = ./templates/jvm;
				description = "Java/Kotlin dev shell";
			};
		};
	};
}
