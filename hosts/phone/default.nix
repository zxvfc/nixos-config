{ pkgs, ... }: {
	system.stateVersion = "24.05";

	environment.packages = with pkgs; [
		neovim
		git
		openssh
		bat
	];

	nix.extraOptions = ''
		eperemental-features = nix-command flakes
	'';
}
