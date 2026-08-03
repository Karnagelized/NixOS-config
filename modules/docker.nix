{ ... }:
{
  # Включает фоновую службу Docker и ставит саму утилиту
  virtualisation.docker.enable = true;

  # Дает вашему пользователю доступ к сокету Docker без sudo
  users.users.maksim.extraGroups = [ "docker" ];
}