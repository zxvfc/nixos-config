{ pkgs, inputs, ... }: {
	imports = [
		../modules/common.nix
		inputs.home-manager.nixosModules.home-manager
	];

	boot.kernelPackages = pkgs.linuxPackages_latest;
	time.timeZone = "Asia/Bangkok";
    	networking.networkmanager.enable = true;

	home-manager.users.zxvfc.home.stateVersion = "26.11";

	users.users.zxvfc = {
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" ];
	};
}
