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

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
