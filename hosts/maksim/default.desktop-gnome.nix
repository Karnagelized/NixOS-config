{ ... }:
{
  imports = [
    # Конфиги
    ../../desktop-gnome/configs/git.config.nix
    ../../desktop-gnome/configs/zsh.config.nix
    ../../desktop-gnome/configs/fastfetch.config.nix
    ../../desktop-gnome/configs/gnome-binds.config.nix
  ];

  home.stateVersion = "25.11";
}
