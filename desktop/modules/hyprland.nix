{ pkgs, ... }:

let
  sddmTheme = pkgs.stdenvNoCC.mkDerivation {
    pname = "qs-lock-sddm-theme";
    version = "1.0";
    src = ../configs/sddm/qs-lock;

    dontBuild = true;

    installPhase = ''
      theme_dir="$out/share/sddm/themes/qs-lock"
      mkdir -p "$theme_dir"
      cp -r . "$theme_dir"
      cp ${../../images/background.jpg} "$theme_dir/background.jpg"
    '';
  };
in
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;

    xwayland.enable = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "qs-lock";
    settings = {
      General.GreeterEnvironment = "QT_QML_DISABLE_DISK_CACHE=1";
      Theme.ThemeDir = "${sddmTheme}/share/sddm/themes";
    };
  };

  services.blueman.enable = true;

  # Нужно для file picker, screen sharing, Flatpak/порталов.
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  security.polkit.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    font-awesome
    comic-mono
    material-icons
    material-design-icons
    feather
  ];

  environment.systemPackages = with pkgs; [
    sddmTheme
    obs-studio
    # Терминал
    kitty
    # Оконный переключатель
    rofi
    # Утилита для работы с буфером обмена
    wl-clipboard
    # Утилита для скриншотов
    grim
    # Утилита для выбора области на экране
    slurp
    # Редактирование скриншотов
    swappy
    # Утилита для быстрой смены обоев рабочего стола
    hyprpaper
    # Утилита для экрана блокировки
    hyprlock
    # Утилита для управления бездействием
    hypridle
    # Утилита для изменения яркости экрана
    brightnessctl
    # Утилита для управления медиа плеером в консоли
    playerctl
    # Графический микшер громкости
    pavucontrol
    # Графический доступ к настройкам параметров сети
    nmgui
    # Графический агент аутентификации
    polkit_gnome
    # Файловый менеджер
    nautilus
    # Управление блютузом
    overskride
  ];
}
