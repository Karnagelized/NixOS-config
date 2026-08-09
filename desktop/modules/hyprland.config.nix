{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";

    settings = {
      "$terminal" = "kitty";
      "$menu" = "rofi -show drun";

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
        "waybar"
        "mako"
        "hyprpaper"
        "nm-applet"
        "/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1"
      ];
    };
  };
}