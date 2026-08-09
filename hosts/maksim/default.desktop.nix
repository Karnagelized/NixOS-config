{ ... }:
{
  imports = [
    # Конфиги
    ../../desktop/modules/hyprland.config.nix

    ../../desktop/configs/git.config.nix
    ../../desktop/configs/zsh.config.nix
    ../../desktop/configs/fastfetch.config.nix
  ];

  home.stateVersion = "25.11";
}
