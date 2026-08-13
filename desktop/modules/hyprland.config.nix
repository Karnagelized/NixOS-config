{ config, lib, pkgs, ... }:

let
  wallpaperPath = "/home/maksim/Desktop/Projects/NixOS-Config/images/background.jpg";
in
{
  xdg.configFile."eww" = {
    source = ../configs/eww;
    recursive = true;
  };

  xdg.configFile."hypr/scripts" = {
    source = ../configs/hypr/scripts;
    recursive = true;
  };

  xdg.configFile."matugen" = {
    source = ../configs/matugen;
    recursive = true;
  };

  xdg.configFile."swayosd/style.css".text = ''
    window {
      border-radius: 8px;
      background: #1e1e2e;
      border: 2px solid #89b4fa;
    }

    progressbar {
      border-radius: 6px;
      background: #313244;
    }

    progress {
      border-radius: 6px;
      background: #89b4fa;
    }

    label {
      color: #cdd6f4;
      font-family: "JetBrains Mono";
    }
  '';

  home.packages = with pkgs; [
    acpi
    alsa-utils
    bc
    bluez
    brightnessctl
    cava
    cliphist
    curl
    easyeffects
    fd
    ffmpeg
    fortune
    glib
    gpu-screen-recorder
    gtk3
    imagemagick
    inotify-tools
    iw
    jq
    libnotify
    lm_sensors
    matugen
    mpvpaper
    networkmanager
    networkmanagerapplet
    pamixer
    playerctl
    procps
    psmisc
    pulseaudio
    ripgrep
    satty
    socat
    swayosd
    tree
    wireplumber
    wl-clipboard
    wl-screenrec
    zbar
    awww
    (writeShellScriptBin "swww" ''
      exec ${awww}/bin/awww "$@"
    '')
    (writeShellScriptBin "swww-daemon" ''
      exec ${awww}/bin/awww-daemon "$@"
    '')
    qt6.qtmultimedia
    qt6.qt5compat
    qt6.qtwebsockets
    qt6.qtwebengine
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WALLPAPER_DIR = "${config.home.homeDirectory}/Pictures/Wallpapers";
  };

  home.activation.ensureQuickshellState = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${config.home.homeDirectory}/.config/hypr" "${config.home.homeDirectory}/.config/quickshell" "${config.home.homeDirectory}/.config/cava"
    if [ ! -f "${config.home.homeDirectory}/.config/hypr/settings.json" ]; then
      printf '{}' > "${config.home.homeDirectory}/.config/hypr/settings.json"
    fi
    if [ ! -f "${config.home.homeDirectory}/.config/hypr/colors.conf" ]; then
      printf '$active_border = rgba(89b4faee)\n$inactive_border = rgba(313244aa)\n' > "${config.home.homeDirectory}/.config/hypr/colors.conf"
    fi
    if [ ! -f "${config.home.homeDirectory}/.config/quickshell/weather.env" ]; then
      : > "${config.home.homeDirectory}/.config/quickshell/weather.env"
    fi
    if [ ! -f "${config.home.homeDirectory}/.config/cava/config_base" ]; then
      : > "${config.home.homeDirectory}/.config/cava/config_base"
    fi
  '';

  services.easyeffects.enable = true;

  services.swayosd = {
    enable = true;
    topMargin = 0.9;
    stylePath = "${config.home.homeDirectory}/.config/swayosd/style.css";
  };

  services.hyprpaper = {
    enable = true;

    settings = {
      splash = false;

      wallpaper = [
        {
          monitor = "";
          path = wallpaperPath;
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

      source = [
        "~/.config/hypr/colors.conf"
      ];

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

#      windowrule = [
#        # 1. Разрешаем плавать только полноценным окнам JetBrains (у которых ЕСТЬ заголовок)
#        "float on, match:class ^jetbrains-.*, match:title ^(?!\\s*$).+"
#
#        # 2. Переносим на HDMI-A-1 только диалоговые окна
#        "monitor HDMI-A-1, match:class ^jetbrains-.*, match:title ^(?!\\s*$).+"
#
#        # 3. Центрируем ТОЛЬКО окна с текстом в заголовке
#        "center on, match:class ^jetbrains-.*, match:title ^(?!\\s*$).+"
#
#        # 4. Для мелких всплывающих элементов без заголовка (меню, подсказки)
#        # отключаем принудительный первоначальный фокус, чтобы они не ломали ввод текста
#        "no_initial_focus on, match:class ^jetbrains-.*, match:title ^\\s*$"
#      ];

      layerrule = [
        "noanim, ^(volume_osd)$"
        "noanim, ^(brightness_osd)$"
        "noanim, hyprpicker"
        "noanim, qsdock"
        "blur, ext-session-lock"
        "ignorealpha 0.2, ext-session-lock"
      ];

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

        "SUPER, D, exec, ~/.config/hypr/scripts/qs_manager.sh toggle applauncher"
        "SUPER, C, exec, ~/.config/hypr/scripts/qs_manager.sh toggle clipboard"
        "SUPER, M, exec, ~/.config/hypr/scripts/qs_manager.sh toggle monitors"
        "SUPER SHIFT, S, exec, ~/.config/hypr/scripts/qs_manager.sh toggle settings"
        "SUPER, B, exec, ~/.config/hypr/scripts/qs_manager.sh toggle battery"
        "SUPER, W, exec, ~/.config/hypr/scripts/qs_manager.sh toggle wallpaper"
        "SUPER, S, exec, ~/.config/hypr/scripts/qs_manager.sh toggle calendar"
        "SUPER, N, exec, ~/.config/hypr/scripts/qs_manager.sh toggle network"
        "SUPER SHIFT, T, exec, ~/.config/hypr/scripts/qs_manager.sh toggle focustime"
        "SUPER, V, exec, ~/.config/hypr/scripts/qs_manager.sh toggle volume"
        "SUPER, H, exec, ~/.config/hypr/scripts/qs_manager.sh toggle guide"
        "SUPER, L, exec, bash ~/.config/hypr/scripts/lock.sh"
      ];

      bindl = [
        ", Print, exec, bash ~/.config/hypr/scripts/screenshot.sh"
        "SHIFT, Print, exec, bash ~/.config/hypr/scripts/screenshot.sh --edit"
        "SUPER, Print, exec, bash ~/.config/hypr/scripts/screenshot.sh --full"
        "SUPER SHIFT, Print, exec, bash ~/.config/hypr/scripts/screenshot.sh --full --edit"
        ", XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
        ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"
      ];

      bindel = [
        ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
        ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
        ", XF86MonBrightnessDown, exec, swayosd-client --brightness lower"
        ", XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
      ];

      exec-once = [
        "mako"
        "nm-applet"
        "/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1"
        "playerctld"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "swww-daemon"
        "sh -c 'sleep 0.5; swww img ${wallpaperPath}'"
        "quickshell -p ~/.config/hypr/scripts/quickshell/Shell.qml"
        "python3 ~/.config/hypr/scripts/quickshell/focustime/focus_daemon.py"
      ];
    };

    extraConfig = ''
      submap = passthru
      bind = SUPER SHIFT CTRL ALT, F35, exec, true
      submap = reset
    '';
  };
}
