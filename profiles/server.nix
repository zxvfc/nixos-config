{ inputs, ... }: let 
	keys = import ../modules/keys.nix;
in {
	imports = [
		../modules/common.nix
		inputs.disko.nixosModules.disko
	];

	services.openssh = {
		enable = true;
		settings.PasswordAuthentication = false;
	};
	# networking.firewall.enable = true;

	users.users.root.openssh.authorizedKeys.keys = keys.zxvfc;
}
