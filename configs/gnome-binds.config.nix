{ config, ... }:
{
  dconf.enable = true;

  dconf.settings = {
    # libgda 6 падает внутри GNOME Shell при запуске Copyous.
    # JSON-backend хранит историю на диске, но не использует libgda.
    "org/gnome/shell/extensions/copyous" = {
      database-backend = "json";
    };

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
      command = "kitty";
      binding = "<Super>t";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name = "Screen OCR";
      command = "normcap --color '#7cd5be'";
      binding = "<Alt><Shift>c";
    };
  };
}
