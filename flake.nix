{
	inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

	outputs = { nixpkgs, ... }: let 
		mk = extra: nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [ 
				./modules/common.nix
				./hosts/nixtest 
			] ++ extra;
		};
	in {
		nixosConfigurations = {
			nixtest = mk [ ];
			nixtest-sway = mk [ ./modules/desktop-sway.nix ];
		};
	};
}
