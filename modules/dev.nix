{ pkgs, ... }: {
	programs.nix-ld.enable = true;

	home-manager.users.zxvfc.programs.direnv = {
		enable = true;
		nix-direnv.enable = true;
	};
}
