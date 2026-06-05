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
  	authenticator
  	# Переводчик
  	dialect
  	# Извлечение текста со скрина
  	gnome-frog
  	# Торрент
  	fragments
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
  extensionsPackages = [
    # Буфер обмена
    gnomeExtensions.clipboard-indicator
    # Блюр панелей и т.д.
    gnomeExtensions.blur-my-shell
    # Кастомная нижняя панель
    gnomeExtensions.dash-to-dock
    # Добавление скорости интернета на панель
    gnomeExtensions.internet-speed-meter
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
