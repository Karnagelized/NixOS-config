{ pkgs, ... }:
{
  # Путь до файла конфигурации p10k.zsh
  home.file.".p10k.zsh".source = ../../../utils/p10k.zsh;

  # Пакеты для zsh
  home.packages = with pkgs; [
    fastfetch
    bat
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "";

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

    # Первоначальная заставка
    initContent = ''
      export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      fastfetch
    '';

    # Псевдонимы
    shellAliases = {
      # Nix
      nix-rebuild = "sudo nixos-rebuild switch --flake .#maksim";
      nix-rebuild-test = "sudo nixos-rebuild test --flake .#maksim";
      nix-gens = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
      nix-gens-del = "sudo nix-collect-garbage -d";
      # Console
      cls = "clear && fastfetch && source ~/.p10k.zsh";
      clear = "cls";
      cat = "bat";
    };
  };
}
