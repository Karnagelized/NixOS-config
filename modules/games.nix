{ ... }:
{
  # Настройка бинарного кеша
  nix.settings = {
    substituters = [ "https://cachix.org" ];
    trusted-public-keys = [ "ezkea.cachix.org-1:ioBmOfvES3HfpQz21JECA36umBakM26VUe5fRc0dQ04=" ];
  };

  # Включаем лаунчер для Genshin Impact
  programs.anime-game-launcher.enable = true;

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
