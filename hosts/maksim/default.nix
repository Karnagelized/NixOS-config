{ ... }:
{
  imports = [
    # Конфиги
    ../../configs/git.config.nix
    ../../configs/zsh.config.nix
    ../../configs/fastfetch.config.nix
    ../../configs/gnome-binds.config.nix
  ];

  home.stateVersion = "25.11";
}
