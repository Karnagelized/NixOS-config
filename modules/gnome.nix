{ pkgs, ... }:
{
  # Включение службы fprintd для работы со сканером
  # Не совместимо с Honor продукцией
  services.fprintd.enable = false;
  services.fprintd.tod.enable = false;
  # Драйвер (В Honor нет доступного драйвера)
  # services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;
  # Использование отпечатка пальца для подтверждения команд sudo в терминале
  security.pam.services.sudo.fprintAuth = false;

  # Включение X11 windowing system
  services.xserver.enable = true;

  # Включение GNOME Desktop Environment
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  programs.dconf.enable = true;

  # Отключаем автоматический сон на экране GDM
  systemd.tmpfiles.rules = [
    "d /var/lib/gdm/.config 0711 gdm gdm - -"
  ];

  programs.dconf.profiles.gdm = {
    databases = [
      {
        settings = {
          "org/gnome/settings-daemon/plugins/power" = {
            "sleep-inactive-ac-type" = "nothing";
            "sleep-inactive-battery-type" = "nothing";
          };
        };
      }
    ];
  };

  # Включение поддержки Flatpak для установки приложений
  services.flatpak.enable = true;
}
