{ pkgs, ... }: {
	system.stateVersion = "24.05";

	environment.packages = with pkgs; [
		neovim
		git
		openssh
		bat
		grep
	];

	nix.extraOptions = ''
		experimental-features = nix-command flakes
	'';
}
