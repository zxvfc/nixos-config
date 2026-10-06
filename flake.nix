{
	input.nixpkgs.url = "github";

	outputs = { nixpkgs, ... }: {
		nixosConfigurations.nixtest = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [ ./hosts/nixtest ];
		};
	};
}
