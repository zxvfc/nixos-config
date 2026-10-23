 let
	keys = import ../modules/keys.nix;
 in {
 	"ssh_hosts.age".publicKeys = keys.zxvfc ++ keys.asus;
 }
