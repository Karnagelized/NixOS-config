{ ... }:
{
  # Глобальная настройка для дисплей-менеджеров
  console.useXkbConfig = true;

  # Конфигурация переключений раскладки в X11
  services.xserver.xkb = {
    layout = "us,ru";
    variant = "";
    options = "grp:win_space_toggle";
  };
}
