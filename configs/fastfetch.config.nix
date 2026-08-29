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
  			"localip"
  			"netio"
  			"uptime"
  			"packages"
  			"shell"
  			"display"
  			"resolution"
  			"de"

        # Железо
        { type = "cpu"; key = "  CPU"; keyColor = "cyan"; }
        { type = "gpu"; key = "  GPU"; keyColor = "cyan"; }

        "break"

        # Память
        { type = "memory"; key = "  Memory"; keyColor = "green"; }
        { type = "swap"; key = "  Swap"; keyColor = "green"; }
        { type = "disk"; key = "  Disk (/)"; keyColor = "green"; folders = "/"; }
        { type = "disk"; key = "  Storage"; keyColor = "green"; folders = "/mnt/storage"; }

        "break"

        "colors"

        "break"

        "weather"
        "song"
  		];
  	};
  };
}
