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
  ];

  # Для домашнего сервера
  homeServerPackages = with pkgs; [
    # БД для получения дампа паролей
    keepassxc
    # Приложение для менеджмента паролей
    bitwarden-desktop
    # Генератор ключей
    age
  ];

  # Пакеты программ (Стабильная ветка)
  programsPackages = with pkgs; [
  	zed-editor
  	filezilla
  	obsidian
    jetbrains.pycharm
    onlyoffice-desktopeditors
  	# Приложения для работы с паролями
  	authenticator
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
    # UI для докера приложением
    podman-desktop
    obs-studio
    # Аналог Rufus для загрузочных флешек
    mediawriter
    # Скачивание видео по ссылке
    parabolic
  ];

  # Пакеты программ (Нестабильная ветка)
  unstablePackages = with pkgs-unstable; [
    telegram-desktop
    postman
  ];

  # Пакеты для работы с БД
  databasePackages = [
  	pkgs.mongodb-ce
  	pkgs-stable.mongodb-compass
  	pkgs.sqlitestudio
    pkgs.postgresql
    pkgs.dbeaver-bin
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
    (btop.override { cudaSupport = true; })
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
  	nest-cli
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
    # Терминал для подключения по SSH
    # Был установлен для конвертации SSH ключа в PPK формат
    putty
    # Получение информации о состоянии диска
    qdiskinfo
  ];

  # Расширения
  extensionsPackages = with pkgs; [
    # Буфер обмена
    gnomeExtensions.copyous
    # Блюр панелей и т.д.
    gnomeExtensions.blur-my-shell
    # Кастомная панель
    gnomeExtensions.dash-to-dock
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
  # Нестабильные пакеты - исключения
  nixpkgs.config.permittedInsecurePackages = [
    "electron-41.10.7"
  ];

  # Настройка модуля Throne с поддержкой TUN режима
  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };

  programs.happ = {
    enable = true;
    tunMode.enable = true;
  };

  # Разрешение на установку не бесплатных пакетов
  nixpkgs.config.allowUnfree = true;

  # Слияние всех пакетов в одно окружение
  environment.systemPackages =
    themeAndIcon
    ++ studyPackages
    ++ homeServerPackages
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
    # Пароли и ключи
    seahorse
  ];

  # Отключение предустановленных пакетов Сервера
  services.xserver.excludePackages = with pkgs; [
    xterm
  ];
}
