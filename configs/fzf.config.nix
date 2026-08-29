{ pkgs, ... }:
{
programs.fzf = {
    enable = true;

    # Автоматически связывает fzf с вашим Zsh
    enableZshIntegration = true;

    # Настраиваем цвета fzf под тему Nord
    colors = {
      bg      = "-1";
      fg      = "#d8dee9";
      "fg+"   = "#e5e9f0";
      "preview-fg" = "#d8dee9";
      hl      = "#81a1c1";
      "hl+"   = "#88c0d0";
      info    = "#e5e9f0";
      prompt  = "#7cd5be";
      pointer = "#7cd5be";
      marker  = "#bf616a";
      spinner = "#b48ead";
      header  = "#81a1c1";
    };
  };
}