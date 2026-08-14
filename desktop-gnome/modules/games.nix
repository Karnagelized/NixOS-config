{ pkgs, ... }:
let
  cleanAnimeGameLauncher = pkgs.symlinkJoin {
    name = "anime-game-launcher-clean";
    paths = [ pkgs.anime-game-launcher ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      rm -f $out/bin/anime-game-launcher
      makeWrapper ${pkgs.anime-game-launcher}/bin/anime-game-launcher $out/bin/anime-game-launcher \
        --unset WINEESYNC \
        --unset WINEFSYNC \
        --unset DXVK_ASYNC \
        --unset PROTON_USE_WINED3D

      desktop=$out/share/applications/anime-game-launcher.desktop
      if [ -e "$desktop" ]; then
        cp --remove-destination "$(readlink -f "$desktop")" "$desktop"
        sed -i "s|^Exec=.*|Exec=$out/bin/anime-game-launcher|" "$desktop"
      fi
    '';
  };
in
{
  # Настройка бинарного кеша
  nix.settings = {
    substituters = [ "https://ezkea.cachix.org" ];
    trusted-public-keys = [ "ezkea.cachix.org-1:ioBmOfvES3HfpQz21JECA36umBakM26VUe5fRc0dQ04=" ];
  };

  # Включаем лаунчер для Genshin Impact
  programs.anime-game-launcher = {
    enable = true;
    package = cleanAnimeGameLauncher;
  };

  # Отключаем минимизацию окна при потере фокуса
  environment.sessionVariables = {
    SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS = "0";
  };

  # Увеличиваем мягкое и жесткое значение дескрипторов
  security.pam.loginLimits = [
    { domain = "*"; type = "hard"; item = "nofile"; value = "1048576"; }
    { domain = "*"; type = "soft"; item = "nofile"; value = "1048576"; }
  ];

}
