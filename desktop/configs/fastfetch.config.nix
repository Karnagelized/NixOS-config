{ pkgs, ... }:
{
  programs.fastfetch = {
  	enable = true;
  	settings = {
  		logo = {
  			source = "nixos";
  		};
  		modules = [
  			"title"
  			"separator"
  			"os"
  			"kernel"
  			"uptime"
  			"shell"
  			"resolution"
  			"de"
  			"cpu"
				"gpu"
  			"memory"
  			"swap"
  			"disk"
  		];
  	};
  };
}
