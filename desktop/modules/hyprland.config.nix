{ config, inputs, lib, pkgs, ... }:

let
  wallpaperPath = "/home/maksim/Desktop/Projects/NixOS-Config/images/background.jpg";
  quickshellPackage = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  xdg.configFile."hypr/scripts" = {
    source = ../configs/hypr/scripts;
    recursive = true;
  };

  xdg.configFile."matugen" = {
    source = ../configs/matugen;
    recursive = true;
  };

  xdg.configFile."rofi/config.rasi" = {
    force = true;
    text = ''
      configuration {
          modi:                       "drun,filebrowser,window";
          show-icons:                 true;
          display-drun:               "";
          display-window:             "";
          display-filebrowser:        "";
          drun-display-format:        "{name}";
          window-format:              "{w} · {c} · {t}";

          hover-select:               true;
          me-select-entry:            "";
          me-accept-entry:            "MousePrimary";
          case-sensitive:             false;
      }

      @theme "${config.home.homeDirectory}/.config/rofi/theme.rasi"
    '';
  };

  xdg.configFile."rofi/theme.rasi" = {
    force = true;
    text = ''
      * {
          bg:                 #1e1e2e;
          bg-alt:             #181825;
          fg:                 #cdd6f4;
          muted:              #a6adc8;
          border:             #89b4fa;
          selected-bg:        #89b4fa;
          selected-fg:        #11111b;
          urgent:             #f38ba8;

          font:               "JetBrains Mono 12";
          border-radius:      8px;
      }

      window {
          width:              720px;
          border:             2px;
          border-color:       @border;
          border-radius:      @border-radius;
          background-color:   @bg;
      }

      mainbox {
          padding:            12px;
          spacing:            10px;
          background-color:   transparent;
      }

      inputbar {
          padding:            10px 12px;
          border-radius:      6px;
          background-color:   @bg-alt;
          text-color:         @fg;
          children:           [ prompt, entry ];
      }

      prompt {
          padding:            0 10px 0 0;
          text-color:         @border;
      }

      entry {
          placeholder:        "Search";
          placeholder-color:  @muted;
          text-color:         @fg;
      }

      listview {
          lines:              8;
          columns:            1;
          fixed-height:       true;
          spacing:            4px;
          background-color:   transparent;
      }

      element {
          padding:            9px 10px;
          border-radius:      6px;
          text-color:         @fg;
          background-color:   transparent;
      }

      element selected {
          text-color:         @selected-fg;
          background-color:   @selected-bg;
      }

      element-icon {
          size:               24px;
          margin:             0 10px 0 0;
      }

      element-text {
          text-color:         inherit;
      }

      message {
          padding:            8px;
          border-radius:      6px;
          background-color:   @bg-alt;
          text-color:         @fg;
      }

      textbox {
          text-color:         @fg;
      }
    '';
  };

  xdg.configFile."swayosd/style.css" = {
    force = true;
    text = ''
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
  };

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

  systemd.user.services.quickshell = {
    Unit = {
      Description = "Quickshell desktop shell";
      After = [ "graphical-session.target" "hyprland-session.target" ];
      PartOf = [ "graphical-session.target" "hyprland-session.target" ];
    };

    Service = {
      ExecStart = "${quickshellPackage}/bin/quickshell -p ${config.home.homeDirectory}/.config/hypr/scripts/quickshell/Shell.qml";
      Restart = "on-failure";
      RestartSec = 2;
    };

    Install.WantedBy = [ "graphical-session.target" "hyprland-session.target" ];
  };

  systemd.user.services.quickshell-focustime = {
    Unit = {
      Description = "Quickshell focus time daemon";
      After = [ "graphical-session.target" "hyprland-session.target" ];
      PartOf = [ "graphical-session.target" "hyprland-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.python3}/bin/python3 ${config.home.homeDirectory}/.config/hypr/scripts/quickshell/focustime/focus_daemon.py";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install.WantedBy = [ "graphical-session.target" "hyprland-session.target" ];
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
        "no_anim on, match:namespace ^(volume_osd)$"
        "no_anim on, match:namespace ^(brightness_osd)$"
        "no_anim on, match:namespace hyprpicker"
        "no_anim on, match:namespace qsdock"
        "blur on, match:namespace ext-session-lock"
        "ignore_alpha 0.2, match:namespace ext-session-lock"
      ];

      bind = [
        "SUPER, T, exec, $terminal"
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
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"

        "SUPER CTRL, Left, workspace, e-1"
        "SUPER CTRL, Right, workspace, e+1"
        "SUPER ALT, Left, workspace, e-1"
        "SUPER ALT, Right, workspace, e+1"

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
        "SUPER, S, exec, ~/.config/hypr/scripts/qs_manager.sh toggle calendar"
        "SUPER, N, exec, ~/.config/hypr/scripts/qs_manager.sh toggle network"
        "SUPER SHIFT, T, exec, ~/.config/hypr/scripts/qs_manager.sh toggle focustime"
        "SUPER, V, exec, ~/.config/hypr/scripts/qs_manager.sh toggle volume"
        "SUPER, H, exec, ~/.config/hypr/scripts/qs_manager.sh toggle guide"
        "SUPER, L, exec, bash ~/.config/hypr/scripts/lock.sh"
      ];

      bindl = [
        "SUPER SHIFT, P, exec, bash ~/.config/hypr/scripts/screenshot.sh"
        "SUPER, P, exec, bash ~/.config/hypr/scripts/screenshot.sh --full"
        ", unknown, exec, true"
        "SHIFT, unknown, exec, true"
        "SUPER, unknown, exec, true"
        "SUPER SHIFT, unknown, exec, true"
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
        "nm-applet"
        "/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1"
        "playerctld"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "swww-daemon"
        "sh -c 'sleep 0.5; swww img ${wallpaperPath}'"
      ];
    };

    extraConfig = ''
      submap = passthru
      bind = SUPER SHIFT CTRL ALT, F35, exec, true
      submap = reset
    '';
  };
}
