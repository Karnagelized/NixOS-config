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

  # Переключение между приложениями и окнами
  # только внутри рабочего пространства
#  programs.dconf.profiles.user.databases = [
#    {
#      settings = {
#        "org/gnome/shell/app-switcher" = {
#          current-workspace-only = true;
#        };
#        "org/gnome/shell/window-switcher" = {
#          current-workspace-only = true;
#        };
#      };
#    }
#  ];
}
