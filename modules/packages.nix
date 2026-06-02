{ pkgs, ... }:
{
  imports = [
    ./git/git.config.nix
  ];

  # Разрешение на установку не бесплатных пакетов
  nixpkgs.config.allowUnfree = true;

  # Пакеты программ
  environment.systemPackages = with pkgs; [
  	git
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
  ];

  # Пакеты для работы с БД
  environment.systemPackages = with pkgs; [
  	# mongodb Долгая загрузка
  	mongodb-compass
  	sqlitestudio
  	postgresql
  	pgadmin4
  ];

  # Утилиты
  environment.systemPackages = with pkgs; [
    # Для вывода информации в консоль
    neofetch
    btop
  	docker
  	python3
  ];

  # Расширения
  environment.systemPackages = with pkgs; [
    # Буфер обмена
    gnomeExtensions.clipboard-indicator
    # Блюр панелей и т.д.
    gnomeExtensions.blur-my-shell
    # Кастомная нижняя панель
    gnomeExtensions.dash-to-dock
    # Закругление углов окон и панелей
    gnomeExtensions.panel-corners
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
