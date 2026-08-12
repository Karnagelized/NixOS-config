{ pkgs, ... }:

{
  xdg.configFile."eww" = {
    source = ../configs/eww;
    recursive = true;
  };

  services.hyprpaper = {
    enable = true;

    settings = {
      splash = false;

      wallpaper = [
        {
          monitor = "";
          path = "/home/maksim/Desktop/Projects/NixOS-Config/images/background.jpg";
          fit_mode = "cover";
        }
      ];
    };
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

      workspace = [
        "1, monitor:HDMI-A-1, default:true, persistent:true"
        "2, monitor:HDMI-A-1, persistent:true"
        "3, monitor:HDMI-A-1, persistent:true"
        "4, monitor:HDMI-A-1, persistent:true"
        "5, monitor:HDMI-A-1, persistent:true"
        "6, monitor:HDMI-A-1, persistent:true"
        "7, monitor:DP-1, default:true, persistent:true"
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
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"

        "SUPER CTRL, Left, workspace, e-1"
        "SUPER CTRL, Right, workspace, e+1"

        "SUPER, Left, movefocus, l"
        "SUPER, Down, movefocus, d"
        "SUPER, Up, movefocus, u"
        "SUPER, Right, movefocus, r"

        "SUPER SHIFT, Left, movewindow, l"
        "SUPER SHIFT, Down, movewindow, d"
        "SUPER SHIFT, Up, movewindow, u"
        "SUPER SHIFT, Right, movewindow, r"

        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
      ];

      exec-once = [
        "eww open bar"
        "mako"
        "nm-applet"
        "/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1"
      ];
    };
  };
}
