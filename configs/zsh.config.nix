{ pkgs, ... }:
{
  # Путь до файла конфигурации p10k.zsh
  home.file.".p10k.zsh".source = ../exports/p10k.zsh;

  # Пакеты для zsh
  home.packages = with pkgs; [
    fastfetch
    bat
  ];

  # Альтернативный список lowfi через archive.org, если Chillhop/CDN недоступен.
  home.file.".local/share/lowfi/archive.txt".source = "${pkgs.lowfi.src}/data/archive.txt";

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
      nix-rebuild       = "sudo nixos-rebuild switch --flake .#maksim";
      nix-rebuild-test  = "sudo nixos-rebuild test --flake .#maksim";
      nix-gens          = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
      nix-gens-del      = "sudo nix-collect-garbage -d";
      # Base console commands
      cls   = "printf '\\ec' && fastfetch";
      ls    = "eza --icons";
      # Eza
      la    = "eza --icons -a";
      tree  = "eza --tree --icons --level=2";
      # Быстрый поиск файлов/папок с красивым превью кода прямо в терминале Kitty
      f = "xdg-open $(fzf --preview 'bat --style=numbers --color=always --line-range :500 {} 2>/dev/null || eza --tree --icons --level=2 {}') &>/dev/null";
      # LazySSH
      s     = "TERM=xterm-256color lazyssh";
      # Bat
      cat = "bat";
      # Lofi
      lofi  = "cls && lowfi -s 10 -c -f 30 -m -t archive";
      clofi = "cls && lowfi -s 10 -c -f 30 -m -t chillhop";
      # Docker
      lzd = "lazydocker";
    };
  };
}
