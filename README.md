# Конфигурация NixOS с окружением GNOME с использованием flake

Открытый конфигурационный файл для установки NixOS с окружением GNOME. Все пакеты, зависимости и прочее устанавливаются через flake.
Любая `правка системы, пакета и другого, должна быть отражена в конфигурационном файле` (Кроме моментов с пиратскими или ломанными приложениями).

## Архитектура файлов
Актуальна на момент `05.08.2026`
```
├── base
│   ├── configuration.nix
│   └── hardware-configuration.nix
├── hosts
│   ├── maksim
│   │   ├── configs
│   │   │   ├── fastfetch.config.nix
│   │   │   ├── git.config.nix
│   │   │   └── zsh.config.nix
│   │   └── default.nix
│   └── root
│       ├── default.nix
│       └── hardware-configuration.nix
├── images
│   └── background.jpg
├── modules
│   ├── bluetooth.nix
│   ├── docker.nix
│   ├── fonts.nix
│   ├── gnome.nix
│   ├── keyboard.nix
│   ├── libs.nix
│   ├── location.nix
│   ├── network.nix
│   ├── nix.nix
│   ├── packages.nix
│   ├── printing.nix
│   └── sound.nix
├── utils
│   └── p10k.zsh
├── .gitignore
├── flake.lock
├── flake.nix
└── README.md
```

# Установка NixOS
Для установки NixOS потребуется флешка или диск с образом системы. В данном репозитории `рассматривается случай установки образа с GUI`. Для записи образа на флешку или диск потребуется программа [Rufus](https://rufus.ie/ru/)

В процессе установки необходимо подключение к интернету, иначе сборка системы не будет возможна. В процессе установки требуется выбрать окружением GNOME, в остальном процесс установки не должен вызывать трудности.

## Установка Flatpak
1. Проверить что включен Flatpack `services.flatpak.enable = true;` в `gnome.nix`
2. Добавляем репозиторий Flathub
```shell

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```
3. Делаем ребилд системы через `nix-rebuild`

## Установка дополнительных пакетов
Для установки `дополнительных` пакетов требуется Flatpak.
```shell

# Используется для изменений системных цветов
flatpak install gradience
```

---

# Ребилд системы относительно файла конфигурации flake
Для выполнения команд с конфигурацией flake, нужно чтобы Пользователь был в корневой директории flake конфигурации.

## Проверка конфигурации
Для проверки корректности конфигурации можно вывести список всех flake в директории по заданному пути.

```
>>> nix --extra-experimental-features flakes --extra-experimental-features nix-command flake show .

path:/home/maksim/Desktop/nixos-config?lastModified=1779988771&narHash=sha256-F%2BTtVL5j%2BfjfgnOiRHzg2Viuvse/PQe4NXbrQ%2BmoGwY%3D
└───nixosConfigurations
    └───maksim: NixOS configuration
```

## Билд конфигурации
### Проверка до установки flake конфигурации
Билд осуществляется под хостом maksim, с добавленными параметрами конфигурации Nix для разрешения пользования flakes.

```
>>> sudo env NIX_CONFIG="experimental-features = nix-command flakes" nixos-rebuild build --flake .#maksim

Done. The new configuration is /nix/store/18ppbrvlhmjr8jba6gdp0ms58nis63s5-nixos-system-maksim-25.11.20260526.25f5383
```

### Проверка после установки flake конфигурации
После установки flake конфигурации появится `alias` для проверки конфигурации
```
nix-rebuild
```

## Проверка конфигурации в runtime test режиме
### Проверка до установки flake конфигурации
```
>>> sudo nixos-rebuild test --flake .#maksim

building the system configuration...
stopping the following units: accounts-daemon.service, avahi-daemon.service, avahi-daemon.socket
activating the configuration...
setting up /etc...
reloading user units for maksim...
restarting sysinit-reactivation.target
reloading the following units: dbus.service
restarting the following units: nix-daemon.service, polkit.service
starting the following units: accounts-daemon.service, avahi-daemon.socket
the following new units were started: NetworkManager-dispatcher.service, sysinit-reactivation.target, systemd-tmpfiles-resetup.service
Done. The new configuration is /nix/store/18ppbrvlhmjr8jba6gdp0ms58nis63s5-nixos-system-maksim-25.11.20260526.25f5383
```

### Проверка после установки flake конфигурации
После установки flake конфигурации появится `alias` для проверки конфигурации
```
nix-rebuild-test
```

## Переключение на готовую обновленную сборку
```
sudo nixos-rebuild switch --flake .#maksim
```