{ config, pkgs, ... }:
{
  # Используем специальный форк для Wayland
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    # Основные настройки режимов (вкладок)
    extraConfig = {
      modi = "drun,run,filebrowser,window";
      show-icons = true;
      display-drun = "APPS";
      display-run = "RUN";
      display-filebrowser = "FILES";
      display-window = "WINDOW";
      drun-display-format = "{name}";
      sidebar-mode = true; # Включает отображение вкладок снизу/сбоку
    };

    # Кастомная стилизация RASI под Nord и референс
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        # Цвета из вашего kitty.conf (Палитра Nord)
        bg = mkLiteral "#2e3440";
        bg-alt = mkLiteral "#3b4252";
        fg = mkLiteral "#d8dee9";
        accent = mkLiteral "#88c0d0"; # Nord Frost (Cyan)
        urgent = mkLiteral "#bf616a"; # Nord Aurora (Red)

        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg";
        font = "JetBrains Mono Nerd Font 11";
      };

      "window" = {
        width = mkLiteral "750px";
        height = mkLiteral "400px";
        border = mkLiteral "0px";
        border-radius = mkLiteral "12px";
        background-color = mkLiteral "@bg";
      };

      # Главный контейнер разделяет окно на левую и правую части
      "mainbox" = {
        orientation = mkLiteral "horizontal";
        children = map mkLiteral [ "left-pane" "listview" ];
      };

      # Левая панель под поиск, картинку и вкладки
      "left-pane" = {
        orientation = mkLiteral "vertical";
        width = mkLiteral "320px";
        # Путь к вашей фоновой картинке (замените на свой)
        background-image = mkLiteral "url(\"~/Wallpapers/nord-sunset.png\", min-contain)";
        expand = false;
        children = map mkLiteral [ "inputbar" "dummy" "sidebar" ];
      };

      # Поле поиска сверху левой панели
      "inputbar" = {
        padding = mkLiteral "12px";
        margin = mkLiteral "10px";
        background-color = mkLiteral "rgba(46, 52, 64, 0.6)"; # Полупрозрачный Nord bg
        border-radius = mkLiteral "8px";
        children = map mkLiteral [ "prompt" "entry" ];
      };

      "entry" = {
        placeholder = "Search...";
        placeholder-color = mkLiteral "#434c5e";
      };

      # Распорка, чтобы сдвинуть вкладки вниз панели
      "dummy" = {
        expand = true;
      };

      # Переключатели режимов (Вкладки: APPS, RUN...) снизу
      "sidebar" = {
        orientation = mkLiteral "horizontal";
        padding = mkLiteral "10px";
        background-color = mkLiteral "rgba(35, 39, 47, 0.5)";
      };

      "button" = {
        padding = mkLiteral "8px";
        margin = mkLiteral "0px 4px";
        border-radius = mkLiteral "6px";
        horizontal-align = mkLiteral "0.5";
      };

      "button selected" = {
        background-color = mkLiteral "@accent";
        text-color = mkLiteral "@bg";
      };

      # Правая панель со списком результатов
      "listview" = {
        padding = mkLiteral "12px";
        columns = 1;
        cycle = false;
        dynamic = true;
        layout = mkLiteral "vertical";
      };

      "element" = {
        padding = mkLiteral "8px 12px";
        border-radius = mkLiteral "6px";
        orientation = mkLiteral "horizontal";
        children = map mkLiteral [ "element-icon" "element-text" ];
        spacing = mkLiteral "10px";
      };

      "element-icon" = {
        size = mkLiteral "24px";
      };

      "element selected" = {
        background-color = mkLiteral "@bg-alt";
        text-color = mkLiteral "@accent";
      };
    };
  };
}