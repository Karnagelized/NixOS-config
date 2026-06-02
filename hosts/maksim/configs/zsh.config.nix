{ ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      nix-rebuild = "sudo nixos-rebuild switch --flake .#maksim";
      nix-rebuild-test = "sudo nixos-rebuild test --flake .#maksim";
      nix-gens = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
      nix-gens-del = "sudo nix-collect-garbage -d";
    };
  };
}
