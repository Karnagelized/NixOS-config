{ pkgs, pkgs-stable, ... }:

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
  	pkgs-stable.mongodb-compass
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
  	python313Packages.pip
  	# NodeJS
  	elmPackages.nodejs
    # Lofi Музыка
    lowfi
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
    # Вынес аудио настроек в меню
    gnomeExtensions.quick-settings-audio-panel
    # Убирает уведомление "Окно готово"
    gnomeExtensions.grand-theft-focus
    # Добавляет пользовательские темы
    gnomeExtensions.user-themes
  ];
in {
  imports = [
    ../../common/happ/happ-module.nix
  ];

  # Happ клиент
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
}
