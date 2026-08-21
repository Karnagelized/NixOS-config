{ pkgs, ... }:

let
  # Библиотеки Nix
  nixLibs = with pkgs; [
    # Базовые библиотеки компилятора
    stdenv.cc.cc.lib
    zlib
    glib

    # Библиотеки X11 и Wayland для графического интерфейса
    libxkbcommon
    wayland
    libXext
    libX11
    libXrender
    libXtst
    libXi
    xorg.libXcursor
    xorg.libXrandr

    # Шрифты и рендеринг текста
    freetype
    fontconfig
  ];
in {
  # Разрешение запускать готовые скомпилированные программы из других дистрибутивов
  programs.nix-ld.enable = true;

  # Слияние всех библиотек в одно окружение
  programs.nix-ld.libraries = nixLibs;
}
