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
  			"desktop"
  			"wm"
  			"memory"
  			"colors"
  		];
  	};
  };
}
