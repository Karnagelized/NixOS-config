# Конфигурация NixOS с оболочкой GNOME

## Структура README
1. ...
2. ...
3. ...

## Архитектура файлов
```

TODO организовать визуально архитектуру конфигурации

```

## Установка NixOS
1. Установка NixOS с флешки или диска. В процессе установки необходимо подключение к интернету, иначе сборка системы не будет возможна. После установки необходимо создать пользователя и задать пароль root.
2. Установка дополнительных пакетов. `Требуется Flatpak, смотри пункт ниже!`
```shell

flatpak install gradience
```
## Установка Flatpak
1. Проверить что включен Flatpack `services.flatpak.enable = true;` в `gnome.nix`
2. Добавляем репозиторий Flathub
```shell

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```
3. Делаем ребилд системы через `nix-rebuild`

## Параметры
1. `flake [путь]`

Нужен для нахождения точки фхода flake.nix и последующей сборки системы. Путь указывается до папки с точкой входа и именем хоста, которые прописаны в default.nix.

```
--flake .#maksim
```

2. ...


## Secret параметры
Секретные параметры находятся в папке secrets/. Необходимо создать все файлы без расширения .example и вписать необходимые данные, иначе не создавать секретный файл вовсе.

```
1. proxy.nix - Хранит URL адресс для подключения к Proxy Server
```

## Проверка конфигурации
Для проверки корректности конфигурации можно вывести список всех flake в директории по заданному пути.

```
>>> nix --extra-experimental-features flakes --extra-experimental-features nix-command flake show .

path:/home/maksim/Desktop/nixos-config?lastModified=1779988771&narHash=sha256-F%2BTtVL5j%2BfjfgnOiRHzg2Viuvse/PQe4NXbrQ%2BmoGwY%3D
└───nixosConfigurations
    └───maksim: NixOS configuration
```

## Билд конфигурации
Билд осуществяется под хостом maksim, с добавленными параметрами конфигурации Nix для разрешения пользования flakes.

```
>>> sudo env NIX_CONFIG="experimental-features = nix-command flakes" nixos-rebuild build --flake .#maksim

Done. The new configuration is /nix/store/18ppbrvlhmjr8jba6gdp0ms58nis63s5-nixos-system-maksim-25.11.20260526.25f5383
```

## Проверка конфигурации в runtime test режиме
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

## Перекючение на готовую обновленную сборку
```
sudo nixos-rebuild switch --flake .#maksim
```
