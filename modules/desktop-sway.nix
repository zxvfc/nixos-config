{ pkgs, ... }: {
	programs.sway = {
		enable = true;
		wrapperFeatures.gtk = true;
	};

  programs.sway.package = pkgs.sway.override {
    sway-unwrapped = pkgs.sway-unwrapped.override { swaybg = null; };
  };

	services.displayManager.ly = {
		enable = true;
	};

	programs.firefox.enable = true;
	# environment.etc."sway/config.d/90-local.conf".text = '';
}
