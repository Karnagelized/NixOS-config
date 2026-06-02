{ pkgs, ... }:
{
  home.packages = with pkgs; [
    git
  ];

  programs.git = {
    enable = true;

    userName = "Antonov Maksim";
    userEmail = "karnalize@mail.ru";

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
}