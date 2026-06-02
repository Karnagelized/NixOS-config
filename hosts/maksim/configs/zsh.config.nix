{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zsh
  ];

  home.shellAliases = {
		nix-rebuild = "sudo nixos-rebuild switch --flake .#maksim";
		nix-rebuild-test = "sudo nixos-rebuild test --flake .#maksim";
  };
}
