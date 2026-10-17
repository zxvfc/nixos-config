 let
	zxvfc =  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINagGpY4hAYbuMlgHicLIUwNW0Dt1PU+z5Zn1apGntFP zxvfc@archlinux";

 in {
 	"ssh_hosts.age".publicKeys = [ zxvfc ];
 }
