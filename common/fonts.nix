{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom.fontPackages = lib.mkOption {
    type = lib.types.listOf lib.types.package;
    default = [ ];
    description = "Шрифты системы и OnlyOffice";
  };

  config = {
    custom.fontPackages = with pkgs; [
      corefonts
      meslo-lgs-nf
    ];

    fonts.packages = config.custom.fontPackages;
  };
}
