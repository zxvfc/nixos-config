{ pkgs, ... }: {
	system.stateVersion = "24.05";

	environment.packages = with pkgs; [
		neovim
		git
		openssh
		bat
		gnugrep
		ncurses
	];

	nix.extraOptions = ''
		experimental-features = nix-command flakes
	'';
}
