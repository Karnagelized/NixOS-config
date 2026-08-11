{ pkgs, ... }:

{
  xdg.configFile."eww" = {
    source = ../configs/eww;
    recursive = true;
  };
  xdg.configFile."rofi" = {
    source = ../configs/rofi-tokyo;
    recursive = true;
  };

  home.file.".local/bin/eww".source = "${pkgs.eww}/bin/eww";
  home.file.".local/bin/dashboard" = {
    source = ../configs/eww-bin/dashboard;
    executable = true;
  };
  home.file.".local/bin/launcher" = {
    source = ../configs/eww-bin/launcher;
    executable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";

    settings = {
      "$terminal" = "kitty";
      "$menu" = "rofi -show drun";

      monitor = [
        "DP-1, 1920x1080@75, 0x0, 1"
        "HDMI-A-1, 1920x1080@75, 1920x0, 1"
      ];

      input = {
        kb_layout = "us,ru";
        kb_options = "grp:win_space_toggle";
        follow_mouse = 1;
        touchpad.natural_scroll = true;
      };

      bind = [
        "SUPER, T, exec, $terminal"
        "SUPER, R, exec, $menu"
        "SUPER, E, exec, nautilus"
        "SUPER, Q, killactive"
        "SUPER, F, fullscreen"
        "SUPER SHIFT, E, exit"

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
      ];

      exec-once = [
        "eww -c ~/.config/eww/bar daemon"
        "eww -c ~/.config/eww/bar open bar"
        "eww -c ~/.config/eww/dashboard daemon"
        "mako"
        "hyprpaper"
        "nm-applet"
        "/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1"
      ];
    };
  };
}
