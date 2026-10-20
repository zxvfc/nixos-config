{
	inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

	outputs = { nixpkgs, ... }: let
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
		jdk = pkgs.jdk21;
	in {
		devShells.${system}.default = pkgs.mkShell {
			packages = [
				jdk
				(pkgs.gradle_9.override { java = jdk; })
				pkgs.kotlin
			];
		};
	};
}
