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
```


# Установка NixOS
## Шаг 1 - `Создание образа NixOS`
Для установки NixOS потребуется флешка или диск с образом системы. В данном репозитории `рассматривается случай установки образа с GUI`. Для записи образа на флешку или диск потребуется программа [Rufus](https://rufus.ie/ru/)

В процессе установки необходимо подключение к интернету, иначе сборка системы не будет возможна. В процессе установки требуется выбрать окружением GNOME, в остальном процесс установки не должен вызывать трудности.


## Шаг 2 - `Установщик NixOS`
* Когда будет выполнен вход в установщик, если хотите прочитать надписи, нужно двигать стрелочками вверх вниз, иначе система загрузится по первой строке.
Вставляем флешку в ПК, входим в BOOT меню и выбираем флешку с установщиком NixOS.
После появляется окно с выбором оболочки. Текущая конфигурация под настройку `GNOME LTS`.


## Шаг 3 - `Настройка NixOS в установщике`
Настройка NixOS Installer.
* В окне `Welcome` выбираем язык `русский`.
* Пункт `Местоположение` должен определить расположение как `Екатеринбург`. Язык и формат дат `Россия`.
* В пункте `Клавиатура` выбираем `Generic 105-key PC` `Russian -> Default`. Переключение раскладки на `Win + space`
* Пункт `Пользователи` заполняются на усмотрение Пользователя.
  (Для Администратора лучше использовать тот же пароль, что и для входа)
* В `DE` выбираем `GNOME`
* `Unfree software` ставим галочку
* В пункте `Разделы` выбрать диск куда установится система. Подробнее про разметку дисков, смотри ниже в `Монтирование дисков`.
* В `Сводке` можно проверить достоверность выбранных ранее пунктов. После нажимаем `Установить`.
* Нажимаем галочку `Перезагрузить` и `Готово`
* После загрузки системы, можно вытащить загрузочную флешку.


## Шаг 4 - `Настройка GNOME`
Переходим в настройки и включаем Английскую раскладку во вкладке `Клавиатура`.

Далее нам нужно клонировать текущий проект для дальнейшей настройки - команда `nix-shell -p git` позволит создать
изолированную среду с командами `git` для клонирования.

После успешного клонирования репозитория, необходимо заменить файл `hosts/root/hardware-configuration.nix` на
актуальный из системы через команды:

```shell
# Копирование базовой конфигурации настроек разметки дисков
cp //etc/nixos/hardware-configuration.nix ~/Desktop/Projects/НАЗВАНИЕ ПАПКИ/hosts/root/
cp //etc/nixos/hardware-configuration.nix ~/Desktop/Projects/НАЗВАНИЕ ПАПКИ/base/

# Копирование базовой конфигурации настроек nix
cp //etc/nixos/configuration.nix ~/Desktop/Projects/НАЗВАНИЕ ПАПКИ/base/
```

Для удобства можно создать отдельную ветку и туда сбрасывать коммиты проекта для сохранения.


## Шаг 5
Для проверки корректности конфигурации и последующего ребилда нужно вывести список
всех flake в директории по заданному пути. Для выполнения команд с конфигурацией flake, нужно чтобы Пользователь
был в корневой директории flake конфигурации.

```shell
>>> nix --extra-experimental-features flakes --extra-experimental-features nix-command flake show .

path:/home/maksim/Desktop/nixos-config?lastModified=1779988771&narHash=sha256-F%2BTtVL5j%2BfjfgnOiRHzg2Viuvse/PQe4NXbrQ%2BmoGwY%3D
└───nixosConfigurations
    └───maksim: NixOS configuration
```

Билд осуществляется под хостом maksim, с добавленными параметрами конфигурации
Nix для разрешения пользования flakes. Загрузка может происходить некоторое продолжительное время.

* !!! Перед билдом системы `необходимо прочитать главу Настройка GNOME окружения`

```shell
>>> sudo env NIX_CONFIG="experimental-features = nix-command flakes" nixos-rebuild build --flake .#maksim

Done. The new configuration is /nix/store/18ppbrvlhmjr8jba6gdp0ms58nis63s5-nixos-system-maksim-25.11.20260526.25f5383
```

Переключаемся на установленный профиль - `sudo nixos-rebuild switch --flake .#maksim`. Перезапускаем систему `reboot`.


## Шаг 6
Дорабатываем Flatpack и его зависимости

1. Проверить что включен Flatpack `services.flatpak.enable = true;` в `gnome.nix`
2. Добавляем репозиторий Flathub
```shell

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```
3. Делаем `reboot`

После перезагрузки устанавливаем зависимости.

```shell
# Используется для изменений системных цветов
flatpak install gradience
```


## Монтирование дисков
### 1 Диск
Для одного диска достаточно выбрать пункт с удалением всех файлов и записью системы на текущий диск.
Рекомендуется включить swap с гибернацией.


### 2+ Дисков
Для 2+ дисков, требуется вручную прописать пути установок, поэтому выбирается `Ручной выбор`.


#### Монтирование системы
Очищаем все пространство диска, и создаем 3 раздела:
1. Раздел с файловой системой `FAT32`, `1024МБ` с точкой присоединения `/boot` и флагом `boot`. Можно задать имя раздела (Метку), например `System`.
2. SWAP файл размер не меньше чем размер ОЗУ + сверху. с системой `linuxswap`.
    * 16ГБ ОЗУ >>> 20ГБ SWAP
    * 32ГБ ОЗУ >>> 36ГБ SWAP
3. Остальное пространство диска системы отдается под систему `ext4` с точкой присоединения `/`.


#### Монтирование второстепенных дисков
После задания пространства для системы, переключаемся на побочные диски.

Если требуется сохранить файлы на диске, то переходим в раздел `NTFS` проверяем пункт
`Содержимое`, должна стоять галочка `оставить`. И монтируем диск в `/mnt/storage`.

Если сохранение файлов не требуется, то очищаем все разделы диска и выбираем весь раздел как:
* `ext4` с точкой присоединения `/mnt/storage` и меткой `_NAME_Storage`, где `_NAME_` лучше написать фирму диска.


## Переключение на готовую обновленную сборку
```
sudo nixos-rebuild switch --flake .#maksim
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


# Настройка Flake файла
## Глобальные
В `modules/gnome.nix` необходимо настроить драйвера для видеокарты.


## PC
Отсутствуют


## Laptop
Для работы необходимо закомментировать в `hosts/root/default.nix` строчки с `game.nix` и `steam.nix`, а также закомментировать строчку `steam` в `packages.nix`. Закомментировать строчки во `flake.nix`, связанные с `AAGL Для лаунчера Genshin Impact`.

```
inputs = {
  ...
  # AAGL Для лаунчера Genshin Impact
  # aagl.url = "github:ezKEa/aagl-gtk-on-nix/release-26.05";
  # aagl.inputs.nixpkgs.follows = "nixpkgs";
};

# Убрать aagl из нижней строчки
outputs = { nixpkgs, home-manager, ... }:
{
	nixosConfigurations.maksim = nixpkgs.lib.nixosSystem {
	  ...
			
   	modules = [
      ...
      # Эту строчку закомментировать
      # aagl.nixosModules.default
      ];
    };
};
```





# Лицензии
1. Для `Happ` модуля был использован и доработан код из репозитория [happ-nixos
](https://github.com/MrShitFox/happ-nixos)
