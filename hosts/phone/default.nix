{ config, pkgs, lib, ... }: let 
	keys = import ../../modules/keys.nix;
	authorizedKeys = pkgs.writeText."authorized_keys" (lib.concatStringsSep "\n" keys.zxvfc);
	sshDir = "${config.user.home}/sshd";
in {
	system.stateVersion = "24.05";
	nix.extraOptions = ''
		experimental-features = nix-command flakes
	'';

	environment.packages = with pkgs; [
		neovim
		git
		openssh
		bat
		gnugrep
		ncurses
		cloudflared

		(writeScriptBin "sshd-start" ''
			#!${runtimeShell}
			exec ${openssh}/bin/sshd -f ${sshDir}/sshd_config -D
		'')
		(writeScriptBin "tunnel-start" ''
			#!${runtimeShell}
			exec ${cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token-file ${config.user.home}/.cloudflared/token
		'')
		
	];

	build.activation.sshd = ''
		$DRY_RUN_CMD mkdir -p "${config.user.home}/.ssh" "${sshDir}"
		$DRY_RUN_CMD install -m 600 ${authorizedKeys} "${config.user.home}/.ssh/authorized_keys"
		if [ ! -f "${sshDir}/ssh_host_ed25519_key" ]; then
			$DRY_RUN_CMD ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -N "" -f "${sshDir}/ssh_host_ed25519_key"
		fi
		$DRY_RUN_CMD sh -c 'printf "HostKey ${sshDir}/ssh_host_ed25519_key\nPort 8022\nPasswordAuthentication no\n" > "${sshDir}/sshd_config"'
	'';

}
