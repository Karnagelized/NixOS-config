{ config, ... }:

let
  workLayoutScript = "${config.home.homeDirectory}/.local/bin/work-layout";
in
{
  home.file.".local/bin/work-layout" = {
    source = ../scripts/work-layout;
    executable = true;
  };

  dconf.enable = true;

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Open Files";
      command = "nautilus";
      binding = "<Super>e";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "Open Terminal";
      command = "kgx";
      binding = "<Super>t";
    };

    # Отключено до момента улучшений
    #"org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
    #  name = "Open Work Layout";
    #  command = workLayoutScript;
    #  binding = "<Super><Shift>w";
    #};
  };
}
