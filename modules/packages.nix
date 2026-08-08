{ pkgs, ... }:

let
  # Темы и иконки
  themeAndIcon = with pkgs; [
    # Иконки
    reversal-icon-theme
    # Курсор
    nordzy-cursor-theme
  ];

  # Пакеты программ
  programsPackages = with pkgs; [
  	zed-editor
  	filezilla
  	github-desktop
  	obsidian
  	postman
    telegram-desktop
  	onlyoffice-desktopeditors
  	# Приложения для работы с паролями
  	authenticator
  	# Переводчик
  	dialect
  	# Извлечение текста со скрина
  	gnome-frog
  	# Торрент
  	fragments
  	# Хром
  	google-chrome
  	figma-linux
  	zoom-us
    # Клиент для Samsung Buds
    galaxy-buds-client
    # Замена стандартного приложения с погодой
    mousam
  ];

  # Пакеты для работы с БД
  databasePackages = [
  	pkgs.mongodb-ce
  	pkgs.mongodb-compass
  	pkgs.sqlitestudio
    pkgs.postgresql
    pkgs.pgadmin4-desktopmode
  ];

  # Утилиты
  utilsPackages = with pkgs; [
    # Медиаплеер общего назначения, зависимость для Lofi
    mpv
   	# Получения файлов с использованием протоколов HTTP, HTTPS и FTP.
   	wget
    # Настройки рабочего окружения
    gnome-tweaks
    # Настройки экрана входа GNOME
    gdm-settings
    # Состояние железа в консоли
    btop
    # Статистика по USB устройствам
    usbutils
    codex
  	docker
    # UI для докера
    lazydocker
  	python3
  	# NodeJS
  	elmPackages.nodejs
    # Оверлей для проверки нагрузок CPU GPU RAM MEM
    mangohud
    # Lofi Музыка
    lowfi
    # Закругленные окна приложений
    # picom
    # Кастомный бар
    eww
  ];

  # Расширения
  extensionsPackages = with pkgs; [
    # Буфер обмена
    gnomeExtensions.copyous
    # Блюр панелей и т.д.
    gnomeExtensions.blur-my-shell
    # Кастомная нижняя панель
    gnomeExtensions.dash-to-panel
    # Настройки рабочего окружения
    gnomeExtensions.just-perfection
    # Отображение значения громкости
    gnomeExtensions.osd-volume-number
    # Изменения эффекта открытия окон
    gnomeExtensions.burn-my-windows
    # Нечеткий поиск приложений
    gnomeExtensions.fuzzy-application-search
    # Добавляет в левый верхний угол иконку с меню
    gnomeExtensions.logo-menu
    # Color Picker
    gnomeExtensions.color-picker
    # Виджеты
    gnomeExtensions.desktop-clock
    # Привязка приложений по рабочим столам
    # (Отключено из-за неудобств)
    # gnomeExtensions.smart-auto-move-ng
    # Вынес аудио настроек в меню
    gnomeExtensions.quick-settings-audio-panel
    # Убирает уведомление "Окно готово"
    gnomeExtensions.grand-theft-focus
    # Убирает старые заголовки окон
    # gnomeExtensions.unite
    # Добавляет пользовательские темы
    gnomeExtensions.user-themes
    # Тайлинговое расширение для гридовой сетки
    gnomeExtensions.tiling-shell
  ];
in {
  imports = [ ./happ/happ-module.nix ];
  # Happ client
  services.happ.enable = true;

  # Разрешение на установку не бесплатных пакетов
  nixpkgs.config.allowUnfree = true;

  # Слияние всех пакетов в одно окружение
  environment.systemPackages =
    themeAndIcon
    ++ programsPackages
    ++ databasePackages
    ++ utilsPackages
    ++ extensionsPackages;

  # Отключение предустановленных пакетов Gnome
  environment.gnome.excludePackages = with pkgs; [
    # Экскурсии
    gnome-tour
    # Контакты
    gnome-contacts
    # Веб-браузер
    epiphany
    # Карты
    gnome-maps
    # Подключения
    gnome-connections
    # Справка
    yelp
    # Почта
    geary
    # Символы
    gnome-characters
    # Музыка
    gnome-music
    # Погода
    gnome-weather
  ];

  # Отключение предустановленных пакетов Сервера
  services.xserver.excludePackages = with pkgs; [
    xterm
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
