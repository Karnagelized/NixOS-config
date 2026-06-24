{ pkgs, ... }:

let
  # Пакеты программ
  programsPackages = with pkgs; [
  	sublime3
  	filezilla
  	github-desktop
  	obsidian
  	postman
  	# figma-linux
  	onlyoffice-desktopeditors
  	# Приложения для работы с паролями
  	authenticator
  	# Переводчик
  	dialect
  	# Извлечение текста со скрина
  	gnome-frog
  	# Настройки рабочего окружения
  	gnome-tweaks
  	# Торрент
  	fragments
  	# Хром
  	chromium
  ];

  # Пакеты для работы с БД
  databasePackages = with pkgs; [
  	# mongodb Долгая загрузка
  	mongodb-compass
  	sqlitestudio
  	postgresql
  	pgadmin4
  ];

  # Утилиты
  utilsPackages = with pkgs; [
    btop
  	docker
  	python3
  ];

  # Расширения
  extensionsPackages = with pkgs; [
    # Буфер обмена
    gnomeExtensions.clipboard-indicator
    # Блюр панелей и т.д.
    gnomeExtensions.blur-my-shell
    # Кастомная нижняя панель
    gnomeExtensions.dash-to-dock
    # Добавление скорости интернета на панель
    # gnomeExtensions.internet-speed-meter
    # Разворот окна на весь рабочий стол
    # gnomeExtensions.maximize-to-empty-workspace не совместимо
    # Датчики на панели задач
    # gnomeExtensions.freon не совместимо
    # Настройки рабочего окружения
    gnomeExtensions.just-perfection
    # Отображение значения громкости
    gnomeExtensions.osd-volume-number
    # Подключение Android устройств
    gnomeExtensions.gsconnect
    # Копирование эмодзи в буфер обмена
    gnomeExtensions.emoji-copy
    # Изменения эффекта открытия окон
    gnomeExtensions.burn-my-windows
    # Показ нагрузки на систему
    gnomeExtensions.vitals
    # Погода на панели задач
    gnomeExtensions.weather-oclock
  ];
in {
  # Разрешение на установку не бесплатных пакетов
  nixpkgs.config.allowUnfree = true;

  # Слияние всех пакетов в одно окружение
  environment.systemPackages =
    programsPackages
    ++ databasePackages
    ++ utilsPackages
    ++ extensionsPackages;

  # Отключение предустановленных пакетов
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
    # XTerm
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
