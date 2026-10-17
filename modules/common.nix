{ lib, pkgs, ... }: {
	boot.kernelPackages = pkgs.linuxPackages_latest;

	time.timeZone = "Asia/Bangkok";

	nix = {
		settings = {
			experimental-features = [ "nix-command" "flakes" ];
			auto-optimise-store = true;
		};
		gc = {
			automatic = true;
			dates = "weekly";
			options = "--delete-older-than 3d";
		};
	};

	documentation.enable = false;
	zramSwap.enable = true;

    	networking.networkmanager.enable = true;
	systemd.services.NetworkManager-wait-online.enable = false;

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
