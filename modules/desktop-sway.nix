{ lib, pkgs, ... }: {
	services.displayManager.ly.enable = true;

	xdg.portal = {
		enable = true;
		extraPortals = [
			pkgs.xdg-desktop-portal-gtk
			pkgs.xdg-desktop-portal-wlr
			pkgs.darkman
		];
		config.sway = {
			default = [ "gtk" ];
			"org.freedesktop.impl.portal.Settings" = [ "darkman" ];
			"org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
			"org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
			"org.freedesktop.impl.portal.Inhibit" = [ "none" ];
		};
	};

	programs = {
		sway = {
			enable = true;
			wrapperFeatures.gtk = true;
			package = pkgs.sway.override {
				sway-unwrapped = pkgs.sway-unwrapped.override { swaybg = null; };
			};
		};
		firefox.enable = true;
	};

	# environment.etc."sway/config.d/90-local.conf".text = '';
	environment.systemPackages = with pkgs; [ 
		tofi
		alacritty 
		waybar
		telegram-desktop
	];

	fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

	home-manager.backupFileExtension = "backup";
	home-manager.users.zxvfc = { ... }: {
		home.stateVersion = "26.11";

		services.darkman.enable = true;

		programs = {
			ssh = {
				enable = true;
				includes = [ "/run/agenix/ssh_hosts" ];
			};
			git = {
				enable = true;
				settings = {
					user.name = "Valentin";
					user.email = "velya.96@gmail.com";
				};
			};
		};

		xdg.configFile = {
			"sway".source = ../dotfiles/sway;
			"alacritty".source = ../dotfiles/alacritty;
			"waybar/config.jsonc".source = ../dotfiles/waybar/config.jsonc;
			"waybar/style.css".source = ../dotfiles/waybar/style.css;
			"waybar/dark.css".source = ../dotfiles/waybar/dark.css;
			"waybar/light.css".source = ../dotfiles/waybar/light.css;
		};
		xdg.dataFile."darkman/switch.sh" = {
			source = ../dotfiles/darkman/switch.sh;
			executable = true;
		};
	};
}
