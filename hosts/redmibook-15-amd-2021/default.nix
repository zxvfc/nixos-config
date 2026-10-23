{ config, lib, pkgs, ... }: {
	imports = [ ./hardware-configuration.nix ];
	networking.hostName = "redmibook-15-amd-2021";

	hardware.bluetooth = {
		enable = true;
		powerOnBoot = false;
	};

	services.tuned.enable = true;

	boot = { 
		blacklistedKernelModules = [ "i2c_piix4" ];
		kernelParams = [ "systemd.log_level=debug" "udev.log_level=debug" ];
		loader = {
			systemd-boot.enable = false;
			grub.enable = false;
			efi.canTouchEfiVariables = false;
			external = {
				enable = true;
				installHook = pkgs.writeShellScript "refine-hook" ''
				set -eu
				export PATH=${pkgs.coreutils}/bin:$PATH
				toplevel="$1"
				install -D -m 0644 "$toplevel/kernel" /boot/bzImage.new
				install -D -m 0644 "$toplevel/initrd" /boot/initrd.new
				mv -f /boot/bzImage.new /boot/bzImage
				mv -f /boot/initrd.new /boot/initrd
				printf '"NixOS" "init=%s/init %s initrd=\\boot\\initrd"\n' "$toplevel" "$(cat "$toplevel/kernel-params")" > /boot/refind_linux.conf
				'';
			};
		};
	};

	age = {
		identityPaths = [ "/home/zxvfc/.ssh/id_ed25519" ];
		secrets.ssh_hosts = {
  			file = ../../secrets/ssh_hosts.age;
			owner = "zxvfc";
			mode = "0400";
		};
	};

	environment.systemPackages = [ 
		pkgs.bluetui
		pkgs.cloudflared
	];

	system.stateVersion = "26.11";
}
