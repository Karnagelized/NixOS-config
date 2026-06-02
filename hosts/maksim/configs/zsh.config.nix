{ ... }:
{
  programs.zsh = {
    enable = true;

    shellAliases = {
      nix-rebuild = "sudo nixos-rebuild switch --flake .#maksim";
      nix-rebuild-test = "sudo nixos-rebuild test --flake .#maksim";
    };
  };
}
