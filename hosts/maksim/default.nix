{ ... }:
{
  imports = [
    ././hosts/maksim/configs/git.config.nix
    ././hosts/maksim/configs/zsh.config.nix
  ];

  system.stateVersion = "25.11";
}
