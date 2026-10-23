{ pkgs, inputs, ... }: {

	imports = [ inputs.agenix.nixosModules.default ];

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

	programs.neovim = {
		enable = true;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;
	};

	environment.systemPackages = with pkgs; [ 
		git 
		bat
		jq
		inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
    # util-linux
    # coreutils
    # gnugrep
    # iw
	];
}
