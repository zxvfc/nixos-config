{ ... }: {
	imports = [ ./disk.nix ];

	networking.hostName = "server";
	networking.useDHCP = true;

	boot.loader.grub.enable = true;
	boot.initrd.availableKernelModules = [ 
		"virtio_pci" 
		"virtio_blk" 
		"virtio_scsi" 
		"ahci" 
		"sd_mod"
	];

	system.stateVersion = "26.05";
}
