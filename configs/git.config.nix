{ pkgs, ... }:
{
  home.packages = with pkgs; [
    git
  ];

  programs.git = {
    enable = true;

    settings = {
      core = {
        quotepath = false;
      };

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