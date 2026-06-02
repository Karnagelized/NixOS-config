{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "sorin";

      plugins = [
        "git"
        "sudo"
        "docker"
        "docker-compose"
        "systemd"
        "extract"
        "colored-man-pages"
      ];
    };

    shellAliases = {
      # Nix
      nix-rebuild = "sudo nixos-rebuild switch --flake .#maksim";
      nix-rebuild-test = "sudo nixos-rebuild test --flake .#maksim";
      nix-gens = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
      nix-gens-del = "sudo nix-collect-garbage -d";
      # Console
      cls = "clear";
    };
  };
}
