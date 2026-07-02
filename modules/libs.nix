{ pkgs, ... }:

let
  # Библиотеки Nix
  nixLibs = with pkgs; [
    # Базовые библиотеки компилятора
    stdenv.cc.cc.lib
    zlib

    # Библиотеки X11 для работы графического интерфейса (исправляет libXext.so.6)
    xorg.libXext
    xorg.libX11
    xorg.libXrender
    xorg.libXtst
    xorg.libXi

    # Шрифты и рендеринг текста
    freetype
    fontconfig
  ];
in {
  # Разрешение запускать готовые скомпилированные программы из других дистрибутивов
  programs.nix-ld.enable = true;

  # Слияние всех библиотек в одно окружение
  programs.nix-ld.libraries =
    nixLibs;
}
