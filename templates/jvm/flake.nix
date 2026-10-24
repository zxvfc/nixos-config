{
	inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

	outputs = { nixpkgs, ... }: let
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
		jdk = pkgs.jdk21;

		kmp-lsp = pkgs.rustPlatform.buildRustPackage rec {
			pname = "kmp-lsp";
			version = "0.27.0";
			src = pkgs.fetchFromGitHub {
				owner = "Hessesian";
				repo = "kmp-lsp";
				tag = "v${version}";
				hash = "sha256-6F9g0bgsFooHzE9r1byBox13OW09MKfPOGhpCo4G0lk=";
			};
			cargoHash = "sha256-GGkb8KWc2ZicSOKMErS+a97PT983weioDyE79HRxa4I=";
			doCheck = false;
		};
	in {
		devShells.${system}.default = pkgs.mkShell {
			packages = [
				(pkgs.gradle_9.override { java = jdk; })
				jdk
				kmp-lsp
				pkgs.kotlin
				pkgs.ripgrep
				pkgs.fd
			];
		};
	};
}
