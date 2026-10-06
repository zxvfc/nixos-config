{
	inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

	outputs = { nixpkgs, ... }: {
		nixosConfigurations.nixtest = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [ ./hosts/nixtest ];
		};
	};
}
