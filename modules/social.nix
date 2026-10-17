{ pkgs, ... }: {
	envioronment.systemPackages = with pkgs; [
		telegram-desktop
		vesktop
	];
}
