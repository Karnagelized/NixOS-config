{ pkgs, ... }:
{
  imports =
    [
      # Монтирование дисков
      ../../laptop/base/hardware-configuration.nix

      # Общие настройки NixOS системы
      ../../common/nix.nix
      ../../common/location.nix
      ../../common/printing.nix
      ../../common/fonts.nix
      ../../common/sound.nix
      ../../common/bluetooth.nix
      ../../common/network.nix
      ../../common/docker.nix
      ../../common/services.nix
      ../../common/libs.nix

      # Зависимости под конкретную DE
      ../../laptop/modules/gnome.nix
      ../../laptop/modules/hardware.nix
      ../../laptop/modules/packages.nix
      ../../laptop/modules/keyboard.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Создание аккаунта Пользователя
  users.users.maksim = {
    isNormalUser = true;
    description = "Maksim";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  # Отключаем sudo - командам не требуется sudo
  security.sudo.wheelNeedsPassword = false;

  # Включаем zsh на системном уровне
  programs.zsh.enable = true;

  # Подключение экспериментальных функций
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11";
}
