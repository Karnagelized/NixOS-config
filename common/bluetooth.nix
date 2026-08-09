{ pkgs, ... }:
{
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        # Включает отображение заряда батареи
        Experimental = true;
      };
    };
  };
}
