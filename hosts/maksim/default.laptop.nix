{ ... }:
{
  imports = [
    # Конфиги
    ../../laptop/configs/git.config.nix
    ../../laptop/configs/zsh.config.nix
    ../../laptop/configs/fastfetch.config.nix
    ../../laptop/configs/gnome-binds.config.nix
  ];

  home.stateVersion = "25.11";
}
