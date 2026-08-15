# Desktop версия конфигурации NixOS

## О системе
DE: Gnome (Все из коробки)
Композитор: Mutter

## Архитектура
```text
desktop-gnome/
├── base/
│   └── hardware-configuration.nix
├── configs/
│   ├── fastfetch.config.nix
│   ├── git.config.nix
│   ├── gnome-binds.config.nix
│   └── zsh.config.nix
├── exports/
│   └── p10k.zsh
├── modules/
│   ├── gnome.nix
│   ├── hardware.nix
│   ├── keyboard.nix
│   └── packages.nix
├── scripts/
│   └── work-layout
└── README.md
```

`base:`
* `hardware-configuration.nix` - Конфигурация томов ПК

`configs:`
* `fastfetch.config.nix` - Конфигурация для fastfetch
* `git.config.nix` - Конфигурация для Git
* `gnome-binds.config.nix` - Конфигурация для кастомных шорткадов GNOME
* `zsh.config.nix` - Конфигурация для zsh

`exports:`
* `dashToPanel-config` - Экспорт конфигурации для плагина dashToPanel
* `desktop-widget` - Экспорт конфигурации для плагина desktop-widget
* `p10k.zsh` - Экспорт конфигурации для плагина p10k.zsh

`modules:`
* `gnome.nix ` - Отвечает за хранение GNOME конфигурации
* `hardware.nix ` - Отвечает за хранение конфигурации железа (Процессор, видеокарта и прочее)
* `keyboard.nix` - Отвечает за хранение конфигурации клавиатуры
* `packages.nix` - Отвечает за установку необходимого ПО и расширений для пользования GNOME

`scripts:`
* `work-layout` - Отвечает за открытие приложений для работы


## Настройка системы
* Переходим в настройки и включаем Английскую раскладку во вкладке `Клавиатура`.


## Настройка модулей
### Binds модуль
Позволяет делать кастомные бинды. Для этого необходимо добавить в `custom-keybindings` новую строку с `+1` индексом.
Далее прописывается бинд по аналогии:

```text
"org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
  name = "Open Terminal";
  command = "kgx";
  binding = "<Super>t";
};
```


### Hardware модуль (Опционально)
В `modules/hardware.nix` необходимо настроить драйвера для видеокарты.


## Настройка расширений
[//]: # (TODO сделать декларативным установку всех конфигураций расширений)
### Quick Settings Audio Panel
* Always show microphone volume slider -> On
* Remove the main output volume slider -> On
* Show the currently selected device for the main volume sliders -> On
* Speaker / Headphone volume slider -> Off
* Media controls -> Off
