{ pkgs, ... }: {
	programs.sway = {
		enable = true;
		wrapperFeatures.gtk = true;
	};

	services.displayManager.ly = {
		enable = true;
	};

	# environment.etc."sway/config.d/90-local.conf".text = '';
}
