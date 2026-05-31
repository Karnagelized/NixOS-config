{ ... }:
let
	proxySecretPath = ./. + "/secrets/proxy.nix";

	# Read proxy connect data or NULL
	secrets = if builtins.pathExists proxySecretPath
						then import proxySecretPath
						else null;
in {
  networking.hostName = "maksim";

	# Proxy
	networking.proxy = if secrets != null && secrets.url != ""
		then {
			default = secrets.url;
			noProxy = "127.0.0.1,localhost,internal.domain";
		}
		else {};

	# Enable networking
	networking.networkmanager.enable = true;
	
	# Enable the OpenSSH daemon.
	# services.openssh.enable = true;

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;
}
