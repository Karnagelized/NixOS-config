{ pkgs, ... }:
{
  programs.fastfetch = {
  	enable = true;
  	settings = {
  		logo = {
  			source = "nixos";
  		};
  		modules = [
        { type = "title"; format = "{user-name} ~ {host-name}"; }
        { type = "separator"; string = "─"; }

  			"os"
  			"kernel"
  			"de"
  			"shell"
        { type = "localip"; key = "Local IP"; keyColor = "blue"; format = "{ipv4}"; }
  			"packages"
  			"uptime"
        { type = "weather"; key = "Weather"; keyColor = "green"; format = "{location}: {temperature} - {status}"; }

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
          format = "{size-used} / {size-total} ({size-percentage}) [Свободно: {size-free}]";
        }
        {
          type = "disk";
          key = "Disk (/mnt/storage)";
          keyColor = "green";
          folders = "/mnt/storage";
          format = "{size-used} / {size-total} ({size-percentage}) [Свободно: {size-free}]";
        }
  		];
  	};
  };
}
