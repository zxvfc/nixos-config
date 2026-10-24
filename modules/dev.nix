{ pkgs, ... }: {
	programs = {
		nix-ld.enable = true;
		zsh = {
			enable = true;
			enableCompletion = false;
		};
	};

	home-manager.users.zxvfc.programs = {	
		direnv = {
			enable = true;
			nix-direnv.enable = true;
		};
		zsh = {
			enable = true;
			initContent = builtins.readFile ../dotfiles/zsh/zshrc;
			oh-my-zsh = {
				enable = true;
				theme = "robbyrussell";
				plugins = [ "git" "sudo" ];
			};
		};
	};
}
