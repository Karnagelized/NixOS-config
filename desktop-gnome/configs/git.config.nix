{ pkgs, ... }:
{
  home.packages = with pkgs; [
    git
  ];

  programs.git = {
    enable = true;

    settings = {
      user = {
        email = "karnalize@mail.ru";
        name = "Antonov Maksim";
      };

      init = {
        defaultBranch = "main";
      };
    };
  };
}