{ lib, pkgs, ... }: {
	boot.kernelPackages = pkgs.linuxPackages_latest;

	time.timeZone = "Asia/Bangkok";

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nix.settings.auto-optimise-store = true;
	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 7d";
	};

	documentation.enable = false;
	zramSwap.enable = true;

    	networking.networkmanager.enable = true;

	environment.systemPackages = with pkgs; [ 
		neovim 
		git 
		bat
    # util-linux
    # coreutils
    # gnugrep
    # iw
	];

	users.users.zxvfc = {
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" ];
	};
}
