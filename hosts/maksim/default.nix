{ ... }:
{
  imports = [
    ./configs/git.config.nix
    ./configs/zsh.config.nix
    ./configs/fastfetch.config.nix
  ];

  home.stateVersion = "25.11";
}
