{ pkgs, ... }:
{
  # Включение службы fprintd для работы со сканером
  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  # Драйвер
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;
  # Использование отпечатка пальца для подтверждения команд sudo в терминале
  security.pam.services.sudo.fprintAuth = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Включение поддержки Flatpak для установки приложений
  services.flatpak.enable = true;
}
