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

  # Для Nvidia карт
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.open = true;

  # Включение GNOME Desktop Environment
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
}
