{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;

    settings = {
      # Настройки шрифтов
      font_family      = "JetBrains Mono";
      bold_font        = "auto";
      italic_font      = "auto";
      bold_italic_font = "auto";
      font_size        = "11.0";

      # Настройки курсора
      cursor                       = "#7cd5be";
      cursor_text_color            = "#2e3440";
      cursor_stop_blinking_after   = 0;
      cursor_trail                 = 1;
      cursor_trail_decay           = "0.05 0.1";
      cursor_trail_start_threshold = 3;
      cursor_trail_color           = "#7cd5be";

      # История прокрутки и полоса прокрутки
      scrollback_lines              = -1;
      scrollbar_width               = "0.6";
      scrollbar_hover_width         = "0.6";
      scrollbar_handle_opacity      = "0.3";
      scrollbar_radius              = "0.5";
      scrollbar_gap                 = "0.3";
      scrollbar_hitbox_expansion    = "0.5";
      scrollbar_track_hover_opacity = "0.1";
      scrollbar_handle_color         = "#0d73cc";
      scrollbar_track_color          = "#96c2e8";

      # Настройки прокрутки колесиком мыши и тачпадом
      wheel_scroll_multiplier = "5.0";
      wheel_scroll_min_lines  = 1;
      touch_scroll_multiplier = "1.0";

      # Настройки мыши
      mouse_hide_wait         = "3.0";
      url_color               = "#0087bd";
      url_style               = "curly";
      show_hyperlink_targets  = "ctrl";

      # Цвета границ окон
      active_border_color = "#0d73cc";

      # Цветовая схема (Тема Nord + Мятный)
      background           = "#2e3440";
      foreground           = "#d8dee9";
      selection_background = "#434c5e";

      color0  = "#3b4252"; # Чёрный
      color1  = "#bf616a"; # Красный
      color2  = "#7cd5be"; # Зелёный
      color3  = "#ebcb8b"; # Жёлтый
      color4  = "#81a1c1"; # Синий
      color5  = "#b48ead"; # Пурпурный
      color6  = "#88c0d0"; # Голубой
      color7  = "#e5e9f0"; # Белый
      color10 = "#7cd5be"; # Яркий зелёный

      # Панель вкладок
      tab_bar_edge        = "bottom";
      tab_bar_style       = "powerline";
      tab_powerline_style = "slanted";
      tab_bar_align       = "start";

      # Шаблоны заголовков вкладок
      tab_title_template        = "{index} ~ {tab.active_wd.split('/')[-1]}";
      active_tab_title_template = "{index} ~ {tab.active_wd.split('/')[-1]}";

      # Цвета панели вкладок
      active_tab_foreground   = "#2e3440";
      active_tab_background   = "#7cd5be";
      active_tab_font_style   = "bold";
      inactive_tab_foreground = "#d8dee9";
      inactive_tab_background = "#3b4252";
      inactive_tab_font_style = "normal";
      tab_bar_background      = "#2e3440";

      # Украшения окна и отступы
      hide_window_decorations = "yes";
      window_padding_width    = 5;
    };

    # Секция горячих клавиш
    keybindings = {
      # Управление вкладками
      "alt+t"             = "new_tab";
      "alt+w"             = "close_tab";
      "alt+shift+left"    = "move_tab_backward";
      "alt+shift+right"   = "move_tab_forward";

      # Перемещение между окон-сплитами
      "alt+left"          = "neighboring_window left";
      "alt+right"         = "neighboring_window right";
      "alt+up"            = "neighboring_window up";
      "alt+down"          = "neighboring_window down";

      # Создание и закрытие окон-сплитов
      "alt+enter"         = "new_window";
      "alt+q"             = "close_window";

      # Умная очистка терминала без артефактов прокрутки
      "ctrl+l"            = "clear_terminal to_cursor_scroll active";
    };
  };
}