{ pkgs, ... }:
{
  # Включение службы fprintd для работы со сканером
  # Не совместимо с Honor продукцией
  # services.fprintd.enable = true;
  # services.fprintd.tod.enable = true;

  # Драйвер (В Honor нет доступного драйвера)
  # services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;
  # Использование отпечатка пальца для подтверждения команд sudo в терминале
  # security.pam.services.sudo.fprintAuth = true;

  # Включение X11 windowing system
  services.xserver.enable = true;

  # Включение GNOME Desktop Environment
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
}
