{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;

    xwayland.enable = true;
  };

  # Нужно для file picker, screen sharing, Flatpak/порталов.
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    # Терминал
    kitty
    # Оконный переключатель
    rofi
    # Панель состояния
    waybar
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
  ];
}