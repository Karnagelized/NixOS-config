{ pkgs, ... }:
{
  # Включение печати через CUPS
  services.printing = {
    enable = true;
    drivers = [
      pkgs.brgenml1cupswrapper
      pkgs.brgenml1lpr
    ];
  };

  # Добавляем поддержку сканера
  hardware.sane = {
    enable = true;
    # Включаем драйвер Brother
    brscan5 = {
      enable = true;
      netDevices = {
        BrotherScanner = {
          model = "DCP-9020CDW";
          ip = "192.168.000.247";
        };
      };
    };

    # Сетевое сканирование
    extraBackends = [ pkgs.sane-airscan ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
