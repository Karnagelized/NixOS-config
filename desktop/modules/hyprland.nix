{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;

    xwayland.enable = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

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
    # Терминал
    kitty
    # Оконный переключатель
    rofi
    # Панель состояния
    eww
    # Демон для уведомлений
    mako
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
    networkmanagerapplet
    # Графический агент аутентификации
    polkit_gnome
    # CLI для уведомлений eww/widgets
    libnotify
    # Получение погодных данных для eww
    curl
    # JSON parser для оригинальных eww weather/quotes scripts
    jq
    # ALSA mixer, используется оригинальными eww volume scripts
    alsa-utils
    # MPD client, используется оригинальным dashboard music widget
    mpc
    # Обложки треков MPD в dashboard
    ffmpeg
    # Todo/appointments widgets из оригинального dashboard
    todo-txt-cli
    calcurse
    # Блокировка и bspc-команды, ожидаемые оригинальным Tokyo eww
    betterlockscreen
    bspwm
    # Файловый менеджер
    nautilus
  ];
}
