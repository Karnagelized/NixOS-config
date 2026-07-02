{ pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nix.nix
      ../../modules/gnome.nix
      ../../modules/packages.nix
      ../../modules/libs.nix
      ../../modules/bluetooth.nix
      ../../modules/network.nix
      ../../modules/location.nix
      ../../modules/printing.nix
      ../../modules/sound.nix
      ../../modules/keyboard.nix
      ../../modules/fonts.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Создание аккаунта Пользователя
  users.users.maksim = {
    isNormalUser = true;
    description = "Maksim";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

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
