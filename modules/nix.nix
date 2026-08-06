{ ... }:
{
  # Автоматическое удаление старых пакетов и сборок Nix
  # Удаление происходит каждую неделю для сборок старше 30 дней
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
