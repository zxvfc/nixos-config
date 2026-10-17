{ lib, pkgs, ... }: {
	imports = [ ./ly ];
	# services.displayManager.ly.enable = true;

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
	environment.sessionVariables.WLR_RENDERER = "vulkan";
	environment.systemPackages = with pkgs; [ 
		tofi
		alacritty
		waybar
		bibata-cursors
 		pavucontrol
		wl-clipboard
	];

	fonts.packages = with pkgs; [ 
		nerd-fonts.fira-code
		font-awesome
		inter
	];

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
			"nvim".source = ../dotfiles/nvim;
			"sway".source = ../dotfiles/sway;
			"gtk-3.0".source = ../dotfiles/gtk-3.0;
			"gtk-4.0".source = ../dotfiles/gtk-4.0;
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
