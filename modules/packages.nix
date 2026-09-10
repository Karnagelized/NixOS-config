{ pkgs, pkgs-stable, pkgs-unstable, ... }:

let
  # Темы и иконки
  themeAndIcon = with pkgs; [
    # Иконки
    reversal-icon-theme
    # Курсор
    nordzy-cursor-theme
  ];

  # Для учебы
  studyPackages = with pkgs; [
    rstudio
    libreoffice-fresh
  ];

  # Пакеты программ (Стабильная ветка)
  programsPackages = with pkgs; [
  	zed-editor
  	filezilla
  	obsidian
  	postman
    jetbrains.pycharm
    # Отключен из-за учебного пакета libreoffice-fresh
    # onlyoffice-desktopeditors
  	# Приложения для работы с паролями
  	authenticator
  	# Переводчик
  	dialect
  	# Извлечение текста со скрина
  	normcap
  	# Торрент
  	fragments
  	google-chrome
  	figma-linux
  	zoom-us
    # Клиент для Samsung Buds
    galaxy-buds-client
    # Платформа для игр
    lutris
    # Аналог paint
    pinta
    # Аналог фотошоп
    krita
  ];

  # Пакеты программ (Нестабильная ветка)
  unstablePackages = with pkgs-unstable; [
    telegram-desktop
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
    # Архиватор/Разорхиватор
    unzip
    atool
    # === Улучшение терминала === #
    # Красивый вывод папок
    eza
    # Интерактивное подключение по SSH
    lazyssh
    # Поисковик содержимого
    ripgrep
    # Превью кода
    bat
    # Мониторинг производительности
    mangohud
  ];

  # Расширения
  extensionsPackages = with pkgs; [
    # Буфер обмена
    gnomeExtensions.copyous
    # Блюр панелей и т.д.
    gnomeExtensions.blur-my-shell
    # Кастомная панель
    gnomeExtensions.dash-to-dock
    # Скрытие верхней панели GNOME
    gnomeExtensions.hide-top-bar
    # Слайд-шоу заднего фона
    gnomeExtensions.wallpaper-slideshow
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
    # Добавляет пользовательские темы
    gnomeExtensions.user-themes
  ];
in {
  # Настройка модуля Throne с поддержкой TUN режима
  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };

  # Разрешение на установку не бесплатных пакетов
  nixpkgs.config.allowUnfree = true;

  # Слияние всех пакетов в одно окружение
  environment.systemPackages =
    themeAndIcon
    ++ studyPackages
    ++ programsPackages
    ++ unstablePackages
    ++ databasePackages
    ++ utilsPackages
    ++ extensionsPackages;

  # Отключение предустановленных пакетов Gnome
  environment.gnome.excludePackages = with pkgs; [
    # Терминал
    gnome-terminal
    gnome-console
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
  ];

  # Отключение предустановленных пакетов Сервера
  services.xserver.excludePackages = with pkgs; [
    xterm
  ];
}
