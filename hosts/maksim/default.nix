{ ... }:
{
  imports = [
    ./configs/git.config.nix
    ./configs/zsh.config.nix
  ];

  home.stateVersion = "25.11";
}
