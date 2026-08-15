# Desktop версия конфигурации NixOS
## О системе
DE: -
Оконный менеджер: Hyprland
Композитор: Wayland


## Архитектура
```text
desktop
├── base
│   └── hardware-configuration.nix
├── configs
│   ├── fastfetch.config.nix
│   ├── git.config.nix
│   └── zsh.config.nix
├── exports
│   └── p10k.zsh
├── modules
│   ├── games.nix
│   ├── hardware.nix
│   ├── hyprland.config.nix
│   ├── hyprland.nix
│   ├── packages.nix
│   └── steam.nix
└── README.md
```

`base:`
* `hardware-configuration.nix` - Конфигурация томов домашнего ПК

`configs:`
* `fastfetch.config.nix` - Конфигурация для fastfetch
* `git.config.nix` - Конфигурация для Git
* `gnome-binds.config.nix` - Конфигурация для кастомных шоркадов GNOME
* `zsh.config.nix` - Конфигурация для zsh

`exports:`
* `p10k.zsh` - Экспорт конфигурации для плагина p10k.zsh

`modules:`
* `games.nix ` - Отвечает за хранение конфигурации игр
* `hardware.nix ` - Отвечает за хранение конфигурации железа (Процессор, видеокарта и прочее)
* `hyprland.config.nix` - Отвечает за хранение конфигурации Hyprland
* `hyprland.nix` - Отвечает за хранение первоначальную настройку менеджера Hyprland
* `packages.nix` - Отвечает за установку необходимого ПО и расширений для пользования Hyprland
* `steam.nix` - Отвечает за установку и настройку Steam


## Настройка модулей
### Hardware модуль
В `modules/hardware.nix` необходимо настроить драйвера для видеокарты.


## Настройка расширений
[//]: # (TODO сделать декларативным установку всех конфигураций расширений)
Отсутствуют
