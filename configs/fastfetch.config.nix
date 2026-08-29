{ pkgs, ... }:
{
  programs.fastfetch = {
  	enable = true;
  	settings = {
  		logo = {
  			source = "nixos";
  		};
  		modules = [
  			"os"
  			"kernel"
  			"de"
  			"shell"
        { type = "localip"; key = "Local IP"; format = "{ipv4}"; }
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
          format = "{size-used} / {size-total} ({size-percentage} | {size-free})";
        }
        {
          type = "disk";
          key = "Disk (/mnt/storage)";
          keyColor = "green";
          folders = "/mnt/storage";
          format = "{size-used} / {size-total} ({size-percentage} | {size-free})";
        }

  			"break"

        {
          type = "weather";
          key = "Weather";
          keyColor = "green";

          format = "{result}";

          outputFormat = "%l:+%t+-+%C&u";
        }
        {
          type = "custom";
          keyColor = "magenta";
          text = "Don't decrease the goal. Increase the effort.";
        }
  		];
  	};
  };
}
