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
    "org/gnome/desktop/wm/keybindings" = {
      # Alt+Tab: individual windows on the current workspace.
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];

      # Super+Tab: standard GNOME application switcher across workspaces.
      switch-applications = [ "<Super>Tab" ];
      switch-applications-backward = [ "<Shift><Super>Tab" ];
    };

    "org/gnome/shell/window-switcher" = {
      current-workspace-only = true;
      app-icon-mode = "both";
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = false;
    };

    "org/gnome/shell/extensions/tilingshell" = {
      # Tiling Shell adds a "tiled windows" group into Alt+Tab by default.
      # Keep Alt+Tab as GNOME's normal window switcher instead.
      override-alt-tab = false;
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
