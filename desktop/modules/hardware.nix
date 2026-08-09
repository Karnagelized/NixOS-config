{ ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Для Nvidia карт
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.open = true;

  # Для AMD карт
  # services.xserver.videoDrivers = [ "amdgpu" ];
}