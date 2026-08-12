{ config, pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      libvdpau-va-gl
      libva-vdpau-driver
    ];
  };

  # Для Nvidia карт
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement.enable = true;

    # Для GTX 10xx и старше нужно заменить на false.
    open = false;
  };

  boot.kernelParams = [
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];

  environment.sessionVariables = {
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    vulkan-tools
    libva-utils
    nvtopPackages.nvidia
  ];

  # Для AMD карт
  # services.xserver.videoDrivers = [ "amdgpu" ];
}
