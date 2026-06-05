{ pkgs, ... }:
{
  programs.fastfetch = {
  	enable = true;
  	settings = {
  		logo = {
  			source = "nixos";
  			color = "blue";
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
