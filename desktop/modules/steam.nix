{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;

    # Проброс папки в окружение Steam
    package = pkgs.steam.override {
      extraBwrapArgs = [
        "--bind /mnt/storage /mnt/storage"
      ];
    };
  };

  programs.gamemode.enable = true;
}
