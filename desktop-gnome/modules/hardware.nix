{ pkgs, ... }:
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
}
