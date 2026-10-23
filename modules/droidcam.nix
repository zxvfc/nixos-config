{ config, pkgs, ... }: {
	boot = {
		extraModulePackages = [ 
			(config.boot.kernelPackages.v4l2loopback.overrideAttrs (old: {
				postInstall = (old.postInstall or "") + ''
					rm -f $out/lib/modules/*/modules.*
				'';
			})) 
		];
		kernelModules = [ "v4l2loopback" ];
		extraModprobeConfig = ''
			options v4l2loopback devices=1 video_nr=9 card_label="DroidCam" exclusive_caps=1
		'';
	};

	environment.systemPackages = with pkgs; [
		droidcam
		android-tools
	];
}
