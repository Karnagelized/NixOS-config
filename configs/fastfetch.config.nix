{ pkgs, ... }:
{
  programs.fastfetch = {
  	enable = true;
  	settings = {
  		logo = {
  			source = "nixos";
  		};
  		modules = [
  			"break"

  			"os"
  			"kernel"
  			"de"
  			"shell"
        "localip"
  			"packages"
  			"uptime"

  			"break"

        # Железо
        { type = "cpu"; key = "CPU"; keyColor = "green"; }
        { type = "gpu"; key = "GPU"; keyColor = "green"; }

        "break"

        # Память
        { type = "memory"; key = "Memory"; keyColor = "green"; }
        { type = "swap"; key = "Swap"; keyColor = "green"; }

        "break"

        # Диски
        {
          type = "disk";
          key = "Disk (/)";
          keyColor = "green";
          folders = "/";
          format = "{size-used} / {size-total} (Free {size-free}) ({size-percentage})";
        }
        {
          type = "disk";
          key = "Disk (/mnt/storage)";
          keyColor = "green";
          folders = "/mnt/storage";
          format = "{size-used} / {size-total} (Free {size-free}) ({size-percentage})";
        }

  			"break"

        {
          type = "weather";
          key = "Weather";
          keyColor = "green";
          format = "{result}";
          location = "Chelyabinsk";
          outputFormat = "%l:+%t+-+%C";
        }
        {
          type = "custom";
          format = "Don't decrease the goal. Increase the effort.";
          keyColor = "magenta";
        }
  		];
  	};
  };
}
