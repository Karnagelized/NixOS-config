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
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Для Nvidia карт
  # services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.nvidia.modesetting.enable = true;
  # hardware.nvidia.nvidiaSettings = true;
  # hardware.nvidia.open = true;

  # Для AMD карт
  # services.xserver.videoDrivers = [ "amdgpu" ];

  # Включение GNOME Desktop Environment
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
}
